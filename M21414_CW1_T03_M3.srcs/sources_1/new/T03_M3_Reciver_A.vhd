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

entity M3_T03_Recive is
    Port ( -- inputs
           i_Rst : in STD_LOGIC; --  reset bttn
           i_CE: in STD_LOGIC; --CE signal
           i_Clk: in std_logic; -- Master clock
           i_I_Noise_A: in std_logic_vector(7 downto 0);
           i_Q_Noise_A: in std_logic_vector(7 downto 0);
           i_Noise_Channel_Start: in std_logic;
           -- outputs
           o_Recived: out std_logic;
           o_I_Recived: out I;
           o_Q_Recived: out Q
          ); 
end M3_T03_Recive;

architecture Behavioral of M3_T03_Recive is 
signal cycle: integer range 0 to 7 := 0;
signal r_I_Recived : I;
signal r_Q_Recived : Q;
begin
Recive: process(I_Clk)
    begin
      if(i_Rst = '1') then                       -- if reset is high set output to 0
        o_I_Recived(0 to 7)<= (others => "00000000");
        o_Q_Recived(0 to 7)<= (others => "00000000");
      elsif (rising_edge (i_Clk)) then     -- on rising edge of the clock
        if (i_CE = '1') then -- if clock enable is set
          if(cycle < 8) and (i_Noise_Channel_Start = '1') then --if cycle is not max and the noise channel is sending data
            r_I_Recived(cycle) <=i_I_Noise_A ;  -- push recived data to an array
            r_Q_Recived(cycle) <=i_Q_Noise_A ; 
            cycle <= cycle+1;                  -- increment cycle
          elsif (cycle > 7) then               -- if cycle is max
            cycle <= 0;                        -- reset cycle, set ready bit high, push array to output
            o_Recived <= '1';
            o_I_Recived <=r_I_Recived ; 
            o_Q_Recived <=r_Q_Recived ; 
          end if;
        end if;
      end if;
    end process;
end behavioral;