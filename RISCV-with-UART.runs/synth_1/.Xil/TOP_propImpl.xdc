set_property SRC_FILE_INFO {cfile:c:/Users/tuankiet/Desktop/RISCV-with-UART/RISCV-with-UART.gen/sources_1/bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0.xdc rfile:../../../RISCV-with-UART.gen/sources_1/bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0.xdc id:1 order:EARLY scoped_inst:clock_generator/clock_wizard_i/clk_wiz_0/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/tuankiet/Desktop/RISCV-with-UART/RISCV-with-UART.srcs/constrs_1/imports/DATKLL/constraint.xdc rfile:../../../RISCV-with-UART.srcs/constrs_1/imports/DATKLL/constraint.xdc id:2} [current_design]
current_instance clock_generator/clock_wizard_i/clk_wiz_0/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.080
current_instance
set_property src_info {type:XDC file:2 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { SYS_clk }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
set_property src_info {type:XDC file:2 line:30 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { clk_locked }]; #IO_L6N_T0_VREF_34 Sch=LED0
set_property src_info {type:XDC file:2 line:31 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { CPU_execution }]; #IO_L6P_T0_34 Sch=LED1
set_property src_info {type:XDC file:2 line:32 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports { CPU_finish_execution }]; #IO_L21N_T3_DQS_AD14N_35 Sch=LED2
set_property src_info {type:XDC file:2 line:36 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D19    IOSTANDARD LVCMOS33 } [get_ports { SYS_reset }]; #IO_L4P_T0_35 Sch=BTN0
set_property src_info {type:XDC file:2 line:37 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN D20    IOSTANDARD LVCMOS33 } [get_ports { SYS_start_button }]; #IO_L4N_T0_35 Sch=BTN1
set_property src_info {type:XDC file:2 line:97 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { tx  }]; #IO_L5P_T0_34            Sch=CK_IO0
set_property src_info {type:XDC file:2 line:98 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { rx  }]; #IO_L2N_T0_34            Sch=CK_IO1
