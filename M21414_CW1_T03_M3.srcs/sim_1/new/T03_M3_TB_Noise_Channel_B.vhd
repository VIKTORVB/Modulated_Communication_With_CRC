----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Noise Channel - B test bench
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--------------------------------
entity T03_M3_TB_Noise_Channel_B is
end T03_M3_TB_Noise_Channel_B;
-------------------------------------------------------
architecture Behavioral of T03_M3_TB_Noise_Channel_B is
-- inputs
  signal i_Clk, i_CE, i_Rst: std_logic; -- master clock, clock enable and reset inputs
  signal i_Error_16 : STD_LOGIC_VECTOR (3 downto 0) := "1010"; -- 4-bit error value
  signal i_Error_32 : STD_LOGIC_VECTOR (4 downto 0) :="11110"; -- 5-bit error value
  signal i_Error_64 : STD_LOGIC_VECTOR (5 downto 0):="110110"; -- 6-bit error value
  signal i_mod_B_I : STD_LOGIC_VECTOR (7 downto 0) := x"80"; -- I_channel input
  signal i_mod_B_Q : STD_LOGIC_VECTOR (7 downto 0) := x"A0"; -- Q_channel input
  signal i_Error_Select : STD_LOGIC_VECTOR (1 downto 0) :="00"; -- debounced error select
-- outputs
  signal o_channel_I_noise : STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
  signal o_channel_Q_noise : STD_LOGIC_VECTOR (7 downto 0); -- Q channel with additional noise  
-- constants
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns;  
-------------------------------------  
begin
    uut : entity work.T03_M3_Noise_Channel_B(Behavioral)
    Port map(i_Clk => i_Clk,i_Rst => i_Rst ,i_CE => i_CE,
    i_Error_16 => i_Error_16, i_Error_32 => i_Error_32, i_Error_64 => i_Error_64,
    i_mod_B_I => i_mod_B_I, i_mod_B_Q => i_mod_B_Q, i_Error_Select => i_Error_Select,
    o_channel_I_noise => o_channel_I_noise, o_channel_Q_noise => o_channel_Q_noise);
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
   errer_select: process
   begin
    for i in 0 to 3 loop
     if (i = 0) then
        i_Error_Select <= "00";
        wait for 60ns;
     elsif (i = 1) then
        i_Error_Select <= "01";
        wait for 60ns;
     elsif (i = 2) then
        i_Error_Select <= "10";
        wait for 60ns;
     elsif (i = 3) then
        i_Error_Select <= "11";
        wait for 60ns;     
     end if;
    end loop;
   end process;
end Behavioral;
