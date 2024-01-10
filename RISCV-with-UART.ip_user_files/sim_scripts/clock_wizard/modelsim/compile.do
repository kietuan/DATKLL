vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../RISCV-with-UART.gen/sources_1/bd/clock_wizard/ipshared/30ef" \
"../../../bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0.v" \
"../../../bd/clock_wizard/sim/clock_wizard.v" \


vlog -work xil_defaultlib \
"glbl.v"

