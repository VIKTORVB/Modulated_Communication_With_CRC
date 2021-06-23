----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Random number entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the random number entity block
entity T03_M3_Random_num is
    Port (--inputs
          i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset inputs
          i_CE : in STD_LOGIC; -- clock enable signal at 0.25Hz
          i_Data_Select : in STD_LOGIC_VECTOR (3 downto 0); -- data select input
          --output
          o_Rand_num : out STD_LOGIC_VECTOR (3 downto 0)); -- 4-bit binary output
end T03_M3_Random_num;
-- architecure declaration for the random number generator
architecture Behavioral of T03_M3_Random_num is
    signal r_rand_num : STD_LOGIC_VECTOR (3 downto 0);
    signal r_rand_factor : STD_LOGIC;
begin
    -- in this process we are using a linear-feedback shift register
    -- where we set the single bit r_rand_factor, whose value is dependant
    -- on the two MSBs of the 4-bit r_rand_num vector
    -- by doing so we can achieve pseudo-random numbers 
    r_rand_factor <= not(r_rand_num(3) xor r_rand_num(2)); 
    rand_gen : process (i_Clk, i_Rst)
    begin
        if(i_Rst = '1') then -- if Reset is set
           r_rand_num <= (others => '0'); -- clear all the values of the register
        elsif(rising_edge (i_Clk)) then -- on the rising edge of the master clock
          if (i_CE = '1')then  -- when clock enable is high
            r_rand_num <= r_rand_num (2 downto 0) & r_rand_factor; -- generate the random number 
          end if;
        end if;   
    end process;
    o_Rand_num <= r_rand_num; -- allocate the random number to the output signal
end Behavioral;