----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Symbol Converter entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the symbol converter entity block
entity T03_M3_SymbolConverter is
  Port (-- inputs
        i_Clk, i_Rst: in STD_LOGIC; -- master clock and reset
        i_CE: in STD_LOGIC; -- clock enable signal at 2 Hz
        i_Data_Select : in STD_LOGIC_VECTOR(3 downto 0); -- 4-bit data select value
        i_Start_Stop : in STD_LOGIC; -- start/stop latch
        i_Data_4_bit: in STD_LOGIC_VECTOR (3 downto 0); -- data in from the data generator
        i_Data_6_bit : in STD_LOGIC_VECTOR(5 downto 0);        
        i_Display_Select : in STD_LOGIC_VECTOR (2 downto 0);
        -- outputs
        o_Symbol: out STD_LOGIC_VECTOR (1 downto 0); -- data out
        o_Data_2_bit_0: out STD_LOGIC_VECTOR (3 downto 0); -- data out
        o_Data_2_bit_1: out STD_LOGIC_VECTOR (3 downto 0); -- data out 
        o_LED11 : out STD_LOGIC := '0';
        o_LED10 : out STD_LOGIC := '0';
        o_LED12 : out STD_LOGIC := '0'); 
end T03_M3_SymbolConverter;
-- architecure declaration for the symbol converter
architecture Behavioral of T03_M3_SymbolConverter is
signal delay_select: integer range 0 to 2 :=0; -- delay register to wait between each iteration
signal r_Data_4_bit: STD_LOGIC_VECTOR (3 downto 0); -- to hold the 4-bit input
signal r_Data_6_bit: std_logic_vector(5 downto 0);
signal r_Symbol: STD_LOGIC_VECTOR (1 downto 0):= (others => '0'); -- holds the converted output 
signal r_Data_2_bit_0: STD_LOGIC_VECTOR (3 downto 0):= (others => '0'); -- holds the converted output 
signal r_Data_2_bit_1: STD_LOGIC_VECTOR (3 downto 0):= (others => '0'); -- during the process
begin
  -- store the input data in register
  r_Data_4_bit <= i_Data_4_bit;
  r_Data_6_bit <= i_Data_6_bit;
  -- start symbol converter
  Symbol_converter: process (i_Clk, i_CE, i_Data_Select, i_Rst, i_Display_Select) -- include required signals
  begin
    if (i_Rst = '1') then -- if reset is set
    r_Symbol <= (others => '0'); -- clear the output registers
    r_Data_2_bit_0 <= (others => '0'); -- clear the output registers
    r_Data_2_bit_1 <= (others => '0');  
    o_LED12 <= '0';  -- turn off the LEDS                  
    o_LED11 <= '0';             
    o_LED10 <= '0';
    elsif(rising_edge(i_Clk)) then -- on the rising edge of the master clock
     if(i_CE = '1') then -- if clock enable is high
      if (i_Start_Stop = '1') and ((i_Display_Select ="000") or (i_Display_Select ="100")) then -- if start/stop is high // added display switch
           if (delay_select = 0) then -- if its the first iteration
             o_LED11 <= '1';  -- toggle the LEDs
             o_LED10 <= '0';              
             r_Data_2_bit_0(0) <= r_Data_4_bit(3); -- convert the 1st MSB of the input to the LSB of the first output register
             r_Data_2_bit_1(0) <= r_Data_4_bit(2); -- convert the 2nd MSB of the input to the LSB of the second output register
            -- r_Symbol(1) <= r_Data_4_bit(3); -- convert the 1st MSB of the input to the LSB of the first output register
            -- r_Symbol(0) <= r_Data_4_bit(2); -- convert the 2nd MSB of the input to the LSB of the second output register
             delay_select <= 1;
          elsif (delay_select = 1) then -- if clock enable is high and it's the second iteration
             o_LED11 <= '0'; -- toggle the LEDs         
             o_LED10 <= '1';         
             r_Data_2_bit_0(0) <= r_Data_4_bit(1); -- convert the third bit of the input to the LSB of the first output register
             r_Data_2_bit_1(0) <= r_Data_4_bit(0); -- convert the fourth bit of the input to the LSB of the first output register
            -- r_Symbol(1) <= r_Data_4_bit(1); -- convert the third bit of the input to the LSB of the first output register
            -- r_Symbol(0) <= r_Data_4_bit(0); -- convert the fourth bit of the input to the LSB of the first output register
             delay_select <= 0; -- clear, start again
           end if;
      elsif (i_Start_Stop = '1') and (i_Display_Select /="-00")then -- -- if start/stop is high // added display switch
             if (delay_select = 0) then -- if its the first iteration
                 o_LED12 <= '1';
                 o_LED11 <= '0';  -- toggle the LEDs
                 o_LED10 <= '0';              
                 r_Symbol(1) <= r_Data_6_bit(5); -- convert the 1st MSB of the input to the LSB of the first output register
                 r_Symbol(0) <= r_Data_6_bit(4); -- convert the 2nd MSB of the input to the LSB of the second output register
                 delay_select <= 1;
             elsif (delay_select = 1) then -- if clock enable is high and it's the second iteration
                 o_LED12 <= '0';
                 o_LED11 <= '1'; -- toggle the LEDs         
                 o_LED10 <= '0';         
                 r_Symbol(1) <= r_Data_6_bit(3); -- convert the third bit of the input to the LSB of the first output register
                 r_Symbol(0) <= r_Data_6_bit(2); -- convert the fourth bit of the input to the LSB of the first output register
                 delay_select <= 2; -- clear, start again
            elsif (delay_select = 2) then -- if clock enable is high and it's the second iteration
                 o_LED12 <= '0';
                 o_LED11 <= '0'; -- toggle the LEDs         
                 o_LED10 <= '1';         
                 r_Symbol(1) <= r_Data_6_bit(1); -- convert the third bit of the input to the LSB of the first output register
                 r_Symbol(0) <= r_Data_6_bit(0); -- convert the fourth bit of the input to the LSB of the first output register
                 delay_select <= 0; -- clear, start again   
         end if;   
      else -- when the start/stop latch is clear
         o_LED12 <= '0';
         o_LED11 <= '0'; -- turn off the LEDs             
         o_LED10 <= '0';   
         r_Symbol <= (others => '0'); -- clear the output registers
         r_Data_2_bit_0 <= (others => '0');   
         r_Data_2_bit_1 <= (others => '0');                                            
      end if;     
     end if;
    end if;
  end process;
  -- allocate the output registers values to their corresponding output signal
  o_Symbol <= r_Symbol;
  o_Data_2_bit_0 <= r_Data_2_bit_0;
  o_Data_2_bit_1 <= r_Data_2_bit_1;
end Behavioral;