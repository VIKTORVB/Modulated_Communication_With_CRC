
t
Command: %s
1870*	planAhead2?
+open_checkpoint T03_M3_Top_Level_routed.dcp2default:defaultZ12-2866h px? 
^

Starting %s Task
103*constraints2#
open_checkpoint2default:defaultZ18-103h px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.138 . Memory (MB): peak = 1013.289 ; gain = 0.0002default:defaulth px? 
V
Loading part %s157*device2#
xc7a35tcpg236-12default:defaultZ21-403h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0802default:default2
1013.2892default:default2
0.0002default:defaultZ17-268h px? 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
2132default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2020.12default:defaultZ1-479h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
L
*Restoring timing data from binary archive.264*timingZ38-478h px? 
F
$Binary timing data restore complete.265*timingZ38-479h px? 
L
*Restoring constraints from binary archive.481*projectZ1-856h px? 
E
#Binary constraint restore complete.478*projectZ1-853h px? 
?
Reading XDEF placement.
206*designutilsZ20-206h px? 
D
Reading placer database...
1602*designutilsZ20-1892h px? 
=
Reading XDEF routing.
207*designutilsZ20-207h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2$
Read XDEF File: 2default:default2
00:00:002default:default2 
00:00:00.5222default:default2
1243.7192default:default2
7.3552default:defaultZ17-268h px? 
?
7Restored from archive | CPU: %s secs | Memory: %s MB |
1612*designutils2
0.0000002default:default2
0.0000002default:defaultZ20-1924h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common20
Finished XDEF File Restore: 2default:default2
00:00:002default:default2 
00:00:00.5232default:default2
1243.7192default:default2
7.3552default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0022default:default2
1243.7192default:default2
0.0002default:defaultZ17-268h px? 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px? 
?
'Checkpoint was created with %s build %s378*project2+
Vivado v2020.1 (64-bit)2default:default2
29025402default:defaultZ1-604h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2%
open_checkpoint: 2default:default2
00:00:412default:default2
00:00:452default:default2
1243.7192default:default2
230.4302default:defaultZ17-268h px? 
p
Command: %s
53*	vivadotcl2?
+write_bitstream -force T03_M3_Top_Level.bit2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px? 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px? 
>
Refreshing IP repositories
234*coregenZ19-234h px? 
G
"No user IP repositories specified
1154*coregenZ19-1704h px? 
|
"Loaded Vivado IP repository '%s'.
1332*coregen23
C:/Xilinx/Vivado/2020.1/data/ip2default:defaultZ19-2313h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "z
1debounce_inst/r_data_debounced_reg[0]_LDC_i_1_n_01debounce_inst/r_data_debounced_reg[0]_LDC_i_1_n_02default:default2default:default2?
 "v
/debounce_inst/r_data_debounced_reg[0]_LDC_i_1/O/debounce_inst/r_data_debounced_reg[0]_LDC_i_1/O2default:default2default:default2?
 "r
-debounce_inst/r_data_debounced_reg[0]_LDC_i_1	-debounce_inst/r_data_debounced_reg[0]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "z
1debounce_inst/r_data_debounced_reg[1]_LDC_i_1_n_01debounce_inst/r_data_debounced_reg[1]_LDC_i_1_n_02default:default2default:default2?
 "v
/debounce_inst/r_data_debounced_reg[1]_LDC_i_1/O/debounce_inst/r_data_debounced_reg[1]_LDC_i_1/O2default:default2default:default2?
 "r
-debounce_inst/r_data_debounced_reg[1]_LDC_i_1	-debounce_inst/r_data_debounced_reg[1]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "z
1debounce_inst/r_data_debounced_reg[2]_LDC_i_1_n_01debounce_inst/r_data_debounced_reg[2]_LDC_i_1_n_02default:default2default:default2?
 "v
/debounce_inst/r_data_debounced_reg[2]_LDC_i_1/O/debounce_inst/r_data_debounced_reg[2]_LDC_i_1/O2default:default2default:default2?
 "r
-debounce_inst/r_data_debounced_reg[2]_LDC_i_1	-debounce_inst/r_data_debounced_reg[2]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "z
1debounce_inst/r_data_debounced_reg[3]_LDC_i_1_n_01debounce_inst/r_data_debounced_reg[3]_LDC_i_1_n_02default:default2default:default2?
 "v
