// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Thu May  5 10:22:11 2022
// Host        : BlackTeaIrse running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/LABWORK/DSD/Lab/load_counter/load_counter.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_out_10M, reset, clk_in)
/* synthesis syn_black_box black_box_pad_pin="clk_out_10M,reset,clk_in" */;
  output clk_out_10M;
  input reset;
  input clk_in;
endmodule
