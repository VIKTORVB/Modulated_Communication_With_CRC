----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Data Generator entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the data generatot entity block
entity T03_M3_DataGen is
    Port (--inputs
          i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset 
          i_CE : in STD_LOGIC; -- clock enable signal at 1Hz
          i_Start_Stop : in STD_LOGIC; -- stat/stop latch
          i_Data_Select : in STD_LOGIC_VECTOR(3 downto 0); -- 4-bit data select value
          i_Counter : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit counter value
          i_StudentNum : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit student number value
          i_Rand_num : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit random number value
          --outputs
          o_Select_Value: out STD_LOGIC_VECTOR (3 downto 0); -- Data Select value
          o_Data_4_bit : out STD_LOGIC_VECTOR (3 downto 0)); -- 4-bit value to be converted
end T03_M3_DataGen;
-- architecure declaration for the data generator
architecture Behavioral of T03_M3_DataGen is
    -- declaration  of 4-bit registers to hold the input values during the process
    signal r_Select_Value : STD_LOGIC_VECTOR (3 downto 0);
    signal r_counter_value : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal r_4_bit : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal r_rand_num : STD_LOGIC_VECTOR (3 downto 0);
    signal r_student_no : STD_LOGIC_VECTOR (3 downto 0);
begin
    -- allocate all the inputs to their corresponding registers
    r_student_no <= i_StudentNum;
    r_counter_value <= i_Counter;
    r_rand_num <= i_Rand_num;
    -- start data generation
    Data_gen : process (i_Clk, i_CE, i_Rst, i_Data_Select, i_Start_Stop) -- include required signals
    begin
        if (i_Rst = '1') then -- if Reset is set
            r_4_bit <= (others => '0'); -- clear register
            r_Select_Value <= "0000"; -- set select value to zero
        elsif (rising_edge (i_Clk)) then -- on the rising edge of the master clock
            if (i_Start_Stop = '1') then  -- if the start/stop latch is set
             if (i_CE = '1') then
               case i_Data_Select is
               -- in this process we are checking which switch is active and allocate
               -- the corresponding static/cyclic value to a data register which will set the output
               -- we are also setting the correct value for the data select value register
                   when "0000" => r_4_bit <= "0001"; r_Select_Value <= "0000";       -- Switch 12
                   when "0001" => r_4_bit <= "0111"; r_Select_Value <= "0001";      -- Switch 13
                   when "0010" => r_4_bit <= "1110"; r_Select_Value <= "0010";      -- Switch 14
                   when "0011" => r_4_bit <= "1000"; r_Select_Value <= "0011";      -- Switch 15
                   when "0100" => r_4_bit <= r_counter_value; r_Select_Value <= "0100"; -- Switch 12+13
                   when "0101" => r_4_bit <= r_rand_num; r_Select_Value <= "0101"; -- Switch 12+14
                   when "0110" => r_4_bit <= r_student_no; r_Select_Value <= "0110"; -- Switch 12+15
                   when "0111" => r_4_bit <= r_student_no; r_Select_Value <= "0111"; -- Switch 12+13+14
                   when others => r_4_bit <= "0000"; r_Select_Value <= "0000";    
               end case;
              end if; 
            elsif (i_Start_Stop = '0') then -- if the start/stop latch is cleared
                r_4_bit <= "0000"; -- clear the data register
                r_Select_Value <= "0000"; -- clear the data select value register
         end if;          
        end if;
    end process;
    -- allocate the stored register values to the correct outputs
    o_Select_Value <= r_Select_Value;
    o_Data_4_bit <= r_4_bit;
end Behavioral;