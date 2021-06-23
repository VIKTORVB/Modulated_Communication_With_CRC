----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Multiply Accumulate
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.I_Q_Array.ALL;

entity M3_T03_Multiply_Accumulate is
    Port ( -- inputs
           i_Rst : in STD_LOGIC; --  reset bttn
           i_CE: in STD_LOGIC; --CE signal
           i_Clk: in std_logic; -- Master clock
           i_I_Recived: in I;
           i_Q_Recived: in Q;
           i_Recived: in std_logic;
           o_MA_Done: out std_logic;
           -- outputs
           o_Result_I_A: out std_logic_vector(17 downto 0);
           o_Result_Q_A: out std_logic_vector(17 downto 0)
          ); 
end M3_T03_Multiply_Accumulate;


architecture Behavioral of M3_T03_Multiply_Accumulate is
signal Ref: Ref;
signal Accumulator_I: integer range 0 to 150000;
signal Accumulator_Q: integer range 0 to 150000;
signal position: integer range 0 to 3;
signal cycle: integer range 0 to 7;
begin
  Multiply_Accumulate: process(i_Clk)
    begin
      if(i_Rst = '1') then
        o_Result_I_A(17 downto 0)<= (others => '0');
        o_Result_Q_A(17 downto 0)<= (others => '0');
      elsif (rising_edge (i_Clk)) then
        if (i_CE = '1') and (i_Recived = '1')then -- if clock enable is set
          if(position = 0) then
            Ref <= (128,96,64,96,128,160,192,160);
            position <= 1;
          elsif( position = 1) then
            if(cycle < 8) then
              Accumulator_I <=Accumulator_I + (to_integer(unsigned( i_I_Recived(cycle))) * Ref(cycle));
              Accumulator_Q <=Accumulator_Q + (to_integer(unsigned( i_Q_Recived(cycle))) * Ref(cycle));
              cycle <= cycle+1;
            elsif(cycle > 7) then
              cycle <= 0;
              position <= 2;
            end if;
          elsif(position = 2) then
            o_Result_I_A <= std_logic_vector(to_unsigned(Accumulator_I, 18));
            o_Result_Q_A <= std_logic_vector(to_unsigned(Accumulator_Q, 18));
            o_MA_Done <= '1';
            position <= 3;
          elsif(position = 3) then
            Accumulator_I <= 0;
            Accumulator_Q <= 0;
            position <= 0;  
          end if;
        end if;
      end if;
          
  end process Multiply_Accumulate;

end Behavioral;
