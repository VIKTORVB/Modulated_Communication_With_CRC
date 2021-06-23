----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Debounce entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the debounce entity block
entity T03_M3_Debounce is
    Port (-- inputs
          i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset input
          i_Push : in STD_LOGIC := '0'; -- start/stop push button
          i_Data_switches : in STD_LOGIC_VECTOR (3 downto 0); -- data select switches
          i_Error_switches : in STD_LOGIC_VECTOR(1 downto 0); -- error select switches
          i_Display_switches : in STD_LOGIC_VECTOR(2 downto 0); -- display select switches
          --outputs
          o_Push_Debounce : out STD_LOGIC; -- debounced start/stop button output  
          o_Data_Select : out STD_LOGIC_VECTOR (3 downto 0); -- 4-bit data select output
          o_Error_Select : out STD_LOGIC_VECTOR (1 downto 0); -- debounced error select         
          o_Display_Select : out STD_LOGIC_VECTOR (2 downto 0)); -- debounced display select
end T03_M3_Debounce;
-- architecure declaration for the debounced signals
architecture Behavioral of T03_M3_Debounce is
    signal r_data_debounced : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- 4-bit register for data select process 
    signal r_error_debounced : STD_LOGIC_VECTOR (1 downto 0) := (others => '0'); -- 2-bit register for error select process 
    signal r_display_debounced : STD_LOGIC_VECTOR (2 downto 0) := (others => '0'); -- 3-bit register for display select process 
    signal r_counter : integer range 0 to 1 :=0; -- counter to set wait time
    signal r_debounced : STD_LOGIC := '0'; -- register for push button
begin
    -- start the process of debounce             
    select_debounce : process (i_Clk, i_Rst, i_Push, i_Data_switches, i_Error_switches, i_Display_switches) -- include required signals
    begin

        if (i_Rst = '1') then -- when Reset is set
            r_counter <= 0; -- clear the counter
            r_data_debounced <= i_Data_switches; -- set the debounced value to the input value
            r_error_debounced <= i_Error_switches;
            r_display_debounced <= i_Display_switches;
            r_debounced <= i_Push;  -- both for the switches and the push button
        elsif (rising_edge (i_Clk)) then -- else ont the rising edge of the master clock
                if (r_counter < 1) then -- if counter hasn't reached its max value
                    r_counter <= r_counter +1; -- increment by one
                elsif(i_Push /= r_debounced) then -- if the push button input doesn't match the debounced value
                   r_counter <= 0; -- clear the counter
                   r_debounced <= i_Push;  -- and allocate the input to the debounced register
                elsif (i_Data_switches /= r_data_debounced) then -- similarly as above, but here we read the data switches
                    r_counter <= 0;
                    r_data_debounced <= i_Data_switches;
                elsif (i_Error_switches /= r_error_debounced) then -- similarly as above, but here we read the error switches
                    r_counter <= 0;
                    r_error_debounced <= i_Error_switches;
                elsif (i_Display_switches /= r_display_debounced) then -- similarly as above, but here we read the display switches
                    r_counter <= 0;
                    r_display_debounced <= i_Display_switches;                                        
                end if;   
        end if;
    end process;
    o_Data_Select <= r_data_debounced; -- allocate the debounced 4-bit switch register to the output signal
    o_Error_Select <= r_error_debounced;
    o_Display_Select <= r_display_debounced;
    o_Push_Debounce <= r_debounced; -- allocate the debounced button register to its corresponding output
end Behavioral;