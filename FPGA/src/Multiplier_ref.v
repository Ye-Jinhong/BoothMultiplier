`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/14 22:18:20
// Design Name: 
// Module Name: Multiplier_ref
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module Multiplier_ref(
  input          clk_in1_p,
  input          clk_in1_n,
  input          reset,
  input          io_down_0,
  input          io_down_1,
  input  [52:0]  io_multiplicand,
  input  [52:0]  io_multiplier,
  input  [52:0]  io_addend,
  input          io_sub_vld,
  output [105:0] io_product
);
wire clock;
wire ce;
assign ce = 1'b1;
wire [47:0]pcout;
xbip_multadd_0 xbip_multadd (
  .CLK(clock),            // input wire CLK
  .CE(ce),              // input wire CE
  .SCLR(reset),          // input wire SCLR
  .A(io_multiplicand),                // input wire [52 : 0] A
  .B(io_multiplier),                // input wire [52 : 0] B
  .C(io_addend),                // input wire [52 : 0] C
  .SUBTRACT(io_sub_vld),  // input wire SUBTRACT
  .P(io_product),                // output wire [105 : 0] P
  .PCOUT(pcout)        // output wire [47 : 0] PCOUT
);

  clk_wiz_0 clk_wiz
   (
    // Clock out ports
    .clk_out1(clock),     		// output clk_out1
    // Clock in ports
    .clk_in1_p(clk_in1_p),    	// input clk_in1_p
    .clk_in1_n(clk_in1_n));    	// input clk_in1_n
endmodule
