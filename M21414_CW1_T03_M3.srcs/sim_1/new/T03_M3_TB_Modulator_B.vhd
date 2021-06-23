-----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Modulator B test bench
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-----------------------------------------------------------------------
entity T03_M3_TB_Modulator_B is
end T03_M3_TB_Modulator_B;
-----------------------------------------------------------------------
architecture Behavioral of T03_M3_TB_Modulator_B is
-- inputs
  signal i_Clk: std_logic; -- clock
  signal i_CE: std_logic; -- Clock enable
  signal i_Rst: std_logic; -- reset button
  signal i_Symbol :  STD_LOGIC_VECTOR(1 downto 0); -- 2 bit data symbol
-- outputs
  signal o_mod_B_I : STD_LOGIC_VECTOR (7 downto 0):= (others => '0');
  signal o_mod_B_Q : STD_LOGIC_VECTOR (7 downto 0):= (others => '0');
-- constants
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns;
---------------------------------------------------------------------
begin
 uut : entity work.T03_M3_Modulator_B(Behavioral)
 Port map(i_Clk => i_Clk,i_Rst => i_Rst ,i_CE => i_CE,
 i_Symbol => i_Symbol, o_mod_B_I => o_mod_B_I, o_mod_B_Q => o_mod_B_Q);
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
--    reset_TB : process
--    begin
--    i_Rst <= '0';
--    wait for 20 ns;
--    i_Rst <= '1';
--    wait for 10 ns;
--    i_Rst <= '0';
--    wait for 190 ns;
--    i_Rst <= '1';
--    wait for 10 ns;
--    i_Rst <= '0';
--    wait;
--    end process reset_TB;
-----------------------------------------------------    
   input_select: process
   begin
    for i in 0 to 3 loop
     if (i = 0) then
        i_Symbol <= "00";
        wait for 200ns;
     elsif (i = 1) then
        i_Symbol <= "10";
        wait for 200ns;
     elsif (i = 2) then
        i_Symbol <= "11";
        wait for 200ns;
     elsif (i = 3) then
        i_Symbol <= "01";
        wait for 200ns;     
     end if;
    end loop;
   end process;    
end Behavioral;
