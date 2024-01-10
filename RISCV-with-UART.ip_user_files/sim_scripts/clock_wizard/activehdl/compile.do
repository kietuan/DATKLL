transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {C:/Users/tuankiet/Desktop/RISCV-with-UART/RISCV-with-UART.cache/compile_simlib/activehdl}
vlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../RISCV-with-UART.gen/sources_1/bd/clock_wizard/ipshared/30ef" -l xil_defaultlib \
"../../../bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/clock_wizard/ip/clock_wizard_clk_wiz_0_0/clock_wizard_clk_wiz_0_0.v" \
"../../../bd/clock_wizard/sim/clock_wizard.v" \


vlog -work xil_defaultlib \
"glbl.v"

