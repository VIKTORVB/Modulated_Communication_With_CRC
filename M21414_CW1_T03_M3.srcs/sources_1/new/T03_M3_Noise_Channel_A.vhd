----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Noise Channel
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.I_Q_Array.ALL;

entity M3_T03_Noise_Channel is
    Port ( -- inputs
           i_Rst : in STD_LOGIC; --  reset bttn
           i_CE: in STD_LOGIC; --CE signal
           i_Clk: in std_logic; -- Master clock
           i_Error_Select: in std_logic_vector(1 downto 0);
           i_Rand_num_4_Bit: in std_logic_vector(4 downto 0);
           i_Rand_num_5_Bit: in std_logic_vector(5 downto 0);
           i_Rand_num_6_Bit: in std_logic_vector(6 downto 0);
           i_I_Modulated_A: in std_logic_vector(7 downto 0);
           i_Q_Modulated_A: in std_logic_vector(7 downto 0);
           i_Send_Done: in std_logic;
           -- outputs
           o_I_Noise_A: out std_logic_vector(7 downto 0);
           o_Q_Noise_A: out std_logic_vector(7 downto 0);
           o_Noise_Channel_Start: out std_logic
          ); 
end M3_T03_Noise_Channel;

architecture Behavioral of M3_T03_Noise_Channel is

signal r_Rand_num_4_Bit: integer range 0 to 15; -- declare integer signals for random numbers
signal r_Rand_num_5_Bit: integer range 0 to 31;
signal r_Rand_num_6_Bit: integer range 0 to 63;
begin
r_Rand_num_4_Bit <= TO_INTEGER(signed(i_Rand_num_4_Bit)); -- push random number vector to integer
r_Rand_num_5_Bit <= TO_INTEGER(signed(i_Rand_num_5_Bit));
r_Rand_num_6_Bit <= TO_INTEGER(signed(i_Rand_num_6_Bit));
 Noise:process(i_Clk,i_Rst,i_CE)
   begin
      if(i_Rst = '1') then
        o_I_Noise_A(7 downto 0)<= (others => '0');
        o_Q_Noise_A(7 downto 0)<= (others => '0');
      elsif (rising_edge (i_Clk)) then              -- on rising edge of the clock
        if (i_CE = '1') and (i_Send_Done = '1') then -- if clock enable is set
            if(i_Error_Select = "00") then  -- depending on the error select value 
              o_I_Noise_A <= i_I_Modulated_A;
              o_Q_Noise_A <= i_Q_Modulated_A;
              o_Noise_Channel_Start <= '1';
            elsif(i_Error_Select = "01") then
              o_I_Noise_A<= std_logic_vector(to_unsigned(to_integer(unsigned( i_I_Modulated_A )) + r_Rand_num_4_Bit, 8)); -- take the input value push it to integer then add the random number and push it back to std vector
              o_Q_Noise_A<= std_logic_vector(to_unsigned(to_integer(unsigned( i_Q_Modulated_A )) + r_Rand_num_4_Bit, 8)); 
              o_Noise_Channel_Start <= '1';                                                                               -- set ready bit high
            elsif(i_Error_Select = "10") then
              o_I_Noise_A<= std_logic_vector(to_unsigned(to_integer(unsigned( i_I_Modulated_A )) + r_Rand_num_5_Bit, 8));
              o_Q_Noise_A<= std_logic_vector(to_unsigned(to_integer(unsigned( i_Q_Modulated_A )) + r_Rand_num_5_Bit, 8));
              o_Noise_Channel_Start <= '1';          
            elsif(i_Error_Select = "11") then
              o_I_Noise_A<= std_logic_vector(to_unsigned(to_integer(unsigned( i_I_Modulated_A )) + r_Rand_num_6_Bit, 8));
              o_Q_Noise_A<= std_logic_vector(to_unsigned(to_integer(unsigned( i_Q_Modulated_A )) + r_Rand_num_6_Bit, 8));
              o_Noise_Channel_Start <= '1';
            end if;
        end if;
      end if;
   end process;
end Behavioral;
