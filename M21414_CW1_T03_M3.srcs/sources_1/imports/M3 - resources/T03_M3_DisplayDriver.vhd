----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Seven-segment Decoder entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1  
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--  declaration of the seven-segment decoder entity block
entity T03_M3_DisplayDriver is
    Port ( -- input
          i_valueRead: in std_logic_vector (3 downto 0); -- 4 bit value read from the multiplexer
           -- outputs
           o_SegmentDP : out STD_LOGIC; -- 7-segment display's decimal point cathode
           o_SegmentCathodes : out STD_LOGIC_VECTOR (6 downto 0)); -- 
end T03_M3_DisplayDriver;
-- architecture body of the seven-segment decoder
architecture Behavioral of T03_M3_DisplayDriver is
begin
        -- drive the seven segment display based on the values read from multiplexer
        with i_valueRead select -- display LEDs to turn on // value to display
        o_SegmentCathodes <= "1000000" when "0000", -- 0
                             "1111001" when "0001", -- 1
                             "0100100" when "0010", -- 2
                             "0110000" when "0011", -- 3
                             "0011001" when "0100", -- 4
                             "0010010" when "0101", -- 5
                             "0000010" when "0110", -- 6
                             "1111000" when "0111", -- 7
                             "0000000" when "1000", -- 8
                             "0010000" when "1001", -- 9
                             "0001000" when "1010", -- A
                             "0000011" when "1011", -- B
                             "1000110" when "1100", -- C
                             "0100001" when "1101", -- D
                             "0000110" when "1110", -- E
                             "0001110" when "1111", -- F
                             "1111111" when others; -- "catch" statement, in case of an unexpected input value
        -- flash decimal point at roll-over, in this case when we are turning off displaying  
        o_SegmentDP <= '0' when i_valueRead = "1111" else '1';  
end Behavioral;