----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Start Stop entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1  
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the start/stop entity block
entity T03_M3_StartStop is
    Port (--inputs
          i_Clk, i_CE : in STD_LOGIC; -- master clock and 1kHz clock enable signal
          i_Push_Debounce : in STD_LOGIC; -- debounced push button
          --outputs
          o_Start_Stop : out STD_LOGIC); -- start/stop signal
end T03_M3_StartStop;
-- architecure declaration for the start/stop latch
architecture Behavioral of T03_M3_StartStop is
    signal r_latch : STD_LOGIC :='0'; -- declare a logic register and set initial value to zero
begin
    -- start of the latch process
    Start_latch : process (i_Clk, i_CE, i_Push_Debounce) -- include required signals 
    begin
    if (rising_edge (i_Clk)) then -- on the risign edge of the master clock
        if(i_CE = '1') then -- when clock enable is high
             if (i_Push_Debounce = '1' and r_latch = '0') then -- if push button is pressed and latch is cleared
                 r_latch <= '1'; -- set the latch
             elsif (i_Push_Debounce ='1' and r_latch = '1') then -- if push button is pressed and latch is set
                 r_latch <= '0'; -- clear the latch
             end if;
        end if;
    end if; 
    end process;
    o_Start_Stop <= r_latch; -- allocate the register value to the output signal
end Behavioral;  