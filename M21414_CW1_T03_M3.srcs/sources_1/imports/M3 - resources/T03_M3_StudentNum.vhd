----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Student number entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the student number converter entity block
entity T03_M3_StudentNum is
    Port(--inputs
         i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset
         i_CE : in STD_LOGIC; -- clock enable signal at 0.25Hz
         i_Data_Select : in STD_LOGIC_VECTOR(3 downto 0); -- data select input
         --output
         o_StudentNum : out STD_LOGIC_VECTOR (3 downto 0)); -- converted 4-bit binary output
end T03_M3_StudentNum;
-- architecure declaration for the student number converter
architecture Behavioral of T03_M3_StudentNum is
        signal r_counter : integer range 0 to 5 :=0; -- integer register to loop through the 6 digits of the student number
        signal r_student_num : STD_LOGIC_VECTOR(3 downto 0); -- 4-bit vector that holds the converted binary value
begin
    -- start the process of the student number conversion
    number_converter : process (i_Clk, i_Rst, i_CE, i_Data_Select) -- include required signals
    begin
        if (i_Rst = '1') then -- if Reset is set
           r_counter <= 0; -- and the counter
           r_student_num <= "0000";
        elsif (rising_edge (i_Clk)) then -- on the rising edge of the master clock
            if (i_CE = '1') then -- when the clock enable signal is high
                if( i_Data_select /="0110") and (i_Data_select /="0111") then -- if the data select input doesn't match the predifined values
                r_counter <= 0; -- and the counter
                r_student_num <= "0000";
                elsif (i_Data_Select = "0110" and r_counter <= 5) then -- if the input value is correct and counter hasn't reached its max value
                    case r_counter is -- loop through the 6 digit student number
                        when 0 => r_student_num <= "1001"; r_counter <= r_counter +1; -- for each iteration, allocate the corresponding binary value of the
                        when 1 => r_student_num <= "0000"; r_counter <= r_counter +1; -- student number to the 4-bit register and increment the counter by one
                        when 2 => r_student_num <= "0000"; r_counter <= r_counter +1;
                        when 3 => r_student_num <= "0110"; r_counter <= r_counter +1;
                        when 4 => r_student_num <= "0001"; r_counter <= r_counter +1;
                        when 5 => r_student_num <= "0101"; r_counter <= 0;  -- for the last iteration clear the counter to start again
                        when others => r_student_num <= "0000"; r_counter <= 0; -- "catch" statement, in case there's an unexpected state
                    end case;
                elsif (i_Data_Select = "0111" and r_counter <= 5) then -- if the input value is correct and counter hasn't reached its max value
                    case r_counter is -- loop through the 6 digit student number
                        when 0 => r_student_num <= "1001"; r_counter <= r_counter +1; -- for each iteration, allocate the corresponding binary value of the
                        when 1 => r_student_num <= "0000"; r_counter <= r_counter +1; -- student number to the 4-bit register and increment the counter by one
                        when 2 => r_student_num <= "0001"; r_counter <= r_counter +1;
                        when 3 => r_student_num <= "0000"; r_counter <= r_counter +1;
                        when 4 => r_student_num <= "0111"; r_counter <= r_counter +1;
                        when 5 => r_student_num <= "0000"; r_counter <= 0; -- for the last iteration clear the counter to start again
                        when others => r_student_num <= "0000"; r_counter <= 0; -- "catch" statement, in case there's an unexpected state
                    end case;
                end if;
            end if;
        end if;
    end process;
    o_StudentNum <= r_student_num; -- allocate the 4-bit register to the output signal 
end Behavioral;
