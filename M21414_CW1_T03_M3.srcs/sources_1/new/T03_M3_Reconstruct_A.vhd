----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Recive
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.I_Q_Array.ALL;

entity M3_T03_Reconstruct is
    Port ( -- inputs
           i_Rst : in STD_LOGIC; --  reset bttn
           i_CE: in STD_LOGIC; --CE signal
           i_Clk: in std_logic; -- Master clock
           i_Demodulated_2_Bits_A: in std_logic_vector(1 downto 0);
           i_MA_Done: in std_logic :='0';
           i_Demodulation_Done: in std_logic :='0';
           -- outputs
           o_Reconstructed_Data_A: out std_logic_vector(3 downto 0)
          ); 
end M3_T03_Reconstruct;


architecture Behavioral of M3_T03_Reconstruct is 
signal cycle: integer range -1 to 5 := 5;
signal r_Reconstructed_Data:  std_logic_vector(5 downto 0);
begin
Recive: process(i_Clk,i_CE)
    begin
      if(i_Rst = '1') then
        o_Reconstructed_Data_A <= (others => '0');
      elsif (rising_edge (i_Clk)) then     
        if (i_CE = '1') then  -- if clock enable is set
          if(cycle > 0) and (i_Demodulation_Done='1')then
            r_Reconstructed_Data(cycle downto cycle -1) <= i_Demodulated_2_Bits_A(1 downto 0); 
            cycle <= cycle-2;      
          elsif (cycle < 1) then
            cycle <= 5;
            o_Reconstructed_Data_A <= r_Reconstructed_Data(5 downto 2);
          end if;
        end if;
      end if;
    end process;
end behavioral;