/debounce_inst/r_data_debounced_reg[3]_LDC_i_1/O/debounce_inst/r_data_debounced_reg[3]_LDC_i_1/O2default:default2default:default2?
 "r
-debounce_inst/r_data_debounced_reg[3]_LDC_i_1	-debounce_inst/r_data_debounced_reg[3]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "j
)debounce_inst/r_debounced_reg_LDC_i_1_n_0)debounce_inst/r_debounced_reg_LDC_i_1_n_02default:default2default:default2|
 "f
'debounce_inst/r_debounced_reg_LDC_i_1/O'debounce_inst/r_debounced_reg_LDC_i_1/O2default:default2default:default2x
 "b
%debounce_inst/r_debounced_reg_LDC_i_1	%debounce_inst/r_debounced_reg_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "?
4debounce_inst/r_display_debounced_reg[0]_LDC_i_1_n_04debounce_inst/r_display_debounced_reg[0]_LDC_i_1_n_02default:default2default:default2?
 "|
2debounce_inst/r_display_debounced_reg[0]_LDC_i_1/O2debounce_inst/r_display_debounced_reg[0]_LDC_i_1/O2default:default2default:default2?
 "x
0debounce_inst/r_display_debounced_reg[0]_LDC_i_1	0debounce_inst/r_display_debounced_reg[0]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "?
4debounce_inst/r_display_debounced_reg[1]_LDC_i_1_n_04debounce_inst/r_display_debounced_reg[1]_LDC_i_1_n_02default:default2default:default2?
 "|
2debounce_inst/r_display_debounced_reg[1]_LDC_i_1/O2debounce_inst/r_display_debounced_reg[1]_LDC_i_1/O2default:default2default:default2?
 "x
0debounce_inst/r_display_debounced_reg[1]_LDC_i_1	0debounce_inst/r_display_debounced_reg[1]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "?
4debounce_inst/r_display_debounced_reg[2]_LDC_i_1_n_04debounce_inst/r_display_debounced_reg[2]_LDC_i_1_n_02default:default2default:default2?
 "|
2debounce_inst/r_display_debounced_reg[2]_LDC_i_1/O2debounce_inst/r_display_debounced_reg[2]_LDC_i_1/O2default:default2default:default2?
 "x
0debounce_inst/r_display_debounced_reg[2]_LDC_i_1	0debounce_inst/r_display_debounced_reg[2]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "|
2debounce_inst/r_error_debounced_reg[0]_LDC_i_1_n_02debounce_inst/r_error_debounced_reg[0]_LDC_i_1_n_02default:default2default:default2?
 "x
0debounce_inst/r_error_debounced_reg[0]_LDC_i_1/O0debounce_inst/r_error_debounced_reg[0]_LDC_i_1/O2default:default2default:default2?
 "t
.debounce_inst/r_error_debounced_reg[0]_LDC_i_1	.debounce_inst/r_error_debounced_reg[0]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2?
 "|
2debounce_inst/r_error_debounced_reg[1]_LDC_i_1_n_02debounce_inst/r_error_debounced_reg[1]_LDC_i_1_n_02default:default2default:default2?
 "x
0debounce_inst/r_error_debounced_reg[1]_LDC_i_1/O0debounce_inst/r_error_debounced_reg[1]_LDC_i_1/O2default:default2default:default2?
 "t
.debounce_inst/r_error_debounced_reg[1]_LDC_i_1	.debounce_inst/r_error_debounced_reg[1]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2p
 "Z
!mod_scheme_B/r_channel_I_reg[5]_2!mod_scheme_B/r_channel_I_reg[5]_22default:default2default:default2|
 "f
'mod_scheme_B/r_noise_I_reg[5]_LDC_i_1/O'mod_scheme_B/r_noise_I_reg[5]_LDC_i_1/O2default:default2default:default2x
 "b
%mod_scheme_B/r_noise_I_reg[5]_LDC_i_1	%mod_scheme_B/r_noise_I_reg[5]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2p
 "Z
!mod_scheme_B/r_channel_I_reg[6]_2!mod_scheme_B/r_channel_I_reg[6]_22default:default2default:default2|
 "f
'mod_scheme_B/r_noise_I_reg[6]_LDC_i_1/O'mod_scheme_B/r_noise_I_reg[6]_LDC_i_1/O2default:default2default:default2x
 "b
%mod_scheme_B/r_noise_I_reg[6]_LDC_i_1	%mod_scheme_B/r_noise_I_reg[6]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2p
 "Z
