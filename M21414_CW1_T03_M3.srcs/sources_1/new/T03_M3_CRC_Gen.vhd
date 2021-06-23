----------------------------------------------------------------------------------
-- Team 03 - 900615 & 901070
-- Module name: CRC Generator entity block
-- Project name: Coursework 1 - Milestone 3
-- Target Devices: Basys 3 Artix7 XC7A35T cpg236 -1   
----------------------------------------------------------------------------------
-- initialisation of IEEE liblary 
-- to use standard logic and maths functions
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- declaration of the CRC Generator entity block --------------------------------
entity T03_M3_CRC_Gen is
  Port (-- inputs
        i_Clk, i_Rst: in STD_LOGIC; -- master clock and reset
        i_CE: in STD_LOGIC; -- clock enable signal
        i_Data_4_bit: in STD_LOGIC_VECTOR (3 downto 0); -- data in from the data generator
        i_CRC_Check : in STD_LOGIC;
        -- outputs
        o_Data_6_bit : out STD_LOGIC_VECTOR(5 downto 0);        
        o_CRC_Ready : out STD_LOGIC --high when the calculation is done.
        ); 
end T03_M3_CRC_Gen;
-- architecture declaration of the CRC Generator --------------------------------
architecture Behavioral of T03_M3_CRC_Gen is
signal crc : STD_LOGIC_VECTOR(0 to 2) := "110"; -- set the crc gen value
signal count : integer :=0 ;
signal position : integer range 0 to 3;
signal crc_temp : STD_LOGIC_VECTOR(5 downto 0) := (others => '0');
signal r_Data : std_logic_vector(3 downto 0) := (others => '0');
----------------------------------------------------------------------------------
begin
process(i_Clk,i_Rst,i_CE,i_CRC_Check,i_Data_4_bit)
begin
    if(i_Rst = '1') then -- if reset is high 
        crc_temp <= (others => '0'); -- set output to 0
        count <= 5;                 -- reset count
        o_CRC_Ready <= '0';        -- set ready bit low
    elsif(rising_edge(i_Clk)) then -- on rising edge of the clock
      if (i_CE = '1') and (position = 0) and (i_CRC_Check = '1')then  -- if clock enable is high and position integer is 0 and crc check bit is high
         position <= 1;                          -- set the position to 1
      elsif (i_CE = '1') and (position = 0) and (i_CRC_Check = '0')then -- if clock enable is high and position is 0 and crc check bit is low
         r_Data  <= i_Data_4_bit;  -- move the input to register
         position <= 1;            -- set position to 1
      elsif (i_CE = '1') and (position = 1)then  -- if ce is high and position is 1
          crc_temp(1 downto 0) <= (others=> '0');  --set the last two bits of the register to 0
         crc_temp(5 downto 2) <= r_Data(3 downto 0); -- push the data to the first four bits
         position <= 2; -- set position to 2
      elsif(i_CE = '1') and (position = 2) then -- if ce is high and position is 0
        if (crc_temp(count)='1') and (count > 1) then  -- if the value at position count is 1 and count is not at min
          crc_temp(count) <= crc_temp(count) xor crc(0);  -- xor the value of the register at count with the first bit of the generator
          crc_temp(count-1) <= crc_temp(count-1) xor crc(1); -- xor the value of the register at count-1 with the second bit of the generator
          crc_temp(count-2) <= crc_temp(count-2) xor crc(2); -- xor the value of the register at count-2 with the third bit of the generator
          count <= count - 1;                -- decrement count
        elsif (crc_temp(count)='0') and (count > 1)then  -- els if the value at position count is 0 and the count is not at min
          count <= count-1;                  -- decrement count
        elsif(count < 2) then -- else when the value of count is at min
            count <= 5;      -- reset count
            position <= 0;   -- reset position
            o_CRC_Ready <= '0';  -- set ready bit
            o_Data_6_bit(5 downto 2) <= r_Data(3 downto 0); -- push the original data to the frist  four bits of the register
            o_Data_6_bit(1 downto 0) <= crc_temp(1 downto 0);  -- push the last two bits of the register to the last two bits of the output
        end if;                                                -- to be used as the check bits
      end if;
    end if; 
end process;    
end Behavioral;