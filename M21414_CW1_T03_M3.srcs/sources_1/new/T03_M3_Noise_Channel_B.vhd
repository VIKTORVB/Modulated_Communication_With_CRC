----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Noise CHannel - B entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- declaration of the Noise Channel - B entity block------------------------------
entity T03_M3_Noise_Channel_B is
 Port ( -- inputs
        i_Clk, i_Rst : in STD_LOGIC; -- master clock and reset inputs
        i_CE : in STD_LOGIC; -- clock enable signal same as modulator
        i_Error_16 : in STD_LOGIC_VECTOR (3 downto 0); -- 4-bit error value
        i_Error_32 : in STD_LOGIC_VECTOR (4 downto 0); -- 5-bit error value
        i_Error_64 : in STD_LOGIC_VECTOR (5 downto 0); -- 6-bit error value
        i_mod_B_I : in STD_LOGIC_VECTOR (7 downto 0); -- I_channel input
        i_mod_B_Q : in STD_LOGIC_VECTOR (7 downto 0); -- Q_channel input
        i_Error_Select : in STD_LOGIC_VECTOR (1 downto 0); -- debounced error select
        -- outputs
        o_channel_I_noise : out STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
        o_channel_Q_noise : out STD_LOGIC_VECTOR (7 downto 0) -- Q channel with additional noise
        ); 
end T03_M3_Noise_Channel_B;
-- architecure declaration for the Noise Channel - B entity block --------------------------------
architecture Behavioral of T03_M3_Noise_Channel_B is
-- error signal registers that will be used for the arithmetic functions
signal r_error_16 : integer range -16 to 16;
signal r_error_32 : integer range -32 to 32;
signal r_error_64 : integer range -64 to 64;
-- I and Q channel register that will be used for the arithmetic functions
signal r_int_I : integer range 0 to 255;
signal r_int_Q : integer range 0 to 255;
-- I and Q channel registers with the additional noise value
signal r_noise_I : STD_LOGIC_VECTOR (7 downto 0);
signal r_noise_Q : STD_LOGIC_VECTOR (7 downto 0);
-------------------------------------------------
begin
-- convert the random error values to signed integers to be able add or subtract  
r_error_16 <= TO_INTEGER (SIGNED (i_Error_16));
r_error_32 <= TO_INTEGER (SIGNED (i_Error_32));
r_error_64 <= TO_INTEGER (SIGNED (i_Error_64));
-- convert the I and Q data sequence to integer 
r_int_I <= TO_INTEGER (UNSIGNED (i_mod_B_I));
r_int_Q <= TO_INTEGER (UNSIGNED (i_mod_B_Q));
--------------------------------------------------
    noise_generation : process (i_Clk, i_CE, i_Rst, i_Error_Select, i_mod_B_I, i_mod_B_Q)  
    begin
        if (i_Rst = '1') then -- if Reset is set
            r_noise_I <= i_mod_B_I; -- 
            r_noise_Q <= i_mod_B_Q;
        elsif(rising_edge (i_Clk)) then -- on the rising edge of the master clock             
            if(i_CE = '1') then -- when CE is high
               case i_Error_Select is -- check which Error Select is activated
                -- no error is selected
                when "00" => r_noise_I <= i_mod_B_I; -- I and Q stays the same
                             r_noise_Q <= i_mod_B_Q; -- their input values being allocated to the corresponding registers
                -- 4-bit error select                     
                -- add the error value to the incoming I and Q data sequence and convert it back to SLV         
                when "01" => r_noise_I <= STD_LOGIC_VECTOR(TO_UNSIGNED((r_error_16 + r_int_I), r_noise_I' length));
                             r_noise_Q <= STD_LOGIC_VECTOR(TO_UNSIGNED((r_error_16 + r_int_Q), r_noise_Q' length));
                -- 5-bit error select                     
                -- add the error value to the incoming I and Q data sequence and convert it back to SLV              
                when "10" => r_noise_I <= STD_LOGIC_VECTOR(TO_UNSIGNED((r_error_32 + r_int_I), r_noise_I' length));
                             r_noise_Q <= STD_LOGIC_VECTOR(TO_UNSIGNED((r_error_32 + r_int_Q), r_noise_Q' length));
                -- 6-bit error select                     
                -- add the error value to the incoming I and Q data sequence and convert it back to SLV                              
                when "11" => r_noise_I <= STD_LOGIC_VECTOR(TO_UNSIGNED((r_error_64 + r_int_I), r_noise_I' length));
                             r_noise_Q <= STD_LOGIC_VECTOR(TO_UNSIGNED((r_error_64 + r_int_Q), r_noise_Q' length));                                                          
                when others => r_noise_I <= i_mod_B_I; -- "catch" statement, in case there's an unexpected state     
                               r_noise_Q <= i_mod_B_Q; -- keep the input channels unchanged                    
               end case;
            end if;
        end if;
    end process;
o_channel_I_noise <= r_noise_I; -- allocate the modified data sequence
o_channel_Q_noise <= r_noise_Q; -- to the correct output signals
end Behavioral;