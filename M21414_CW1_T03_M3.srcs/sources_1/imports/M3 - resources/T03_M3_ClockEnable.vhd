----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: ClockEnable entity block
-- Project name: Coursework 1 - Milestone 2
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1  
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the clock enable entity block
entity T03_M3_ClockEnable is
    -- declare a generic, which allows us to change the frequency  
    -- of the CE signal from the top level
    generic (g_maxCount : integer);
    Port( -- inputs
          i_Clk : in STD_LOGIC; -- master clock signal
          i_Rst : in STD_LOGIC; -- reset button
          i_Fast : in STD_LOGIC; -- fast switch
          -- outputs
          o_CE : out STD_LOGIC); --  clock enable signal
end T03_M3_ClockEnable;
-- architecure declaration for the clock enable signal
architecture Behavioral of T03_M3_ClockEnable is
    -- CE counter register, with initial value 0
    signal r_Counter : integer := 0;    
begin
    -- process for the clock enable signal
    clock_div : process (i_Clk, i_Rst, i_Fast, r_Counter) -- initialising the required signals
    begin
        if i_Rst = '1' then -- when Reset button is pressed
           r_Counter <= 0; -- set the counter to it's initial value 
        elsif rising_edge (i_Clk) then  -- start counting on the risign edge of the master clock 
            if r_Counter >=(g_maxCount-1) then -- check if limit is reached
               r_Counter <= 0;    -- if yes, reset the counter    
            else    -- if not
               if i_Fast = '1' then -- check if Fast switch is 'set'
                  r_Counter <= r_Counter +30; -- if so, increment the counter faster
               else -- if not
                  r_Counter <= r_Counter +1;   -- single increment
               end if;
            end if;   
         end if;
      end process clock_div;
            
    -- process for clock enable pulse
    pulse : process (i_Clk, i_Rst,r_Counter) -- include the required signals
    begin
        if i_Rst = '1' then -- check if Reset button is set
           o_CE <= '0'; -- reset the clock enable signal
        elsif falling_edge (i_Clk) then -- start counting on the falling edge of the system clock
            if r_Counter >= (g_maxCount-1) then -- limit reached?
               o_CE <= '1'; -- yes, pulse signal for one cycle
            else 
               o_CE <= '0'; -- no, keep signal low
            end if;
        end if;
     end process pulse;
end Behavioral;