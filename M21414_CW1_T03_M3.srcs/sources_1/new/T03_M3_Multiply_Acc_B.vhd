----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Multiply Accumulate - B entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- declaration of the Multiply Accumulate - B entity block------------------------------
entity T03_M3_Multiply_Acc_B is
 Port ( -- inputs
        i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset inputs
        i_CE : in STD_LOGIC; -- 100 Hz clock enable signal 
        i_channel_I_noise : in STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
        i_channel_Q_noise : in STD_LOGIC_VECTOR (7 downto 0); -- Q channel with additional noise     
        i_start_bit : in STD_LOGIC; -- start bit that indicates that the whole sequence has been transmitted   
        -- outputs
        o_Sym_Rx : out STD_LOGIC_VECTOR(1 downto 0); -- received symbol sequence indicator
        o_acc_I : out STD_LOGIC_VECTOR (17 downto 0); -- accumulated I channel
        o_acc_Q : out STD_LOGIC_VECTOR (17 downto 0)); -- accumulated Q channel
end T03_M3_Multiply_Acc_B;
-- architecure declaration for the Multiply Accumulate - B entity block --------------------------------
architecture Behavioral of T03_M3_Multiply_Acc_B is
-- registers that hold the received I and Q data sequence 
    signal r_I_Rx : integer range 0 to 255;
    signal r_Q_Rx : integer range 0 to 255;
---------------------------------------------------
    signal r_load_flag : STD_LOGIC := '0'; -- flag to check if any data has previously been loaded to the entity 
    signal r_load_count : integer range 0 to 8 := 0; -- counter of how many data sequences have been received
    signal r_ref_counter : integer range 0 to 7 := 0; -- counter to cycle through the reference waveform's value
    signal r_res : integer range 0 to 8 :=0; -- conversion result counter
    signal r_Sym_count : integer range 0 to 2 := 0; -- received symbol pair indicator    
----------------------------------------------------------------    
    type ref_wave is array (0 to 7) of integer range 0 to 255; -- declare the reference waveform as an array with range
    signal r_ref : ref_wave := (128, 96, 64, 96, 128, 160, 192, 160); -- set the values of the reference waveform
    signal r_OPE : integer range 0 to 2 := 0; -- operand execution pipeline counter
    signal r_I_multiply : integer range 0 to 65535; -- multiplied value of channel I
    signal r_Q_multiply : integer range 0 to 65535; -- multiplied value of channel Q
    signal r_I_add : integer range 0 to 65535; -- added value of channel I
    signal r_Q_add : integer range 0 to 65535; -- added value of channel Q    
    signal r_I_result : integer range 0 to 65535; -- final value of I of the multiply accumulate process
    signal r_Q_result : integer range 0 to 65535; -- final value of Q of the multiply accumulate process
    signal r_acc_I : STD_LOGIC_VECTOR (17 downto 0); -- SLV equivalent of the accumulated I data sequence
    signal r_acc_Q : STD_LOGIC_VECTOR (17 downto 0); -- SLV equivalent of the accumulated Q data sequence
-----------------------------------------------------    
begin
    r_I_Rx <= TO_INTEGER( UNSIGNED( i_channel_I_noise)); -- converted the incoming data sequence
    r_Q_Rx <= TO_INTEGER( UNSIGNED( i_channel_Q_noise)); -- to integer
------------------------------------------------------    
    multiply_acc_B : process (i_Clk, i_CE, i_Rst, i_start_bit) -- start the demodulation process with the required signals
    begin
        if (i_Rst = '1') then -- if Reset is set
            r_ref_counter <= 0; -- clear the reference waveform counter
            r_load_flag <= '0'; -- clear load flag
            r_OPE <= 0; -- clear operand execution pipeline counter
         --   r_I_result <= 0; -- clear the accumulated I sequence register
         --   r_Q_result <= 0; -- clear the accumulated Q sequence register
            r_Sym_count <= 0; -- clear the received symbol counter
         --   o_Sym_Rx <= "00"; -- clear the received symbol indicator output            
