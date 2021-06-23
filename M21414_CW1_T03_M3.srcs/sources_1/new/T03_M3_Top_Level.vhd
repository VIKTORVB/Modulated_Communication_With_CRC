----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: Top level entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1  
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.I_Q_Array.ALL;
----------------------------------------------------------------------------------
entity T03_M3_Top_Level is
  Port (-- inputs
           i_C100MHZ, i_Rst, i_Fast, i_Push : in STD_LOGIC; -- 100 MHz system clock
           i_Data_switches : in STD_LOGIC_VECTOR (3 downto 0);
           i_Display_switches : in STD_LOGIC_VECTOR (2 downto 0);
           i_Error_switches : in STD_LOGIC_VECTOR ( 1 downto 0);          
           -- outputs
           o_LED10 : out STD_LOGIC;
           o_LED11 : out STD_LOGIC;
           o_LED12 : out STD_LOGIC;           
           o_SegmentDP : out STD_LOGIC; -- 7-segment display decimal point
           o_SegmentAnode : out STD_LOGIC_VECTOR (3 downto 0); -- 7-segment display anodes
           o_SegmentCathodes : out STD_LOGIC_VECTOR (6 downto 0)); -- 7-segment display cathodes
end T03_M3_Top_Level;
----------------------------------------------------------------------------------
architecture Behavioral of T03_M3_Top_Level is
        -- declare a master clock register for the output from the DCM
        signal r_MasterClock : STD_LOGIC;
        -- declaration of registers for the clock enable signals
        signal w_CE_250Hz, w_CE_1Hz, w_CE_2Hz,w_CE_16Hz, w_CE_22Hz, w_CE_100Hz : STD_LOGIC;
        -- and their integer values for the required frequencies 
        constant c_CE_250Hz : integer := 400000;
        constant c_CE_100Hz : integer := 1000000;
        constant c_CE_1Hz : integer := 100000000;
        constant c_CE_2Hz : integer := 50000000;
        constant c_CE_16Hz : integer := 6250000;
        constant c_CE_22Hz : integer := 4545454;      
        -- output for the debounce entity
        signal r_Data_Select : STD_LOGIC_VECTOR (3 downto 0);
        signal r_Push_Debounce : STD_LOGIC; 
        signal r_Error_Select : STD_LOGIC_VECTOR (1 downto 0); -- debounced error select         
        signal r_Display_Select : STD_LOGIC_VECTOR (2 downto 0); -- debounced display select
        -- Student number register
        signal r_StudentNum :  STD_LOGIC_VECTOR (3 downto 0);
        -- 0-F counter register
        signal r_Counter :  STD_LOGIC_VECTOR (3 downto 0);
        -- Random number register
        signal r_Rand_num :  STD_LOGIC_VECTOR (3 downto 0);
        -- counter signal register with the corresponding range
        signal r_digitSelect : STD_LOGIC_VECTOR (1 downto 0);     
        -- Start / Stop button register
        signal r_Start_Stop : STD_LOGIC;
        -- Symbol converter registers
        signal r_Data_4_bit: STD_LOGIC_VECTOR (3 downto 0);
        signal r_Data_6_bit : STD_LOGIC_VECTOR(5 downto 0);                
        signal r_Data_2_bit_0: STD_LOGIC_VECTOR (3 downto 0);
        signal r_Data_2_bit_1: STD_LOGIC_VECTOR (3 downto 0);        
        signal r_Symbol: STD_LOGIC_VECTOR (1 downto 0);         
        -- Data select register
        signal r_Select_Value : STD_LOGIC_VECTOR (3 downto 0);
        signal r_valueRead : STD_LOGIC_VECTOR (3 downto 0);        
        -- CRC gen and check data register
        signal r_CRC_Check_Ready : STD_LOGIC;
        signal r_CRC_Ready : STD_LOGIC;
        signal r_CRC_Check : STD_LOGIC; 
        signal r_Data_Rx : STD_LOGIC_VECTOR(3 downto 0);        
        -- Modulator Scheme B registers 
        signal r_mod_B_I : STD_LOGIC_VECTOR (7 downto 0); -- modulated I channel data sequence
        signal r_mod_B_Q : STD_LOGIC_VECTOR (7 downto 0); -- modulated Q channel data sequence
        signal r_start_bit : STD_LOGIC;  -- start/stop bit  
        -- Error Select Registers - Scheme B      
        signal r_Error_16 : STD_LOGIC_VECTOR (3 downto 0); -- 4-bit binary output
        signal r_Error_32 : STD_LOGIC_VECTOR (4 downto 0); -- 5-bit binary output
        signal r_Error_64 : STD_LOGIC_VECTOR (5 downto 0); -- 6-bit binary output  
        -- Noise Channel registers - Scheme B      
        signal r_channel_I_noise : STD_LOGIC_VECTOR (7 downto 0); -- I channel with additional noise
        signal r_channel_Q_noise : STD_LOGIC_VECTOR (7 downto 0); -- Q channel with additional noise        
        -- Multiply Accumulate registers - Scheme B
        signal r_Sym_Rx : STD_LOGIC_VECTOR(1 downto 0); -- received symbol sequence indicator
        signal r_acc_I : STD_LOGIC_VECTOR (17 downto 0); -- accumulated I channel
        signal r_acc_Q : STD_LOGIC_VECTOR (17 downto 0); -- accumulated Q channel        
        -- Demodulator registers - Scheme B
        signal r_Data_Demod_B : STD_LOGIC_VECTOR (5 downto 0); -- demodulated data value
        signal r_Symbol_Demod_B : STD_LOGIC_VECTOR (1 downto 0); -- demodulated symbol value    
        --Modulator A signals
        signal r_Data_2_bits: std_logic_vector(1 downto 0) := (others => '0');
        signal r_I_A: I := (others=>(others => '0'));
        signal r_Q_A: Q := (others=>(others => '0'));
        signal r_M_Ready: std_logic :='0';
        --Send A signals
        signal r_I_Modulated_A: std_logic_vector(7 downto 0) := (others => '0');
        signal r_Q_Modulated_A: std_logic_vector(7 downto 0) := (others => '0');
        signal r_Send_Done:  std_logic :='0';
         --Noise channel signals
        signal r_Rand_num_4_Bit : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
        signal r_Rand_num_5_Bit : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
        signal r_Rand_num_6_Bit : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
        signal r_Noise_Channel_Start: std_logic:='0';
        signal r_I_Noise_A: std_logic_vector(7 downto 0) := (others => '0');
        signal r_Q_Noise_A: std_logic_vector(7 downto 0) := (others => '0');
        -- Recive A signals 
        signal r_Recived : std_logic:='0';
        signal r_I_Recive: I := (others=>(others => '0'));
        signal r_Q_Recive: Q := (others=>(others => '0'));
        --Multiply Accumulate signals
        signal r_MA_Done: std_logic:='0';
        signal r_Result_I_A: std_logic_vector(17 downto 0) := (others => '0'); 
        signal r_Result_Q_A: std_logic_vector(17 downto 0) := (others => '0');
        -- Demodulator A signals
        signal r_Demodulated_2_Bits_A: std_logic_vector(1 downto 0);
        signal r_Demodulation_Done: std_logic:='0'; 
        -- Reconstructor signals
        signal r_Reconstructed_Data_A : std_logic_vector(5 downto 0) := (others => '0');            
