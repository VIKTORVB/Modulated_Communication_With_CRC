----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Multiplexer testbench 
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1  
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T03_M3_TB_MUX is
end T03_M3_TB_MUX;
--
architecture Behavioral of T03_M3_TB_MUX is
-- input
    signal i_Clk, i_CE : STD_LOGIC;
    signal i_Rst : STD_LOGIC;
    signal i_digitSelect : integer range 0 to 3;
    signal i_Display_Select : STD_LOGIC_VECTOR(2 downto 0) :="-00";
    signal i_Select_Value : STD_LOGIC_VECTOR (3 downto 0) := "1100";
    signal i_Data_4_bit : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    signal i_Data_2_bit_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal i_Data_2_bit_1 : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal i_Data_Rx : STD_LOGIC_VECTOR(3 downto 0) := "0011";
-----------Mod Scheme A inputs-------------------------------------------------------------------------------------------          
--          i_I_Modulated : in STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
--          i_Q_Modulated : in STD_LOGIC_VECTOR (7 downto 0); -- Q channel with additional noise
--          i_I_Noise : in STD_LOGIC_VECTOR (7 downto 0); -- modulated I channel data sequence
--          i_Q_Noise : in STD_LOGIC_VECTOR (7 downto 0); -- modulated Q channel data sequence        
-----------Mod Scheme B inputs-------------------------------------------------------------------------------------------          
    signal i_channel_I_noise : STD_LOGIC_VECTOR (7 downto 0) := "10011100"; -- I channel with additional noise
    signal i_channel_Q_noise : STD_LOGIC_VECTOR (7 downto 0) :="00110101"; -- Q channel with additional noise
    signal i_mod_B_I : STD_LOGIC_VECTOR (7 downto 0) :="11110000"; -- modulated I channel data sequence
    signal i_mod_B_Q : STD_LOGIC_VECTOR (7 downto 0) :="00110011"; -- modulated Q channel data sequence    
-- outputs
   signal o_valueRead : STD_LOGIC_VECTOR (3 downto 0);
   signal o_SegmentAnode : STD_LOGIC_VECTOR (3 downto 0);
-- constants  
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns;   
begin
    uut : entity work.T03_M3_MUX(Behavioral)
        Port map(i_Clk=>i_Clk, i_Rst => i_Rst, i_Data_Rx => i_Data_Rx, i_digitSelect => i_digitSelect, i_Select_Value => i_Select_Value,
        i_channel_I_noise => i_channel_I_noise, i_channel_Q_noise => i_channel_Q_noise, i_mod_B_I => i_mod_B_I, i_mod_B_Q => i_mod_B_Q,
        i_Display_Select => i_Display_Select,i_Data_4_bit => i_Data_4_bit, i_Data_2_bit_0 => i_Data_2_bit_0,
        i_Data_2_bit_1 => i_Data_2_bit_1, o_valueRead => o_valueRead, o_SegmentAnode => o_SegmentAnode);
------------------------------------------------------
   masterClk : process
    begin
    i_Clk <= '0';
    wait for Clk_period/2;
    i_Clk <= '1';
    wait for Clk_period/2;
    end process masterClk;
-----------------------------------------------------   
    display_input : process
    begin 
        for i in 0 to 3 loop
            case i is 
                when 0 => i_Display_Select <= "000"; wait for 240 ns;
                when 1 => i_Display_Select <= "110"; wait for 240 ns;
                when 2 => i_Display_Select <= "101"; wait for 240 ns;
                when 3 => i_Display_Select <= "111"; wait for 240 ns;
            end case;
        end loop;
    end process display_input;
-----------------------------------------------------   
    sel_input : process
    begin 
        for i in 0 to 3 loop
            case i is 
                when 0 => i_digitSelect <= 0; wait for 60 ns;
                when 1 => i_digitSelect <= 1; wait for 60 ns;
                when 2 => i_digitSelect <= 2; wait for 60 ns;
                when 3 => i_digitSelect <= 3; wait for 60 ns;
            end case;
        end loop;
    end process sel_input;
 end Behavioral;