------------------------------------------------------------------------------        
        elsif(rising_edge (i_Clk)) then -- on the risign edge of the master clock
            if  (i_start_bit = '1') then -- when the start bit is set
                -- when clock enable is high and it's the first pipeline operation
                -- and the reference waveform counter hasn't reached its max value
                if (i_CE = '1') and (r_OPE = 0) and (r_ref_counter <= 7) then
                    case r_ref_counter is -- while cycling through each value of the reference waveform
                        when 0  => r_I_multiply <= r_I_Rx * r_ref(0); -- multiply the received I and Q value with the given
                                   r_Q_multiply <= r_Q_Rx * r_ref(0); -- reference value and allocate it to the correct register
                                   r_ref_counter <= r_ref_counter +1; -- increment the counter to get the next reference value
                                   r_OPE <= 1; -- change the pipeline register to go to the next arithmetic function
                        when 1 => r_I_multiply <= r_I_Rx * r_ref(1); -- carry on doing the same process for all 8 values
                                  r_Q_multiply <= r_Q_Rx * r_ref(1);
                                  r_ref_counter <= r_ref_counter +1;
                                  r_OPE <= 1;
                        when 2 => r_I_multiply <= r_I_Rx * r_ref(2);
                                  r_Q_multiply <= r_Q_Rx * r_ref(2);
                                  r_ref_counter <= r_ref_counter +1;
                                  r_OPE <= 1;
                        when 3 => r_I_multiply <= r_I_Rx * r_ref(3);
                                  r_Q_multiply <= r_Q_Rx * r_ref(3);
                                  r_ref_counter <= r_ref_counter +1;
                                  r_OPE <= 1;
                        when 4 => r_I_multiply <= r_I_Rx * r_ref(4);
                                  r_Q_multiply <= r_Q_Rx * r_ref(4);
                                  r_ref_counter <= r_ref_counter +1;
                                  r_OPE <= 1;
                        when 5 => r_I_multiply <= r_I_Rx * r_ref(5);
                                  r_Q_multiply <= r_Q_Rx * r_ref(5);
                                  r_ref_counter <= r_ref_counter +1;
                                  r_OPE <= 1;
                        when 6 => r_I_multiply <= r_I_Rx * r_ref(6);
                                  r_Q_multiply <= r_Q_Rx * r_ref(6);
                                  r_ref_counter <= r_ref_counter +1;
                                  r_OPE <= 1;
                        when 7 => r_I_multiply <= r_I_Rx * r_ref(7);
                                  r_Q_multiply <= r_Q_Rx * r_ref(7);
                                  r_ref_counter <= 0;
                                  r_OPE <= 1;                                                                                                                                                                                    
                    end case;
                    if(r_load_flag = '0') then -- in case this is the first input 
                        r_I_result <= 0; -- set the I and Q result registers to 0
                        r_Q_result <= 0;
                        r_load_count <= 0;
                    elsif(r_load_flag = '1') then -- if it's not the first input
                        r_I_result <= r_I_add; -- the previous addition result is set to
                        r_Q_result <= r_Q_add; -- the I and Q result register respectively
                    end if;
------------------------------------------------------------------------------        
                elsif(i_CE = '1') and (r_OPE = 1) then -- when clock enable is high and it's the second pipeline function               
                    r_I_add <= r_I_multiply + r_I_result; -- add the results of the multiplication with the
                    r_Q_add <= r_Q_multiply + r_Q_result; -- the previous addition results
                    r_OPE <= 2; -- set the pipline operand to 2
                    r_load_flag <= '1'; -- set the load flag to '1'
                    r_load_count <= r_load_count +1; -- increment the load count by one
------------------------------------------------------------------------------        
                -- when clock enable is high, it's the third pipeline function and the result counter hasn't reached its max value
                elsif (i_CE = '1') and (r_OPE = 2) and (r_res < 8) then
                    r_acc_I <= STD_LOGIC_VECTOR ( TO_UNSIGNED ( r_I_add, o_acc_I ' length)); -- convert the results into SLV 
                    r_acc_Q <= STD_LOGIC_VECTOR ( TO_UNSIGNED ( r_Q_add, o_acc_Q ' length));   
                    r_res <= r_res +1; -- increment the result register by one
                    r_OPE <= 0; -- reset the pipeline operand to start again
                    if ( r_load_count = 8) then -- if load count reached its max value
                        r_I_result <= 0; -- clear all the register to restart the
                        r_Q_result <= 0; -- multiply accumulate operation
                        r_load_flag <= '0';
                        r_load_count <= 0;
                    end if;   
------------------------------------------------------------------------------  
                elsif (r_res = 8) then -- if the result counter has reached its max value
                    o_acc_I <= r_acc_I; -- allocate the I and Q results to their corresponding output
                    o_acc_Q <= r_acc_Q; 
                    r_res <= 0; -- clear the result counter
                    if (r_Sym_Count = 0) then
                        o_Sym_Rx <= "00"; -- set the received symbol indicator to zero
                        r_Sym_count <= r_Sym_count +1; -- increment the symbol indicator counter
                    elsif (r_Sym_count = 1) then -- when the symbol indicator counter is one
                        o_Sym_Rx <= "01"; -- set the received symbol indicator to one
                        r_Sym_count <= r_Sym_count +1;
                    elsif (r_Sym_count = 2) then -- when the symbol indicator counter is two
                        o_Sym_Rx <= "10"; -- set the received symbol indicator to two
                        r_Sym_count <= 0; -- clear its counter
                    end if;                    
                end if; 
------------------------------------------------------------------------------                        
            elsif(i_start_bit = '0') then -- if start bit is zero,
               r_I_result <= 0; -- and all the counters
               r_Q_result <= 0;
               r_load_flag <= '0';
               r_load_count <= 0;            
            end if;        
        end if;
    end process;
end Behavioral;