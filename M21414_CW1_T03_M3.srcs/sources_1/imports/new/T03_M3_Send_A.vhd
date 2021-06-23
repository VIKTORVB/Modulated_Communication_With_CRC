----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Send
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.I_Q_Array.ALL;

entity M3_T03_Send is
    Port ( -- inputs
           i_Rst : in STD_LOGIC;
           i_CE: in STD_LOGIC; 
           i_Clk: in std_logic; 
           i_I_A: in I;
           i_Q_A: in Q;
           i_M_Ready: in std_logic;
           -- outputs
           o_Send_Done: out std_logic := '0';
           o_I_Modulated_A : out std_logic_vector(7 downto 0);
           o_Q_Modulated_A : out std_logic_vector(7 downto 0)
          ); 
end M3_T03_Send;


  architecture Behavioral of M3_T03_Send is 
signal cycle: integer range 0 to 7:=0;
signal position: integer range 0 to 1:=0;
begin
Send: process(i_Clk, i_Rst,i_CE)
    begin
      if(i_Rst = '1') then  -- if reset is high push output to 0
        o_I_Modulated_A(7 downto 0)<= (others => '0');
        o_Q_Modulated_A(7 downto 0)<= (others => '0');
      elsif (rising_edge (i_Clk))  then  -- on rising edge of the clock
        if(i_CE = '1') then             -- if clock enable is set
          if(cycle < 8) and (i_M_Ready = '1') then -- if the cycle integer is less than max and the ready bit for modulation is set
            o_I_Modulated_A <= i_I_A(cycle);  -- push the vector on the cycle integer position to the output
            o_Q_Modulated_A <= i_Q_A(cycle);
            cycle <= cycle+1;                 -- increment cycle and set done bit high
            o_Send_Done <= '1';
          elsif (cycle > 7) then              -- when cycle reaches max reset cycle and set done bit low
            cycle <= 0;
            o_Send_Done <= '0';
            end if;
          end if;
        end if;
    end process;
            
end behavioral;