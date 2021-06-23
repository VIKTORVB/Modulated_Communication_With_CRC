----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Demodulator - B entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- declaration of the Demodulator - B entity block------------------------------
entity T03_M3_Demodulator_B is
  Port (-- inputs
        i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset inputs
        i_CE : in STD_LOGIC; -- 100 Hz clock enable signal 
        i_acc_I : in STD_LOGIC_VECTOR (17 downto 0); -- accumulated I channel
        i_acc_Q : in STD_LOGIC_VECTOR (17 downto 0); -- accumulated Q channel
        i_Sym_Rx : in STD_LOGIC_VECTOR(1 downto 0); -- received symbol indicator
        -- outputs
        o_Data_Demod_B : out STD_LOGIC_VECTOR (5 downto 0); -- demodulated data value
        o_Symbol_Demod_B : out STD_LOGIC_VECTOR (1 downto 0) -- demodulated symbol value
         );
end T03_M3_Demodulator_B;
-- architecure declaration for the Demodulator - B entity block --------------------------------
architecture Behavioral of T03_M3_Demodulator_B is
---------------------------------------------------
signal r_acc_I : integer; -- integer registers to hold the accumulated I and Q values which will be compared 
signal r_acc_Q : integer; -- against a known range to decide if the transmitted sequence was a '0' or a '1'
signal r_Data_Demod : STD_LOGIC_VECTOR (3 downto 0);
signal r_mid_zero : integer := 118784;
signal r_mid_one : integer := 143360;
signal r_mid_null : integer := 131072;
---------------------------------------------------
begin
    -- start the demodulation process with the required signals
    demodulation : process (i_Clk, i_CE, i_Rst, i_Sym_Rx, i_acc_I, i_acc_Q)
    begin
    r_acc_I <= TO_INTEGER (UNSIGNED (i_acc_I)); -- convert the input I and Q values
    r_acc_Q <= TO_INTEGER (UNSIGNED (i_acc_Q)); -- to their integer equivalent
    if (i_Rst = '1') then -- if Reset is set
        r_acc_I <= 0; -- clear the input registers
        r_acc_Q <= 0;
    elsif (rising_edge (i_Clk)) then -- on the rising edge of the master clock
        if (i_CE = '1') then -- when clock enable is high
            case i_Sym_Rx is
                -- when the first symbol pair is received
                when "00" => -- compare the I and Q values against a pre set range to determine the received symbol
                            if ((r_acc_I > 50000 ) and ( r_acc_I < 160000)) and ((r_acc_Q > 60000 ) and ( r_acc_Q < 200000)) then 
                                r_Data_Demod (1 downto 0) <= "00"; -- set the correct values to a hold register
                                o_Symbol_Demod_B <= "00"; -- output the demodulated symbol - only for simulation purposes
                            elsif ((r_acc_I > 60000 ) and ( r_acc_I < 200000)) and ((r_acc_Q > 50000 ) and ( r_acc_Q < 160000)) then -- the previous steps are repeated to go through all possibile symbols     
                                r_Data_Demod (1 downto 0) <= "10";
                                o_Symbol_Demod_B <= "10";    
                            elsif ((r_acc_I > 70000 ) and ( r_acc_I < 210000)) and ((r_acc_Q > 60000 ) and ( r_acc_Q < 200000)) then      
                                r_Data_Demod (1 downto 0) <= "11";
                                o_Symbol_Demod_B <= "11";                             
                            elsif ((r_acc_I > 60000 ) and ( r_acc_I < 200000)) and ((r_acc_Q > 70000 ) and ( r_acc_Q < 210000)) then     
                                 r_Data_Demod (1 downto 0) <= "01";
                                o_Symbol_Demod_B <= "01";       
                            end if;
                -- after the second symbol pair is received           
                when "01" => -- compare the I and Q values to determine the received symbol
                            if ((r_acc_I > 50000 ) and ( r_acc_I < 160000)) and ((r_acc_Q > 60000 ) and ( r_acc_Q < 200000)) then 
                                r_Data_Demod (3 downto 2) <= "00"; -- allocate the demodulated symbol value to the last two bits
                                o_Symbol_Demod_B <= "00"; -- output the demodulated symbol
                            elsif ((r_acc_I > 60000 ) and ( r_acc_I < 200000)) and ((r_acc_Q > 50000 ) and ( r_acc_Q < 160000)) then -- the previous steps are repeated to go through all possibile symbols     
                                r_Data_Demod (3 downto 2) <= "10";
                                o_Symbol_Demod_B <= "10";  
                            elsif ((r_acc_I > 70000 ) and ( r_acc_I < 210000)) and ((r_acc_Q > 60000 ) and ( r_acc_Q < 200000)) then      
                                r_Data_Demod (3 downto 2) <= "11";
                                o_Symbol_Demod_B <= "11";                                  
                            elsif ((r_acc_I > 60000 ) and ( r_acc_I < 200000)) and ((r_acc_Q > 70000 ) and ( r_acc_Q < 210000)) then     
                                r_Data_Demod (3 downto 2) <= "01";
                                o_Symbol_Demod_B <= "01";    
                            end if;         
                when "10" => -- compare the I and Q values to determine the received symbol
                            if ((r_acc_I > 50000 ) and ( r_acc_I < 160000)) and ((r_acc_Q > 60000 ) and ( r_acc_Q < 200000)) then 
                                o_Data_Demod_B(3 downto 0) <=r_Data_Demod;
                                o_Data_Demod_B(5 downto 4) <= "00"; -- allocate the demodulated symbol value to the last two bits
                                o_Symbol_Demod_B <= "00"; -- output the demodulated symbol
                            elsif ((r_acc_I > 60000 ) and ( r_acc_I < 200000)) and ((r_acc_Q > 50000 ) and ( r_acc_Q < 160000)) then -- the previous steps are repeated to go through all possibile symbols     
                                o_Data_Demod_B(3 downto 0) <=r_Data_Demod;
                                o_Data_Demod_B(5 downto 4) <= "10";
                                o_Symbol_Demod_B <= "10";  
                            elsif ((r_acc_I > 70000 ) and ( r_acc_I < 210000)) and ((r_acc_Q > 60000 ) and ( r_acc_Q < 200000)) then      
                                o_Data_Demod_B(3 downto 0) <=r_Data_Demod;
                                o_Data_Demod_B(5 downto 4) <= "11";
                                o_Symbol_Demod_B <= "11";                                  
                            elsif ((r_acc_I > 60000 ) and ( r_acc_I < 200000)) and ((r_acc_Q > 70000 ) and ( r_acc_Q < 210000)) then     
                                o_Data_Demod_B(3 downto 0) <=r_Data_Demod;
                                o_Data_Demod_B(5 downto 4) <= "01";
                                o_Symbol_Demod_B <= "01";    
                            end if;                                           
                when others => o_Data_Demod_B <= "------";   
                               o_Symbol_Demod_B <="--";                              
            end case;
        end if;            
    end if;
    end process;
end Behavioral;