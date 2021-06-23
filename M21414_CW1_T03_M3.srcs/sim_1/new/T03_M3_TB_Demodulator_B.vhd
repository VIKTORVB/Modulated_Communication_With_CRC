----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Demodulator - B test bench
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-----------------------------------------------------
entity T03_M3_TB_Demodulator_B is
end T03_M3_TB_Demodulator_B;
-----------------------------------------------------
architecture Behavioral of T03_M3_TB_Demodulator_B is
-- inputs
    signal i_Clk, i_CE, i_Rst : STD_LOGIC; 
    signal i_acc_I : STD_LOGIC_VECTOR (17 downto 0); -- accumulated I channel
    signal i_acc_Q : STD_LOGIC_VECTOR (17 downto 0); -- accumulated Q channel
    signal i_Sym_Rx : STD_LOGIC_VECTOR(1 downto 0);
    signal r_mid_zero : integer := 118784;
    signal r_mid_one : integer := 143360;
    signal r_mid_null : integer := 131072;
-- outputs
    signal o_Data_Demod_B : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
    signal o_Symbol_Demod_B : STD_LOGIC_VECTOR (1 downto 0);
-- constants
  constant Clk_period : time := 10ns;
  constant CE_period : time := 20ns; 
--------------------------------------------------------    
begin
    uut: entity work.T03_M3_Demodulator_B(Behavioral)
    Port map(i_Clk => i_Clk, i_Rst => i_Rst ,i_CE => i_CE,
    i_acc_I => i_acc_I, i_acc_Q => i_acc_Q, i_Sym_Rx => i_Sym_Rx, 
    o_Data_Demod_B => o_Data_Demod_B, o_Symbol_Demod_B => o_Symbol_Demod_B);
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
    input_changes : process
    begin
    for i in 0 to 5 loop
        if( i = 0) then -- in 00
            i_Sym_Rx <= "00";
            i_acc_I <= "011101000000000000";
            i_acc_Q <= "100000000000000000";
            wait for 60ns;
         elsif( i = 1) then -- in 11
            i_Sym_Rx <= "01";
            i_acc_I <= "100011000000000000";
            i_acc_Q <= "100000000000000000";
            wait for 60ns;            
         elsif( i = 2) then -- in 11
            i_Sym_Rx <= "10";
            i_acc_I <= "100011000000000000";
            i_acc_Q <= "100000000000000000";
            wait for 60ns; 
        elsif( i = 3) then -- in 01
            i_Sym_Rx <= "00";
            i_acc_I <= "100000000000000000";
            i_acc_Q <= "100011000000000000";
            wait for 60ns;
         elsif( i = 4) then -- in 10
            i_Sym_Rx <= "01";
            i_acc_I <= "100000000000000000";
            i_acc_Q <= "011101000000000000";
            wait for 60ns;            
         elsif( i = 5) then -- in 00
            i_Sym_Rx <= "10";
            i_acc_I <= "011101000000000000";
            i_acc_Q <= "100000000000000000";
            wait for 60ns;                                                              
        end if;
    end loop;
    end process input_changes;
-----------------------------------------------------       
end Behavioral;
