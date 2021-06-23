----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Demodulator
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity M3_T03_Demodulator is
    Port ( -- inputs
           i_Rst : in STD_LOGIC; --  reset bttn
           i_CE: in STD_LOGIC; --CE signal
           i_Clk: in std_logic; -- Master clock
           i_Result_I_A: in std_logic_vector(17 downto 0);
           i_Result_Q_A: in std_logic_vector(17 downto 0);
           i_MA_Done: in std_logic :='0';
           -- outputs
           o_Demodulation_Done: out std_logic :='0';
           o_Demodulated_2_Bits_A: out std_logic_vector(1 downto 0)
          ); 
end M3_T03_Demodulator;

architecture Behavioral of M3_T03_Demodulator is
signal Midpoint: integer := 130000; -- set the mid point between the 1 and 0 values
signal r_Result_I: integer range 0 to 150000;
signal r_Result_Q: integer range 0 to 150000;
begin
r_Result_I <= to_integer(unsigned( i_Result_I_A ));
r_Result_Q <= to_integer(unsigned( i_Result_Q_A ));
  Demodulation: process(i_Clk, i_Rst)
    begin
      if(i_Rst = '1') then -- is reset is high
        o_Demodulated_2_bits_A <= "00"; -- set output to 0
      elsif (rising_edge (i_Clk)) then     -- on rising edge of the clock
        if (i_CE = '1') and (i_MA_Done = '1') then -- if clock enable is set
          if(r_Result_I < Midpoint) and (r_Result_Q < Midpoint) then -- if result is higher than the midpoint its a 1 
            o_Demodulated_2_Bits_A <= "00";                          -- if it's lower it's a 0
            o_Demodulation_Done <= '1';                              -- set ready bit high
          elsif(r_Result_I < Midpoint) and (r_Result_Q > Midpoint) then
            o_Demodulated_2_Bits_A <= "01";
            o_Demodulation_Done <= '1';
          elsif(r_Result_I > Midpoint) and (r_Result_Q < Midpoint) then
            o_Demodulated_2_Bits_A <= "10";
            o_Demodulation_Done <= '1';
          elsif(r_Result_I > Midpoint) and (r_Result_Q > Midpoint) then
            o_Demodulated_2_Bits_A <= "11";
            o_Demodulation_Done <= '1';
          end if;
      end if;
    end if;
    end process;
end Behavioral;
