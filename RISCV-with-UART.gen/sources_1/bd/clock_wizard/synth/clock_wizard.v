//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Wed Jan 10 22:35:45 2024
//Host        : tuankiet running 64-bit major release  (build 9200)
//Command     : generate_target clock_wizard.bd
//Design      : clock_wizard
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "clock_wizard,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=clock_wizard,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=1,synth_mode=Global}" *) (* HW_HANDOFF = "clock_wizard.hwdef" *) 
module clock_wizard
   (clk_5mhz,
    clk_locked,
    sys_clock);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_5MHZ CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_5MHZ, CLK_DOMAIN /clk_wiz_0_clk_out1, FREQ_HZ 5000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) output clk_5mhz;
  output clk_locked;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYS_CLOCK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYS_CLOCK, CLK_DOMAIN clock_wizard_sys_clock, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input sys_clock;

  wire clk_wiz_0_clk_5mhz;
  wire clk_wiz_0_locked;
  wire sys_clock_1;

  assign clk_5mhz = clk_wiz_0_clk_5mhz;
  assign clk_locked = clk_wiz_0_locked;
  assign sys_clock_1 = sys_clock;
  clock_wizard_clk_wiz_0_0 clk_wiz_0
       (.clk_5mhz(clk_wiz_0_clk_5mhz),
        .clk_in1(sys_clock_1),
        .locked(clk_wiz_0_locked));
endmodule
