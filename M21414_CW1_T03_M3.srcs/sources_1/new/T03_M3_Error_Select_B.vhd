----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Error Select-B entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the Error Select - B entity block ------------------------------
entity T03_M3_Error_Select_B is
    Port (--inputs
          i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset inputs
          i_CE : in STD_LOGIC; -- 100 Hz clock enable signal
          --output
          o_Error_16 : out STD_LOGIC_VECTOR (3 downto 0); -- 4-bit binary output
          o_Error_32 : out STD_LOGIC_VECTOR (4 downto 0); -- 5-bit binary output
          o_Error_64 : out STD_LOGIC_VECTOR (5 downto 0)); -- 6-bit binary output
end T03_M3_Error_Select_B;
-- architecure declaration for the Error Select - B entity block ------------------
architecture Behavioral of T03_M3_Error_Select_B is
    signal r_error_16 : STD_LOGIC_VECTOR (3 downto 0);
    signal r_error_32 : STD_LOGIC_VECTOR (4 downto 0);
    signal r_error_64 : STD_LOGIC_VECTOR (5 downto 0);
    signal r_error_factor_16 : STD_LOGIC;
    signal r_error_factor_32 : STD_LOGIC;
    signal r_error_factor_64 : STD_LOGIC;
------------------------------------------------------------------------------    
begin
    -- in this process we are using a linear-feedback shift register
    -- where we set a single bit error factor, that's value is dependant
    -- on two bits of the error vector, with the use of the correct 
    -- tapping points so we can achieve pseudo-random numbers 
    r_error_factor_16 <= not(r_error_16(3) xor r_error_16(0));
    r_error_factor_32 <= not(r_error_32(4) xor r_error_32(1)); 
    r_error_factor_64 <= not(r_error_64(5) xor r_error_64(0)); 
------------------------------------------------------------------------------         
    rand_gen : process (i_Clk, i_Rst) -- process of random error generation with the required signals
    begin
        if(i_Rst = '1') then -- if Reset is set
           r_error_16 <= (others => '0'); -- clear all the values of the register
           r_error_32 <= (others => '0'); -- clear all the values of the register
           r_error_64 <= (others => '0'); -- clear all the values of the register           
        elsif(rising_edge (i_Clk)) then -- on the rising edge of the master clock
          if (i_CE = '1') then  -- when clock enable is high
              r_error_16 <= r_error_16 (2 downto 0) & r_error_factor_16; -- generate the 4 bit error value
              r_error_32 <= r_error_32 (3 downto 0) & r_error_factor_32; -- generate the 5 bit error value
              r_error_64 <= r_error_64 (4 downto 0) & r_error_factor_64; -- generate the 6 bit error value
          end if;
        end if;   
    end process;
    o_Error_16 <= r_error_16; -- allocate the 4 bit error value to the output signal
    o_Error_32 <= r_error_32; -- allocate the 5 bit error value to the output signal
    o_Error_64 <= r_error_64; -- allocate the 6 bit error value to the output signal
end Behavioral;