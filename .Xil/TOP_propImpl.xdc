set_property SRC_FILE_INFO {cfile:c:/Users/tuankiet/Desktop/RISCV-with-UART/RISCV-with-UART.gen/sources_1/bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0.xdc rfile:../RISCV-with-UART.gen/sources_1/bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0.xdc id:1 order:EARLY scoped_inst:clock_generator/clock_wizard_i/clk_wiz_0/inst} [current_design]
current_instance clock_generator/clock_wizard_i/clk_wiz_0/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.080
