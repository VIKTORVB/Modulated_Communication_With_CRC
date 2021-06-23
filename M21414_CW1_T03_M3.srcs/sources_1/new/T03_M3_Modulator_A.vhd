----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Modulator A
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
package I_Q_Array is
        type I is array(0 to 7) of std_logic_vector(0 to 7);
        type Q is array(0 to 7) of std_logic_vector(0 to 7);
        type Ref is array(0 to 7) of integer range 0 to 255;
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.I_Q_Array.ALL;

entity M3_T03_Modulator_A is
    Port ( -- inputs
           i_Rst : in STD_LOGIC; 
           i_CE: in STD_LOGIC; 
           i_Clk: in std_logic;
           i_Data_2_bits: in std_logic_vector(1 downto 0);
           -- outputs
           o_M_Ready : out std_logic;
           o_I_A: out I;
           o_Q_A: out Q
          ); 
end M3_T03_Modulator_A;
architecture Behavioral of M3_T03_Modulator_A is
begin
  EncodeBits: process(i_CE,i_Rst,i_Clk,i_Data_2_bits)
    begin
      if(i_Rst = '1') then -- if reset is high set outputs to 0
        o_I_A(0 to 7)<= (others => "00000000");
        o_Q_A(0 to 7)<= (others => "00000000");
      elsif (rising_edge (i_Clk)) then -- on rising edge of clock
        if (i_CE = '1') then -- if clock enable is set
          case i_Data_2_bits is    
            when "00" => o_I_A(0 to 7) <= (x"80",x"A0",x"C0",x"A0",x"80",x"60",x"40",x"60"); -- depending on the input bits
                         o_Q_A(0 to 7) <= (x"80",x"A0",x"C0",x"A0",x"80",x"60",x"40",x"60"); -- push the waveform represented in hex to the output array
                         o_M_Ready <= '1';                                                   -- and set the ready bit
            when "01" => o_I_A(0 to 7) <= (x"80",x"A0",x"C0",x"A0",x"80",x"60",x"40",x"60");
                         o_Q_A(0 to 7) <= (x"80",x"60",x"40",x"60",x"80",x"A0",x"C0",x"A0");
                         o_M_Ready <= '1';
            when "10" => o_I_A(0 to 7) <= (x"80",x"60",x"40",x"60",x"80",x"A0",x"C0",x"A0");
                         o_Q_A(0 to 7) <= (x"80",x"A0",x"C0",x"A0",x"80",x"60",x"40",x"60");
                         o_M_Ready <= '1';
            when "11" => o_I_A(0 to 7) <= (x"80",x"60",x"40",x"60",x"80",x"A0",x"C0",x"A0");
                         o_Q_A(0 to 7) <= (x"80",x"60",x"40",x"60",x"80",x"A0",x"C0",x"A0");
                         o_M_Ready <= '1';
            when others => o_I_A(0 to 7) <= (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00");
                           o_Q_A(0 to 7) <= (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00");
          end case;
        end if;
      end if;
    end process;
end Behavioral;
