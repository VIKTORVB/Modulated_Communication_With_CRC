----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Counter 0-F entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- declaration of the 0-F counter entity block
entity T03_M3_Counter_0_F is
    Port(--inputs
         i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset
         i_CE : in STD_LOGIC; -- clock enable signal at 1Hz
         i_Data_Select : in STD_LOGIC_VECTOR(3 downto 0); -- data select input
         --output
         o_Counter : out STD_LOGIC_VECTOR (3 downto 0)); -- 4-bit binary output
end T03_M3_Counter_0_F;
-- architecure declaration for the 0-F counter
architecture Behavioral of T03_M3_Counter_0_F is
    -- declaration of integer counter with its predifined range
    signal r_counter : integer range 0 to 15;
begin
    -- start of the counting process
    count : process (i_Clk, i_CE, i_Rst, i_Data_Select) -- include the required signals
    begin
        if (i_Rst = '1') then -- when Reset is set
            r_counter <= 0; -- clear the counter
        elsif (rising_edge (i_Clk)) then -- on the rising edge of the master clock
            if (i_CE = '1') then -- when the clock enable signal is high
               if (i_Data_Select = "0100") and (r_counter < 15) then -- with the correct input value and whe the counter hasn't reached its max value
                  r_counter <= r_counter +1; -- start counting in single increments 
               else -- otherwise
                  r_counter <= 0; -- clear the counter
               end if;
            end if;
        end if;
    end process;
    -- convert the integer value of the counter to a 4-bit binary output
    o_Counter <= STD_LOGIC_VECTOR(TO_UNSIGNED (r_counter, o_Counter'length));
end Behavioral;
