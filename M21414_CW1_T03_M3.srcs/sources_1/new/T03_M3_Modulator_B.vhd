-----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Modulator - B entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and numeric functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the Modulator - B entity block -----------------------------------
entity T03_M3_Modulator_B is 
    Port (-- inputs
          i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset input
          i_CE : in STD_LOGIC; -- 100 HZ
          i_Symbol : in STD_LOGIC_VECTOR (1 downto 0); -- 2-bit symbol unput
          -- outputs
          o_mod_B_I : out STD_LOGIC_VECTOR (7 downto 0); -- modulated I channel data sequence
          o_mod_B_Q : out STD_LOGIC_VECTOR (7 downto 0); -- modulated Q channel data sequence
          o_start_bit : out STD_LOGIC);  -- start/stop bit
end T03_M3_Modulator_B;
--architecure declaration for the Modulator - B entity block -------------------------
architecture Behavioral of T03_M3_Modulator_B is 
signal r_channel_I : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); -- register for I channel 
signal r_channel_Q : STD_LOGIC_VECTOR (7 downto 0) := (others => '0'); -- register for Q channel
signal r_counter : integer range 0 to 9 := 0; -- counter for the modulation process
signal r_start_bit : STD_LOGIC := '0'; -- start/stop bit register 
-----------------------------------------------------------
begin
    modulator_B : process (i_Clk, i_Rst, i_CE, i_Symbol) -- start the process of Modulation Scheme B with the required signals
    begin
        if(i_Rst = '1') then -- if Reset is set
        r_counter <= 0; -- clear counter
        r_start_bit <= '0'; -- clear start/stop bit
       elsif (rising_edge (i_Clk)) then -- on the risign edge of the master clock
        if (i_CE = '1') then -- if clock enable is set
            if (i_Symbol = "00" and r_counter <= 9) then -- when the input symbol is "00" and counter is less the max value
                case r_counter is -- loop through the correct modulation sequence 
                    when 0 => r_start_bit <= '1'; r_counter <= r_counter +1; -- set the start bit
                    when 1 => r_channel_I <= x"80"; r_channel_Q <=  x"80"; r_counter <= r_counter +1; -- for each iteration, allocate the corresponding binary value of the
                    when 2 => r_channel_I <= x"A0"; r_counter <= r_counter +1; -- modulation system to the 8-bit register and increment the counter by one
                    when 3 => r_channel_I <= x"C0"; r_counter <= r_counter +1;
                    when 4 => r_channel_I <= x"A0"; r_counter <= r_counter +1;
                    when 5 => r_channel_I <= x"80"; r_counter <= r_counter +1;
                    when 6 => r_channel_I <= x"60"; r_counter <= r_counter +1; 
                    when 7 => r_channel_I <= x"40"; r_counter <= r_counter +1; 
                    when 8 => r_channel_I <= x"60"; r_counter <= r_counter +1; 
                    when 9 => r_start_bit <= '0'; r_counter <= 0; -- clear the start bit and counter
                    when others => r_channel_I <= (others => '0'); r_channel_Q <= (others => '0'); -- "catch" statement, in case there's an unexpected state
                    r_counter <= 0; r_start_bit <= '0'; -- clear all the register
                end case;   
            elsif (i_Symbol = "10" and r_counter <= 9) then -- when the input symbol is "10" and counter is less the max value
                case r_counter is -- loop through the correct modulation sequence 
                    when 0 => r_start_bit <= '1'; r_counter <= r_counter +1; -- set the start bit
                    when 1 => r_channel_Q <= x"80"; r_channel_I <=  x"80"; r_counter <= r_counter +1; -- for each iteration, allocate the corresponding binary value of the
                    when 2 => r_channel_Q <= x"A0"; r_counter <= r_counter +1; -- modulation system to the 8-bit register and increment the counter by one
                    when 3 => r_channel_Q <= x"C0"; r_counter <= r_counter +1;
                    when 4 => r_channel_Q <= x"A0"; r_counter <= r_counter +1;
                    when 5 => r_channel_Q <= x"80"; r_counter <= r_counter +1;
                    when 6 => r_channel_Q <= x"60"; r_counter <= r_counter +1; 
                    when 7 => r_channel_Q <= x"40"; r_counter <= r_counter +1; 
                    when 8 => r_channel_Q <= x"60"; r_counter <= r_counter +1;
                    when 9 => r_start_bit <= '0'; r_counter <= 0; -- clear the start bit and counter
                    when others => r_channel_I <= (others => '0'); r_channel_Q <= (others => '0'); -- "catch" statement, in case there's an unexpected state 
                    r_counter <= 0; r_start_bit <= '0'; -- clear all the register
                end case;       
            elsif (i_Symbol = "11" and r_counter <= 9) then -- when the input symbol is "11" and counter is less the max value
                case r_counter is -- loop through the correct modulation sequence 
                    when 0 => r_start_bit <= '1'; r_counter <= r_counter +1; -- set the start bit
                    when 1 => r_channel_I <= x"80"; r_channel_Q <=  x"80"; r_counter <= r_counter +1; -- for each iteration, allocate the corresponding binary value of the
                    when 2 => r_channel_I <= x"60"; r_counter <= r_counter +1; -- modulation system to the 8-bit register and increment the counter by one
                    when 3 => r_channel_I <= x"40"; r_counter <= r_counter +1;
                    when 4 => r_channel_I <= x"60"; r_counter <= r_counter +1;
                    when 5 => r_channel_I <= x"80"; r_counter <= r_counter +1;
                    when 6 => r_channel_I <= x"A0"; r_counter <= r_counter +1; 
                    when 7 => r_channel_I <= x"C0"; r_counter <= r_counter +1; 
                    when 8 => r_channel_I <= x"A0"; r_counter <= r_counter +1;
                    when 9 => r_start_bit <= '0'; r_counter <= 0; -- clear the start bit and counter
                    when others => r_channel_I <= (others => '0'); r_channel_Q <= (others => '0'); -- "catch" statement, in case there's an unexpected state 
                    r_counter <= 0; r_start_bit <= '0'; -- clear all the register
                end case;
            elsif (i_Symbol = "01" and r_counter <= 9) then -- when the input symbol is "01" and counter is less the max value
                case r_counter is -- loop through the correct modulation sequence
                    when 0 => r_start_bit <= '1'; r_counter <= r_counter +1; -- set the start bit
                    when 1 => r_channel_Q <= x"80"; r_channel_I <=  x"80"; r_counter <= r_counter +1; -- for ation system to the 8-bit register and increment the counter by one
                    when 2 => r_channel_Q <= x"60"; r_counter <= r_counter +1;
                    when 3 => r_channel_Q <= x"40"; r_counter <= r_counter +1;
                    when 4 => r_channel_Q <= x"60"; r_counter <= r_counter +1;                    
                    when 5 => r_channel_Q <= x"80"; r_counter <= r_counter +1;
                    when 6 => r_channel_Q <= x"A0"; r_counter <= r_counter +1; 
                    when 7 => r_channel_Q <= x"C0"; r_counter <= r_counter +1; 
                    when 8 => r_channel_Q <= x"A0"; r_counter <= r_counter +1;
                    when 9 => r_start_bit <= '0'; r_counter <= 0; -- clear the start bit and counter
                    when others => r_channel_I <= (others => '0'); r_channel_Q <= (others => '0'); -- "catch" statement, in case there's an unexpected state
                    r_counter <= 0; r_start_bit <= '0'; -- clear all the register
                end case;                                           
           end if;              
        end if;
       end if; 
    end process;
    o_mod_B_I <= r_channel_I; -- allocate the register values to their corresponding output
    o_mod_B_Q <= r_channel_Q;
    o_start_bit <= r_start_bit;
end Behavioral;            