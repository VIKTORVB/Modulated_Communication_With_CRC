----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Symbol Converter Test Bench
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T03_M3_TB_SymbolConverter is
end T03_M3_TB_SymbolConverter;

architecture Behavioral of T03_M3_TB_SymbolConverter is
-- inputs
  signal i_Clk: STD_LOGIC; -- clock
  signal i_CE: STD_LOGIC; -- Clock enable
  signal i_Rst: STD_LOGIC;
  signal i_Start_Stop :  STD_LOGIC;
  signal i_Data_Select :  STD_LOGIC_VECTOR(3 downto 0);
  signal i_Data_4_bit: STD_LOGIC_VECTOR (3 downto 0); -- data in
  signal i_Data_6_bit : STD_LOGIC_VECTOR(5 downto 0);        
  signal i_Display_Select : STD_LOGIC_VECTOR (2 downto 0);  
   -- outputs
  signal o_Symbol: STD_LOGIC_VECTOR (1 downto 0); -- data out
  signal o_Data_2_bit_0 : STD_LOGIC_VECTOR (3 downto 0);
  signal o_Data_2_bit_1 : STD_LOGIC_VECTOR (3 downto 0);
  signal o_LED11 : STD_LOGIC;
  signal o_LED10 : STD_LOGIC;  
  -- constants
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns;
 
begin
  
  uut : entity work.T03_M3_SymbolConverter(Behavioral)
    port map(
    i_Clk=>i_Clk,i_Rst => i_Rst ,i_CE => i_CE, i_Data_4_bit => i_Data_4_bit, i_Data_6_bit => i_Data_6_bit, 
    i_Display_Select => i_Display_Select, o_Symbol => o_Symbol, o_Data_2_bit_0 => o_Data_2_bit_0, o_Data_2_bit_1 => o_Data_2_bit_1, 
    i_Data_Select => i_Data_Select, i_Start_Stop => i_Start_Stop );
            
    i_Start_Stop <= '1';
  --  i_Data_Select <= "0001";
   masterClk : process
    begin
    i_Clk <= '0';
    wait for Clk_period/2;
    i_Clk <= '1';
    wait for Clk_period/2;
    end process masterClk;
    
    display_sel : process    
    begin
      i_Display_Select <= "000";  
      wait for 600 ns;
      i_Display_Select <= "101";
      wait for 600 ns;
    end process display_sel;
   
    CE_TB : process
    begin
    i_CE <= '0';
    wait for CE_period/2;
    o_LED11 <= '1'; 
    o_LED10 <= '0';
    i_CE <= '1';  
    wait for CE_period/2;
    o_LED11 <= '0'; 
    o_LED10 <= '1';    
    end process CE_TB;
   
   NumbGeneratot: process
   begin
    for i in 0 to 3 loop
     if (i = 0) then
      i_Data_4_bit <= "0001";
      i_Data_6_bit <= "011001";
      wait for CE_period*4;
     elsif (i = 1) then
     i_Data_4_bit <= "0111";
     i_Data_6_bit <= "110010";     
     wait for CE_period*4;
     elsif (i = 2) then
     i_Data_4_bit <= "1110";
     i_Data_6_bit <= "101010";
     wait for CE_period*4;
     elsif (i = 3) then
     i_Data_4_bit <= "1000";
     i_Data_6_bit <= "000101";     
     wait for CE_period*4;
     end if;
    end loop;
   end process;  
end Behavioral;
