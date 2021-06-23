## This file is a general .xdc for the Basys3 rev B board
## Support material created by Xilinx 
## Available from:
## https://www.xilinx.com/support/documentation/university/Vivado-Teaching/HDL-Design/2015x/Basys3/Supporting%20Material/Basys3_Master.xdc

## Clock signal
set_property PACKAGE_PIN W5 [get_ports i_C100MHZ]							
set_property IOSTANDARD LVCMOS33 [get_ports i_C100MHZ]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_C100MHZ]

## Switches
#SWO
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {i_Fast}]
#SW7
set_property -dict { PACKAGE_PIN W13 IOSTANDARD LVCMOS33 } [get_ports {i_Display_switches[0]}]
#SW8
set_property -dict { PACKAGE_PIN V2 IOSTANDARD LVCMOS33 } [get_ports {i_Display_switches[1]}]
#SW9
set_property -dict { PACKAGE_PIN T3 IOSTANDARD LVCMOS33 } [get_ports {i_Display_switches[2]}]
#SW10
set_property -dict { PACKAGE_PIN T2 IOSTANDARD LVCMOS33 } [get_ports {i_Error_switches[0]}] 
#SW11
set_property -dict { PACKAGE_PIN R3 IOSTANDARD LVCMOS33 } [get_ports {i_Error_switches[1]}]
#SW12
set_property -dict { PACKAGE_PIN W2 IOSTANDARD LVCMOS33 } [get_ports {i_Data_switches[0]}]
#SW13
set_property -dict { PACKAGE_PIN U1 IOSTANDARD LVCMOS33 } [get_ports {i_Data_switches[1]}]
#SW14
set_property -dict { PACKAGE_PIN T1 IOSTANDARD LVCMOS33 } [get_ports {i_Data_switches[2]}]
#SW15
set_property -dict { PACKAGE_PIN R2 IOSTANDARD LVCMOS33 } [get_ports {i_Data_switches[3]}]    
     
##7 segment display
## Segment Cathodes
set_property PACKAGE_PIN W7 [get_ports {o_SegmentCathodes[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[0]}]
set_property PACKAGE_PIN W6 [get_ports {o_SegmentCathodes[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[1]}]
set_property PACKAGE_PIN U8 [get_ports {o_SegmentCathodes[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[2]}]
set_property PACKAGE_PIN V8 [get_ports {o_SegmentCathodes[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[3]}]
set_property PACKAGE_PIN U5 [get_ports {o_SegmentCathodes[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[4]}]
set_property PACKAGE_PIN V5 [get_ports {o_SegmentCathodes[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[5]}]
set_property PACKAGE_PIN U7 [get_ports {o_SegmentCathodes[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentCathodes[6]}]
## Segment decimal point
set_property PACKAGE_PIN V7 [get_ports o_SegmentDP]							
	set_property IOSTANDARD LVCMOS33 [get_ports o_SegmentDP]
## Segment Anodes
set_property PACKAGE_PIN U2 [get_ports {o_SegmentAnode[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentAnode[0]}]
set_property PACKAGE_PIN U4 [get_ports {o_SegmentAnode[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentAnode[1]}]
set_property PACKAGE_PIN V4 [get_ports {o_SegmentAnode[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentAnode[2]}]
set_property PACKAGE_PIN W4 [get_ports {o_SegmentAnode[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_SegmentAnode[3]}]

##Buttons
set_property PACKAGE_PIN U18 [get_ports i_Rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports i_Rst]
	
set_property PACKAGE_PIN U17 [get_ports i_Push]						
	set_property IOSTANDARD LVCMOS33 [get_ports i_Push]	
	
##LEDs
set_property PACKAGE_PIN W3 [get_ports {o_LED10}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_LED10}]
set_property PACKAGE_PIN U3 [get_ports {o_LED11}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_LED11}]	
set_property PACKAGE_PIN P3 [get_ports {o_LED12}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {o_LED12}]	
	
# Bitstream configuration
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]