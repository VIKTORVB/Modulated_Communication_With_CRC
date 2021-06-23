----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: CRC check entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and maths functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the CRC check entity block --------------------------------
entity T03_M3_CRC_Check is
 Port (-- inputs   
        i_Clk, i_Rst, i_Start_Stop: in STD_LOGIC; -- master clock and reset
        i_CE: in STD_LOGIC; -- clock enable signal
        i_CRC_Ready: in STD_LOGIC;
        i_Data_Demod_B : in STD_LOGIC_VECTOR(5 downto 0);
        i_Reconstructed_Data_A : in std_logic_vector(5 downto 0);  
        i_Display_Select : in STD_LOGIC_VECTOR (2 downto 0); -- debounced display select
        -- outputs      
        o_CRC_Check : out STD_LOGIC;        
        o_Data_Rx : out STD_LOGIC_VECTOR(3 downto 0));
end T03_M3_CRC_Check; 
-- architecture declaration of the CRC check --------------------------------
architecture Behavioral of T03_M3_CRC_Check is 
signal crc : std_logic_vector(0 to 2) := "110"; -- set the crc generator value
signal count_A : integer :=0 ;
signal count_B : integer :=0 ;
signal position_A : integer range 0 to 2;
signal position_B : integer range 0 to 2;
signal crc_temp_A : std_logic_vector(5 downto 0) := (others => '0');
signal crc_temp_B : std_logic_vector(5 downto 0) := (others => '0');
----------------------------------------------------------------------------------
begin
    CRC_Check : process(i_Clk,i_Rst)
    begin
        if(i_Rst = '1') then -- if reset is high 
            crc_temp_B <= (others => '0'); -- set output to 0
            count_B <= 5;  -- reset count
            o_CRC_Check <= '0';  -- set check bit low
        elsif(rising_edge(i_Clk)) then -- on rising edge of the clock
          if(i_Display_Select = "110") then  -- if the display select is in position for modulation B
           if (i_CE = '1') and (position_B = 0)then -- if clock enable is high and position is at 0
              crc_temp_B <= i_Data_Demod_B;  -- push input data to register
              position_B <= 1; -- set position to 1
           elsif(i_CE = '1') and (position_B = 1) then  -- if clock enable is high and position is at 1
             if (crc_temp_B(count_B)='1') and (count_B > 1) then -- if the value at position count is 1 and count is not at min
               crc_temp_B(count_B) <= crc_temp_B(count_B) xor crc(0);  -- xor the value of the register at count with the first bit of the generator
               crc_temp_B(count_B-1) <= crc_temp_B(count_B-1) xor crc(1); -- xor the value of the register at count-1 with the second bit of the generator
               crc_temp_B(count_B-2) <= crc_temp_B(count_B-2) xor crc(2); -- xor the value of the register at count-2 with the third bit of the generator
               count_B <= count_B - 1; -- decrement count
             elsif (crc_temp_B(count_B)='0') and (count_B > 1)then -- els if the value at position count is 0 and the count is not at min
               count_B <= count_B-1; -- decrement count
             elsif(count_B < 2) then -- else when the value of count is at min
               count_B <= 5;  -- reset count
               position_B <= 2;  -- reset position
             end if;
           elsif(position_B = 2) and (crc_temp_B /= "000000") then -- if position is at 2 and the register dose not equall to 0 and generator ready bit is low
             o_CRC_Check <= '1';  -- set check bit high
             position_B <= 0;  -- reset position
           elsif(position_B = 2) and (crc_temp_B = "000000")  then  -- if position is at 2 and the register dose equall to 0 and generator ready bit is low
             o_Data_Rx <= i_Data_Demod_B(5 downto 2); -- push the first four bits of the input data to output
             position_B <= 0; -- reset position
             o_CRC_Check <= '0';-- set check bit to low
           end if;
          elsif (i_Display_Select = "010") then -- if the display select is in position for modulation A do the same as B but with different inputs and outputs
           if (i_CE = '1') and (position_A = 0)then 
             crc_temp_A <= i_Reconstructed_Data_A;
             position_A <= 1;
           elsif(i_CE = '1') and (position_A = 1) then
             if (crc_temp_A(count_A)='1') and (count_A > 1) then
               crc_temp_A(count_A) <= crc_temp_A(count_A) xor crc(0);
               crc_temp_A(count_A-1) <= crc_temp_A(count_A-1) xor crc(1);
               crc_temp_A(count_A-2) <= crc_temp_A(count_A-2) xor crc(2);
               count_A <= count_A - 1;
             elsif (crc_temp_A(count_A)='0') and (count_A > 1)then
               count_A <= count_A-1;
             elsif(count_A < 2) then 
               count_A <= 5;
               position_A <= 2;
             end if;
           elsif(position_A = 2) and (crc_temp_A /= "000000") and (i_CRC_Ready = '0')then
             o_CRC_Check <= '1';
             position_A <= 0;
           elsif(position_A = 2) and (crc_temp_A = "000000") and (i_CRC_Ready = '0') then
             o_Data_Rx <= i_Reconstructed_Data_A(5 downto 2);
             position_A <= 0;
             o_CRC_Check <= '0';
        end if; 
      end if;
    end if;
    end process;    
end Behavioral;