----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Select Counter entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--  declaration of the counter entity block
entity T03_M3_SelectCounter is
    Port ( -- inputs
           i_Clk, i_Rst : in STD_LOGIC; -- master clock signal and reset bttn
           i_CE : in STD_LOGIC; -- clock enable signal
           -- output
           o_digitSelect : out STD_LOGIC_VECTOR(1 downto 0)); -- counter output with a pre-set range
end T03_M3_SelectCounter;
-- acrchitecture body of counter
architecture Behavioral of T03_M3_SelectCounter is
    -- declare register for select counter
    signal r_Select_count : integer range 0 to 3;
    -- declare max count value for select counter
   constant r_max_count : integer :=3;
begin
    -- start process of the select counter
    countSelect : process (i_Clk, i_Rst, i_CE)-- include the required signals 
    begin
        if (i_Rst = '1') then -- check if Reset button is set
           r_Select_count <= 0; -- set counter to zero
        elsif (rising_edge (i_Clk)) then -- start counting on the risign edge of the master clock
            if (i_CE = '1' ) then -- if clock enable is high
                if (r_Select_count < r_max_count) then -- and counter hasn't reached the max value
                    r_Select_count <= r_Select_count +1; -- increment by one
                else
                   r_Select_count <= 0;   -- max count is reached, reset the counter
                end if;
            end if;
        end if;
     end process countSelect;
     o_digitSelect <=STD_LOGIC_VECTOR ( TO_UNSIGNED (r_Select_count, o_digitSelect ' length)) ; -- assign the counter register value to the output 
end Behavioral;