----------------------------------------------------------------------------------
        -- DCM generated component declaration
        -- this was copied from the clk_wiz_0_stub.vhdl
        component clk_wiz_0 is
            Port(clk_out1 : out STD_LOGIC;
                 reset : in STD_LOGIC;
                 locked : out STD_LOGIC;
                 clk_in1 : in STD_LOGIC);
         end component;      
----------------------------------------------------------------------------------           
begin
    -- In this following section we are instantiating all the lower level entities
    -- to connect all circuit elements in one top level
    
    -- instantiate the system clock DCM block
    system_DCM : clk_wiz_0 port map (clk_out1 => r_MasterClock,
                reset => i_Rst, clk_in1 => i_C100MHz);
    -- instantiate clock enable entity to set the 1 Hz CE signal
    clockEnable_1Hz : entity work.T03_M3_ClockEnable(Behavioral)
         Generic map ( g_maxCount => c_CE_1Hz)
         Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst,
         i_Fast => i_Fast, o_CE => w_CE_1Hz); 

    -- instantiate clock enable entity to set the 100 Hz CE signal
    clockEnable_100Hz : entity work.T03_M3_ClockEnable(Behavioral)
         Generic map ( g_maxCount => c_CE_100Hz)
         Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst,
         i_Fast => i_Fast, o_CE => w_CE_100Hz);         
                              
    -- instantiate clock enable entity to set the 2 Hz CE signal
    clockEnable_2Hz : entity work.T03_M3_ClockEnable(Behavioral)
         Generic map ( g_maxCount => c_CE_2Hz)
         Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst,
         i_Fast => i_Fast, o_CE => w_CE_2Hz); 
                       
     -- instantiate clock enable entity to set the 250 Hz CE signal 
    clockEnable_250Hz : entity work.T03_M3_ClockEnable(Behavioral)
         Generic map ( g_maxCount => c_CE_250Hz)
         Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst,
         i_Fast => i_Fast, o_CE => w_CE_250Hz);   
           
     -- instantiate clock enable entity to set the 16 Hz CE signal
    clockEnable_16Hz : entity work.T03_M3_ClockEnable(Behavioral)
         Generic map ( g_maxCount => c_CE_16Hz)
         Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst,
         i_Fast => i_Fast, o_CE => w_CE_16Hz);         
         
     -- instantiate clock enable entity to set the 22 Hz CE signal
    clockEnable_22Hz : entity work.T03_M3_ClockEnable(Behavioral)
         Generic map ( g_maxCount => c_CE_22Hz)
         Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst,
         i_Fast => i_Fast, o_CE => w_CE_22Hz);            
   
    -- instantiate the debounce entity
    debounce_inst : entity work.T03_M3_Debounce(Behavioral)
        Port map ( i_Clk => r_MasterClock, i_Rst => i_Rst, o_Error_Select => r_Error_Select, o_Display_Select => r_Display_Select,                              
        i_Push => i_Push, i_Error_switches => i_Error_switches, i_Display_switches => i_Display_switches,
        i_Data_switches => i_Data_switches, o_Data_Select => r_Data_Select, o_Push_Debounce => r_Push_Debounce);
        
    -- instantiate start stop entity
    startStop_latch : entity work.T03_M3_StartStop(Behavioral)
        Port map ( i_Clk => r_MasterClock, i_CE => w_CE_100Hz, i_Push_Debounce => r_Push_Debounce, o_Start_Stop => r_Start_Stop);      
   
   -- instantiate Student Number entity
   studentNum : entity work.T03_M3_StudentNum(Behavioral)
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_1Hz,
        i_Data_Select => r_Data_Select, o_StudentNum => r_StudentNum);
            
    -- instantiate 0-F counter entity
    counter_0_F : entity work.T03_M3_Counter_0_F(Behavioral)
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_1Hz,
        i_Data_Select => r_Data_Select, o_Counter => r_Counter);
        
    -- instantiate random number generator entity
    randNum : entity work.T03_M3_Random_num(Behavioral)
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_1Hz,        
        o_Rand_num => r_Rand_num, i_Data_Select => r_Data_Select);
        
    -- instantiate data generator entity
    dataGen : entity work.T03_M3_DataGen(Behavioral)
        Port map (i_Clk => r_MasterClock, i_CE => w_CE_1Hz, i_Rst => i_Rst, i_Start_Stop => r_Start_Stop,
        i_Data_Select => r_Data_Select, i_Counter => r_Counter, i_Rand_num => r_Rand_num, 
        i_StudentNum => r_StudentNum, o_Select_Value => r_Select_Value, o_Data_4_bit => r_Data_4_bit);
        
    -- instantiate select counter entity
    selectCount : entity work.T03_M3_SelectCounter(Behavioral)
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_250Hz, o_digitSelect => r_digitSelect);       
        
    --instantiate MUX entity
    MUX : entity work.T03_M3_MUX(Behavioral)
        Port map (i_Clk => r_MasterClock, i_Select_Value => r_Select_Value, i_Rst => i_Rst,
        i_Data_4_bit => r_Data_4_bit, i_digitSelect => r_digitSelect, i_Display_Select => r_Display_Select, i_Data_Rx => r_Data_Rx, 
        i_channel_I_noise => r_channel_I_noise, i_channel_Q_noise => r_channel_Q_noise, i_mod_B_I => r_mod_B_I, i_mod_B_Q => r_mod_B_Q,      
        i_Data_2_bit_0 => r_Data_2_bit_0, i_Data_2_bit_1 => r_Data_2_bit_1, o_valueRead => r_valueRead , o_SegmentAnode => o_SegmentAnode,
        i_Q_Modulated_A => r_Q_Modulated_A,i_I_Modulated_A => r_I_Modulated_A,i_I_Noise_A => r_I_Noise_A, i_Q_Noise_A => r_Q_Noise_A);
        
    -- instantiate symbol converter entity
    symbolConv : entity work.T03_M3_SymbolConverter(Behavioral)
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_2Hz, i_Data_4_bit => r_Data_4_bit,       
        i_Data_Select => r_Data_Select, o_Data_2_bit_0 => r_Data_2_bit_0, o_Data_2_bit_1 => r_Data_2_bit_1,
        i_Display_Select => r_Display_Select, i_Data_6_bit => r_Data_6_bit, o_Symbol => r_Symbol,
        o_LED10 => o_LED10, o_LED11 => o_LED11, o_LED12 => o_LED12, i_Start_Stop => r_Start_Stop);
        
    -- instantiate display driver entity
    dispDriver : entity work.T03_M3_DisplayDriver(Behavioral)
        Port map (i_valueRead => r_valueRead, o_SegmentDP => o_SegmentDP, o_SegmentCathodes => o_SegmentCathodes);          
        
    -- instantiate CRC generator entity
    crcGen : entity work.T03_M3_CRC_Gen(Behavioral)        
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_100Hz, i_Data_4_bit => r_Data_4_bit,
        o_Data_6_bit => r_Data_6_bit, i_CRC_Check => r_CRC_Check, o_CRC_Ready => r_CRC_Ready);
    
    -- instantiate CRC generator entity
    crcCheck : entity work.T03_M3_CRC_Check(Behavioral)        
        Port map (i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_16Hz, i_Data_Demod_B => r_Data_Demod_B, i_Start_Stop => r_Start_Stop,
        i_CRC_Ready => r_CRC_Ready, o_CRC_Check_Ready => r_CRC_Check_Ready, i_Display_Select => r_Display_Select, 
        o_CRC_Check => r_CRC_Check, o_Data_Rx => r_Data_Rx, i_Reconstructed_Data_A => r_Reconstructed_Data_A);        
               
    -- instantiate modulator scheme B               
    mod_scheme_B : entity work.T03_M3_Modulator_B(Behavioral)
        Port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_100Hz, i_Symbol => r_Symbol, o_mod_B_I => r_mod_B_I,
        o_mod_B_Q => r_mod_B_Q, o_start_bit => r_start_bit); 
        
    -- instantiate error select - scheme B
    error_sel_B : entity work.T03_M3_Error_Select_B(Behavioral)     
        Port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_100Hz, o_Error_16 => r_Error_16,
        o_Error_32 => r_Error_32, o_Error_64 => r_Error_64);
        
    -- instantiate noisel channel - scheme B
    noise_chan_B : entity work.T03_M3_Noise_Channel_B(Behavioral)
        Port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_100Hz, i_Error_16 => r_Error_16, i_Error_32 => r_Error_32, 
        i_Error_64 => r_Error_64, i_mod_B_I => r_mod_B_I, i_mod_B_Q => r_mod_B_Q, i_Error_Select => r_Error_Select,       
        o_channel_I_noise => r_channel_I_noise, o_channel_Q_noise => r_channel_Q_noise);

    -- instantiate multiply accumulate - scheme B
    multiply_acc_B : entity work.T03_M3_Multiply_Acc_B(Behavioral)       
        Port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_100Hz, i_channel_I_noise => r_channel_I_noise, i_channel_Q_noise => r_channel_Q_noise,
        i_start_bit => r_start_bit, o_Sym_Rx => r_Sym_Rx, o_acc_I => r_acc_I, o_acc_Q => r_acc_Q);
        
    -- instantiate demodulator - scheme B
    demodulator_B : entity work.T03_M3_Demodulator_B(Behavioral) 
        Port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_100Hz, i_Sym_Rx => r_Sym_Rx, i_acc_I => r_acc_I, i_acc_Q => r_acc_Q,
        o_Data_Demod_B => r_Data_Demod_B, o_Symbol_Demod_B => r_Symbol_Demod_B);        
   
    -- instantiate modulator scheme A         
    Modulation_A: entity work.M3_T03_Modulator_A(Behavioral)
        Port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_2Hz,
        i_Data_2_bits => r_Symbol, o_I_A => r_I_A,o_Q_A => r_Q_A,o_M_Ready => r_M_Ready); 
    -- instantiate Send A     
    Send_A: entity work.M3_T03_Send(Behavioral)
    port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_16Hz,
             i_I_A => r_I_A,i_Q_A => r_Q_A,o_I_Modulated_A => r_I_Modulated_A,
             o_Q_Modulated_A => r_Q_Modulated_A,o_Send_Done => r_Send_Done, i_M_Ready => r_M_Ready);
    -- instantiate Noise channel A    
    Noise_Channel_A : entity work.M3_T03_Noise_Channel(Behavioral)
    Port map(i_Clk => r_MasterClock, i_CE => w_CE_16Hz, i_Rst => i_Rst, i_Error_Select => r_Error_Select,
             i_Rand_num_4_Bit => r_Rand_num_4_Bit,i_Rand_num_5_Bit => r_Rand_num_5_Bit,
             i_Rand_num_6_Bit => r_Rand_num_6_Bit,o_Q_Noise_A => r_Q_Noise_A,o_I_Noise_A => r_I_Noise_A,i_I_Modulated_A => r_I_Modulated_A
             ,i_Q_Modulated_A => r_Q_Modulated_A, o_Noise_Channel_Start => r_Noise_Channel_Start,i_Send_Done => r_Send_Done);
    -- instantiate Reciver A         
    Recive_A: entity work.M3_T03_Recive(Behavioral)
    port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_16Hz,
             i_I_Noise_A => r_I_Noise_A, i_Q_Noise_A => r_Q_Noise_A, o_I_Recived => r_I_Recive, o_Q_Recived => r_Q_Recive,
             i_Noise_Channel_Start => r_Noise_Channel_Start, o_Recived => r_Recived);
    -- instantiate Multiply accumulate operation A         
    Multiply_Accumulate_A : entity work.M3_T03_Multiply_Accumulate(Behavioral)
    Port map (
              i_Clk => r_MasterClock, i_CE => w_CE_22Hz, i_Rst => i_Rst,
              i_I_Recived => r_I_Recive,i_Q_Recived => r_Q_Recive, o_Result_I_A => r_Result_I_A,
              o_Result_Q_A => r_Result_Q_A, o_MA_Done => r_MA_Done, i_Recived => r_Recived
              );
   -- instantiate Demodulator scheme A           
   Demodulate_A : entity work.M3_T03_Demodulator(Behavioral)
    Port map(i_Clk => r_MasterClock, i_CE => w_CE_2Hz, i_Rst => i_Rst, i_Result_I_A => r_Result_I_A,
             i_Result_Q_A => r_Result_Q_A, o_Demodulated_2_Bits_A => r_Demodulated_2_Bits_A,
             o_Demodulation_Done=>r_Demodulation_Done,i_MA_Done=>r_MA_Done);
   -- instantiate Reconstructor A           
   Reconstruct_A: entity work.M3_T03_Reconstruct(Behavioral)
    port map(i_Clk => r_MasterClock, i_Rst => i_Rst, i_CE => w_CE_2Hz,
             i_Demodulated_2_Bits_A => r_Demodulated_2_Bits_A, o_Reconstructed_Data_A => r_Reconstructed_Data_A,
             i_MA_Done=>r_MA_Done,i_Demodulation_Done=>r_Demodulation_Done);                 
end Behavioral;