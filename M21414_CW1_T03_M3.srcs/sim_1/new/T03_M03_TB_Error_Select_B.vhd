----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Error Select-B test bench
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-------------------------------------
entity T03_M03_TB_Error_Select_B is
end T03_M03_TB_Error_Select_B;
-------------------------------------
architecture Behavioral of T03_M03_TB_Error_Select_B is
-- inputs
  signal i_Clk, i_CE, i_Rst: std_logic; -- master clock, clock enable and reset inputs
-- outputs
  signal o_Error_16 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- 4-bit error value
  signal o_Error_32 : STD_LOGIC_VECTOR (4 downto 0) := (others => '0'); -- 5-bit error value
  signal o_Error_64 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0'); -- 6-bit error value
-- constants  
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns;
begin
    uut : entity work.T03_M3_Error_Select_B(Behavioral)
    Port map(i_Clk => i_Clk,i_Rst => i_Rst ,i_CE => i_CE,
    o_Error_16 => o_Error_16, o_Error_32 => o_Error_32, o_Error_64 => o_Error_64);
------------------------------------------------------
   masterClk : process
    begin
    i_Clk <= '0';
    wait for Clk_period/2;
    i_Clk <= '1';
    wait for Clk_period/2;
    end process masterClk;
-----------------------------------------------------   
    CE_TB : process
    begin
    i_CE <= '0';
    wait for CE_period/2;
    i_CE <= '1';  
    wait for CE_period/2;
    end process CE_TB;
-----------------------------------------------------    
    reset_TB : process
    begin
        i_Rst <= '0';
        wait for 5ns;
        i_Rst <= '1';
        wait for 5ns;
        i_Rst <= '0';
        wait;
    end process reset_TB;
-----------------------------------------------------    
end Behavioral;
