----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Multiply Accumulate - B test bench
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--------------------------------
entity T03_M3_TB_Multiply_Acc_B is
end T03_M3_TB_Multiply_Acc_B;
-----------------------------------------------------
architecture Behavioral of T03_M3_TB_Multiply_Acc_B is
-- inputs
    signal i_Clk, i_CE, i_Rst : STD_LOGIC; 
    signal i_channel_I_noise : STD_LOGIC_VECTOR (7 downto 0) := x"00";
    signal i_channel_Q_noise : STD_LOGIC_VECTOR (7 downto 0) := x"00";
    signal i_start_bit : STD_LOGIC; 
-- outputs
    signal o_acc_I : STD_LOGIC_VECTOR (17 downto 0);
    signal o_acc_Q : STD_LOGIC_VECTOR (17 downto 0);
    signal o_Sym_Rx : STD_LOGIC_VECTOR(1 downto 0);
-- constants
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns; 
--------------------------------------------------------
begin
    uut : entity work.T03_M3_Multiply_Acc_B(Behavioral)
    Port map (i_Clk => i_Clk, i_Rst => i_Rst ,i_CE => i_CE, i_start_bit => i_start_bit, 
    i_channel_I_noise => i_channel_I_noise, i_channel_Q_noise => i_channel_Q_noise,
    o_acc_I => o_acc_I, o_acc_Q => o_acc_Q, o_Sym_Rx => o_Sym_Rx);
-------------------------------------------------------
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
    input_change : process
    begin
    for i in 0 to 35 loop
     if (i = 0) then
        i_start_bit <= '1';
        i_channel_I_noise <= x"80";
        i_channel_Q_noise <= x"80";
        wait for 60ns;
     elsif (i = 1) then
        i_channel_I_noise <= x"A0";
        i_channel_Q_noise <= x"80";
        wait for 60ns;
     elsif (i = 2) then
        i_channel_I_noise <= x"C0";
        i_channel_Q_noise <= x"80";
        wait for 60ns;
     elsif (i = 3) then
        i_channel_I_noise <= x"A0";
        i_channel_Q_noise <= x"80";
        wait for 60ns;  
     elsif (i = 4) then
        i_channel_I_noise <= x"80";
        i_channel_Q_noise <= x"80";
        wait for 60ns; 
     elsif (i = 5) then
        i_channel_I_noise <= x"60";
        i_channel_Q_noise <= x"80";
        wait for 60ns;  
     elsif (i = 6) then
        i_channel_I_noise <= x"40";
        i_channel_Q_noise <= x"80";
        wait for 60ns; 
     elsif (i = 7) then
        i_channel_I_noise <= x"60";
        i_channel_Q_noise <= x"80";
        wait for 60ns; 
     elsif (i = 8) then            
        i_start_bit <= '0';
        wait for 60ns;        
     elsif (i = 9) then
        i_start_bit <= '1';     
        i_channel_Q_noise <= x"80";
        i_channel_I_noise <= x"80";
        wait for 60ns;
     elsif (i = 10) then
        i_channel_Q_noise <= x"A0";
        i_channel_I_noise <= x"80";
        wait for 60ns;
     elsif (i = 11) then
        i_channel_Q_noise <= x"C0";
        i_channel_I_noise <= x"80";
        wait for 60ns;
     elsif (i = 12) then
        i_channel_Q_noise <= x"A0";
        i_channel_I_noise <= x"80";
        wait for 60ns;  
     elsif (i = 13) then
        i_channel_Q_noise <= x"80";
        i_channel_I_noise <= x"80";
        wait for 60ns; 
     elsif (i = 14) then
        i_channel_Q_noise <= x"60";
        i_channel_I_noise <= x"80";
        wait for 60ns;  
     elsif (i = 15) then
        i_channel_Q_noise <= x"40";
        i_channel_I_noise <= x"80";
        wait for 60ns; 
     elsif (i = 16) then
        i_channel_Q_noise <= x"60";
        i_channel_I_noise <= x"80";
        wait for 60ns;     
     elsif (i = 17) then            
        i_start_bit <= '0';
        wait for 60ns;        
     elsif (i = 18) then
        i_start_bit <= '1';     
        i_channel_I_noise <= x"80";
        i_channel_Q_noise <= x"80";
        wait for 60ns;
     elsif (i = 19) then
        i_channel_I_noise <= x"60";
        i_channel_Q_noise <= x"80";
        wait for 60ns;
     elsif (i = 20) then
        i_channel_I_noise <= x"40";
        i_channel_Q_noise <= x"80";
        wait for 60ns;
     elsif (i = 21) then
        i_channel_I_noise <= x"60";
        i_channel_Q_noise <= x"80";
        wait for 60ns;  
     elsif (i = 22) then
        i_channel_I_noise <= x"80";
        i_channel_Q_noise <= x"80";
        wait for 60ns; 
     elsif (i = 23) then
        i_channel_I_noise <= x"A0";
        i_channel_Q_noise <= x"80";
        wait for 60ns;  
     elsif (i = 24) then
        i_channel_I_noise <= x"C0";
        i_channel_Q_noise <= x"80";
        wait for 60ns; 
     elsif (i = 25) then
        i_channel_I_noise <= x"A0";
        i_channel_Q_noise <= x"80";
        wait for 60ns;             
     elsif(i = 26) then
        i_start_bit <= '0';
        wait for 60ns;                     
     elsif (i = 27) then
        i_start_bit <= '1';
        i_channel_Q_noise <= x"80";
        i_channel_I_noise <= x"80";
        wait for 60ns;
     elsif (i = 28) then
        i_channel_Q_noise <= x"60";
        i_channel_I_noise <= x"80";
        wait for 60ns;
     elsif (i = 29) then
        i_channel_Q_noise <= x"40";
        i_channel_I_noise <= x"80";
        wait for 60ns;
     elsif (i = 30) then
        i_channel_Q_noise <= x"60";
        i_channel_I_noise <= x"80";
        wait for 60ns;  
     elsif (i = 31) then
        i_channel_Q_noise <= x"80";
        i_channel_I_noise <= x"80";
        wait for 60ns; 
     elsif (i = 32) then
        i_channel_Q_noise <= x"A0";
        i_channel_I_noise <= x"80";
        wait for 60ns;  
     elsif (i = 33) then
        i_channel_Q_noise <= x"C0";
        i_channel_I_noise <= x"80";
        wait for 60ns; 
     elsif (i = 34) then
        i_channel_Q_noise <= x"A0";
        i_channel_I_noise <= x"80";
        wait for 60ns;                                                  
     elsif(i = 35) then
        i_start_bit <= '0';
        wait for 60ns;        
     end if;
    end loop;
    end process input_change;
-----------------------------------------------------
end Behavioral;