!mod_scheme_B/r_channel_I_reg[7]_2!mod_scheme_B/r_channel_I_reg[7]_22default:default2default:default2|
 "f
'mod_scheme_B/r_noise_I_reg[7]_LDC_i_1/O'mod_scheme_B/r_noise_I_reg[7]_LDC_i_1/O2default:default2default:default2x
 "b
%mod_scheme_B/r_noise_I_reg[7]_LDC_i_1	%mod_scheme_B/r_noise_I_reg[7]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2p
 "Z
!mod_scheme_B/r_channel_Q_reg[5]_1!mod_scheme_B/r_channel_Q_reg[5]_12default:default2default:default2|
 "f
'mod_scheme_B/r_noise_Q_reg[5]_LDC_i_1/O'mod_scheme_B/r_noise_Q_reg[5]_LDC_i_1/O2default:default2default:default2x
 "b
%mod_scheme_B/r_noise_Q_reg[5]_LDC_i_1	%mod_scheme_B/r_noise_Q_reg[5]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2p
 "Z
!mod_scheme_B/r_channel_Q_reg[6]_1!mod_scheme_B/r_channel_Q_reg[6]_12default:default2default:default2|
 "f
'mod_scheme_B/r_noise_Q_reg[6]_LDC_i_1/O'mod_scheme_B/r_noise_Q_reg[6]_LDC_i_1/O2default:default2default:default2x
 "b
%mod_scheme_B/r_noise_Q_reg[6]_LDC_i_1	%mod_scheme_B/r_noise_Q_reg[6]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
?
?Gated clock check: Net %s is a gated clock net sourced by a combinational pin %s, cell %s. This is not good design practice and will likely impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.%s*DRC2p
 "Z
!mod_scheme_B/r_channel_Q_reg[7]_1!mod_scheme_B/r_channel_Q_reg[7]_12default:default2default:default2|
 "f
'mod_scheme_B/r_noise_Q_reg[7]_LDC_i_1/O'mod_scheme_B/r_noise_Q_reg[7]_LDC_i_1/O2default:default2default:default2x
 "b
%mod_scheme_B/r_noise_Q_reg[7]_LDC_i_1	%mod_scheme_B/r_noise_Q_reg[7]_LDC_i_12default:default2default:default2=
 %DRC|Physical Configuration|Chip Level2default:default8ZPDRC-153h px? 
g
DRC finished with %s
1905*	planAhead2)
0 Errors, 16 Warnings2default:defaultZ12-3199h px? 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px? 
i
)Running write_bitstream with %s threads.
1750*designutils2
22default:defaultZ20-2272h px? 
?
Loading data files...
1271*designutilsZ12-1165h px? 
>
Loading site data...
1273*designutilsZ12-1167h px? 
?
Loading route data...
1272*designutilsZ12-1166h px? 
?
Processing options...
1362*designutilsZ12-1514h px? 
<
Creating bitmap...
1249*designutilsZ12-1141h px? 
7
Creating bitstream...
7*	bitstreamZ40-7h px? 
f
%Bitstream compression saved %s bits.
26*	bitstream2
132052482default:defaultZ40-26h px? 
g
Writing bitstream %s...
11*	bitstream2*
./T03_M3_Top_Level.bit2default:defaultZ40-11h px? 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px? 
?
?WebTalk data collection is mandatory when using a WebPACK part without a full Vivado license. To see the specific WebTalk data collected for your design, open the usage_statistics_webtalk.html or usage_statistics_webtalk.xml file in the implementation directory.
120*projectZ1-120h px? 
?
?'%s' has been successfully sent to Xilinx on %s. For additional details about this file, please refer to the Webtalk help file at %s.
186*common2
kC:/Users/Victorious/Desktop/m3/M21414_CW1_T03_M3/M21414_CW1_T03_M3.runs/impl_1/usage_statistics_webtalk.xml2default:default2,
Thu Jan 21 14:07:15 20212default:default2I
5C:/Xilinx/Vivado/2020.1/doc/webtalk_introduction.html2default:defaultZ17-186h px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
232default:default2
162default:default2
02default:default2
02default:defaultZ4-41h px? 
a
%s completed successfully
29*	vivadotcl2#
write_bitstream2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2%
write_bitstream: 2default:default2
00:00:302default:default2
00:00:332default:default2
1704.3482default:default2
460.6292default:defaultZ17-268h px? 


End Record