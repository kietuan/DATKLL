//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Wed Jan 10 22:35:46 2024
//Host        : tuankiet running 64-bit major release  (build 9200)
//Command     : generate_target clock_wizard_wrapper.bd
//Design      : clock_wizard_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module clock_wizard_wrapper
   (clk_5mhz,
    clk_locked,
    sys_clock);
  output clk_5mhz;
  output clk_locked;
  input sys_clock;

  wire clk_5mhz;
  wire clk_locked;
  wire sys_clock;

  clock_wizard clock_wizard_i
       (.clk_5mhz(clk_5mhz),
        .clk_locked(clk_locked),
        .sys_clock(sys_clock));
endmodule
