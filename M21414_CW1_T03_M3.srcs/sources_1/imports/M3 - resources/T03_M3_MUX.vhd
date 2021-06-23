----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Multiplexer entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1  
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--  declaration to the multiplexer entity block
entity T03_M3_MUX is 
    Port (-- inputs
          i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset input
          i_Select_Value, i_Data_4_bit: in STD_LOGIC_VECTOR (3 downto 0); 
          i_Data_2_bit_0: in STD_LOGIC_VECTOR (3 downto 0); -- data out
          i_Data_2_bit_1: in STD_LOGIC_VECTOR (3 downto 0); -- data out          
          i_digitSelect : in STD_LOGIC_VECTOR (1 downto 0); -- digit select values from the select counter
          i_Display_Select : in STD_LOGIC_VECTOR (2 downto 0); -- debounced display select
          i_Data_Rx : in STD_LOGIC_VECTOR(3 downto 0); -- demodulated data value
-----------Mod Scheme A inputs-------------------------------------------------------------------------------------------          
          i_I_Modulated_A : in STD_LOGIC_VECTOR (7 downto 0); -- modulated I channel data sequence
          i_Q_Modulated_A : in STD_LOGIC_VECTOR (7 downto 0); -- modulated Q channel data sequence
          i_I_Noise_A : in STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
          i_Q_Noise_A : in STD_LOGIC_VECTOR (7 downto 0); -- Q channel with additional noise        
-----------Mod Scheme B inputs-------------------------------------------------------------------------------------------          
          i_channel_I_noise : in STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
          i_channel_Q_noise : in STD_LOGIC_VECTOR (7 downto 0); -- Q channel with additional noise
          i_mod_B_I : in STD_LOGIC_VECTOR (7 downto 0); -- modulated I channel data sequence
          i_mod_B_Q : in STD_LOGIC_VECTOR (7 downto 0); -- modulated Q channel data sequence
          -- outputs
          o_valueRead : out STD_LOGIC_VECTOR (3 downto 0); -- value to be sent to the 7-segment decoder
          o_SegmentAnode : out STD_LOGIC_VECTOR (3 downto 0)); -- output that determines which anode to turn on/off
end T03_M3_MUX;
-- architecture body of the multiplexer
architecture Behavioral of T03_M3_MUX is
    -- declare a register that will store the input values
    signal r_dig_shown : STD_LOGIC_VECTOR (3 downto 0);
    signal flag : STD_LOGIC :='0';
begin
    -- start the proces of the input selection for the multiplexer 
    selectProc : process (i_Clk, i_Rst, i_digitSelect, i_Select_Value, i_Data_4_bit,
    i_Data_2_bit_1, i_Data_2_bit_0, i_Display_Select, i_Data_Rx) -- include required signals   
    begin
        if (i_Rst = '1') then -- if Reset is set
            o_SegmentAnode <= "1111"; -- turn off the anodes
        elsif (rising_edge (i_Clk)) then
--- Display Select for M2 input ------------------------------------------------------------         
          if (i_Display_Select ="000") or (i_Display_Select ="100")then
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <= i_Select_Value; o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= i_Data_4_bit; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <= i_Data_2_bit_0; o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= i_Data_2_bit_1; o_SegmentAnode <="1110";
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;        
--- Display Select for Modulation Scheme A -------------------------------------------------        
          elsif  (i_Display_Select ="010") then -- display the transmitted and received data values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <="0000"; o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= i_Data_4_bit; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <= "0000"; o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= i_Data_Rx; o_SegmentAnode <="1110";
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;
          elsif (i_Display_Select ="001") and (flag = '0') then -- display the first 4-bits of the transmitted I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_I_Modulated_A( 7 downto 4); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_Q_Modulated_A ( 7 downto 4); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000"; o_SegmentAnode <="1110"; flag <='1';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;
          elsif (i_Display_Select ="001") and (flag = '1') then -- display the second 4-bits of the transmitted I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_I_Modulated_A( 3 downto 0); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_Q_Modulated_A ( 3 downto 0); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000"; o_SegmentAnode <="1110"; flag <= '0';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;            
          elsif (i_Display_Select ="011") and (flag = '0') then -- display the first 4-bits of the received I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_I_Noise_A( 7 downto 4); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_Q_Noise_A ( 7 downto 4); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000";  o_SegmentAnode <="1110"; flag <= '1';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;
          elsif (i_Display_Select ="011") and (flag = '1') then -- display the second 4-bits of the received I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_I_Noise_A( 3 downto 0); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_Q_Noise_A ( 3 downto 0); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000";  o_SegmentAnode <="1110"; flag <= '0';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;             
--- Display Select for Modulation Scheme B -------------------------------------------------        
          elsif  (i_Display_Select ="110") then -- display the transmitted and received data values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <="0000"; o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= i_Data_4_bit; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <= "0000"; o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= i_Data_Rx; o_SegmentAnode <="1110";
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;
          elsif (i_Display_Select ="101") and (flag = '0') then -- display the first 4-bits of the transmitted I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_mod_B_I( 7 downto 4); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_mod_B_Q ( 7 downto 4); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000"; o_SegmentAnode <="1110"; flag <='1';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;
          elsif (i_Display_Select ="101") and (flag = '1') then -- display the secon 4-bits of the transmitted I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_mod_B_I( 3 downto 0); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_mod_B_Q ( 3 downto 0); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000"; o_SegmentAnode <="1110"; flag <= '0';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;            
          elsif (i_Display_Select ="111") and (flag = '0') then -- display the first 4-bits of the received I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_channel_I_noise( 7 downto 4); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_channel_Q_noise ( 7 downto 4); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000";  o_SegmentAnode <="1110"; flag <= '1';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;
          elsif (i_Display_Select ="111") and (flag = '1') then -- display the second 4-bits of the received I and Q values
            case i_digitSelect is   -- the input from the digit select counter chooses which input is active and turns on the correct anodes in turns
                when "00" => r_dig_shown <=i_channel_I_noise( 3 downto 0); o_SegmentAnode <="0111";
                when "01" => r_dig_shown <= "0000"; o_SegmentAnode <="1011";
                when "10" => r_dig_shown <=i_channel_Q_noise ( 3 downto 0); o_SegmentAnode <="1101";
                when "11" => r_dig_shown <= "0000";  o_SegmentAnode <="1110"; flag <= '0';
                when others => r_dig_shown <= (others => '0');  -- "catch" statement, in case there's an unexpected state
                o_SegmentAnode <= ( others => '1');             -- don't select an input, turn all anodes off
            end case;            
          end if;
       end if;
    end process selectProc;
    o_valueRead <= r_dig_shown;  -- allocate the stored value from the register to the output signal
end Behavioral;