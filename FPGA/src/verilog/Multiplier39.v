// cTypes = List(4, 4, 3, 4, 4)
module BoothCodeUnit(
  input  [52:0] io_A,
  input  [2:0]  io_code,
  output [53:0] io_boothCodeOutput_product,
  output [1:0]  io_boothCodeOutput_h,
  output        io_boothCodeOutput_sn
);
  wire  A_sign = io_A[52]; // @[BoothCode.scala 23:17]
  wire [53:0] _io_boothCodeOutput_product_T = {A_sign,io_A}; // @[Cat.scala 31:58]
  wire  _io_boothCodeOutput_sn_T = ~A_sign; // @[BoothCode.scala 31:30]
  wire [53:0] _io_boothCodeOutput_product_T_2 = {io_A,1'h0}; // @[Cat.scala 31:58]
  wire [52:0] _io_boothCodeOutput_product_T_3 = ~io_A; // @[BoothCode.scala 42:39]
  wire [53:0] _io_boothCodeOutput_product_T_4 = {_io_boothCodeOutput_product_T_3,1'h1}; // @[Cat.scala 31:58]
  wire [53:0] _io_boothCodeOutput_product_T_7 = {_io_boothCodeOutput_sn_T,_io_boothCodeOutput_product_T_3}; // @[Cat.scala 31:58]
  wire  _T_6 = io_code == 3'h6; // @[BoothCode.scala 49:22]
  wire [53:0] _GEN_3 = io_code == 3'h6 ? _io_boothCodeOutput_product_T_7 : 54'h0; // @[BoothCode.scala 49:36 50:32]
  wire  _GEN_4 = io_code == 3'h6 ? A_sign : 1'h1; // @[BoothCode.scala 49:36 51:27]
  wire [53:0] _GEN_6 = io_code == 3'h5 ? _io_boothCodeOutput_product_T_7 : _GEN_3; // @[BoothCode.scala 45:36 46:32]
  wire  _GEN_7 = io_code == 3'h5 ? A_sign : _GEN_4; // @[BoothCode.scala 45:36 47:27]
  wire  _GEN_8 = io_code == 3'h5 | _T_6; // @[BoothCode.scala 45:36 48:26]
  wire [53:0] _GEN_9 = io_code == 3'h4 ? _io_boothCodeOutput_product_T_4 : _GEN_6; // @[BoothCode.scala 41:36 42:32]
  wire  _GEN_10 = io_code == 3'h4 ? A_sign : _GEN_7; // @[BoothCode.scala 41:36 43:27]
  wire  _GEN_11 = io_code == 3'h4 | _GEN_8; // @[BoothCode.scala 41:36 44:26]
  wire [53:0] _GEN_12 = io_code == 3'h3 ? _io_boothCodeOutput_product_T_2 : _GEN_9; // @[BoothCode.scala 37:36 38:32]
  wire  _GEN_13 = io_code == 3'h3 ? _io_boothCodeOutput_sn_T : _GEN_10; // @[BoothCode.scala 37:36 39:27]
  wire  _GEN_14 = io_code == 3'h3 ? 1'h0 : _GEN_11; // @[BoothCode.scala 37:36 40:26]
  wire [53:0] _GEN_15 = io_code == 3'h2 ? _io_boothCodeOutput_product_T : _GEN_12; // @[BoothCode.scala 33:36 34:32]
  wire  _GEN_16 = io_code == 3'h2 ? _io_boothCodeOutput_sn_T : _GEN_13; // @[BoothCode.scala 33:36 35:27]
  wire  _GEN_17 = io_code == 3'h2 ? 1'h0 : _GEN_14; // @[BoothCode.scala 33:36 36:26]
  wire [53:0] _GEN_18 = io_code == 3'h1 ? _io_boothCodeOutput_product_T : _GEN_15; // @[BoothCode.scala 29:36 30:32]
  wire  _GEN_19 = io_code == 3'h1 ? ~A_sign : _GEN_16; // @[BoothCode.scala 29:36 31:27]
  wire  _GEN_20 = io_code == 3'h1 ? 1'h0 : _GEN_17; // @[BoothCode.scala 29:36 32:26]
  wire  _GEN_23 = io_code == 3'h0 ? 1'h0 : _GEN_20; // @[BoothCode.scala 25:30 28:26]
  assign io_boothCodeOutput_product = io_code == 3'h0 ? 54'h0 : _GEN_18; // @[BoothCode.scala 25:30 26:32]
  assign io_boothCodeOutput_h = {{1'd0}, _GEN_23};
  assign io_boothCodeOutput_sn = io_code == 3'h0 | _GEN_19; // @[BoothCode.scala 25:30 27:27]
endmodule
module Compressor42(
  input  [61:0] io_p_0,
  input  [61:0] io_p_1,
  input  [61:0] io_p_2,
  input  [61:0] io_p_3,
  output [61:0] io_s,
  output [61:0] io_ca
);
  wire [61:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [61:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [61:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [61:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [61:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [61:0] cin = {cout[60:0],1'h0}; // @[Cat.scala 31:58]
  wire [61:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [61:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [61:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [61:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [61:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor42_1(
  input  [62:0] io_p_0,
  input  [62:0] io_p_1,
  input  [62:0] io_p_2,
  input  [62:0] io_p_3,
  output [62:0] io_s,
  output [62:0] io_ca
);
  wire [62:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [62:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [62:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [62:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [62:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [62:0] cin = {cout[61:0],1'h0}; // @[Cat.scala 31:58]
  wire [62:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [62:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [62:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [62:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [62:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor42_6(
  input  [58:0] io_p_0,
  input  [58:0] io_p_1,
  input  [58:0] io_p_2,
  input  [58:0] io_p_3,
  output [58:0] io_s,
  output [58:0] io_ca
);
  wire [58:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [58:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [58:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [58:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [58:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [58:0] cin = {cout[57:0],1'h0}; // @[Cat.scala 31:58]
  wire [58:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [58:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [58:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [58:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [58:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor42_7(
  input  [71:0] io_p_0,
  input  [71:0] io_p_1,
  input  [71:0] io_p_2,
  input  [71:0] io_p_3,
  output [71:0] io_s,
  output [71:0] io_ca
);
  wire [71:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [71:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [71:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [71:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [71:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [71:0] cin = {cout[70:0],1'h0}; // @[Cat.scala 31:58]
  wire [71:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [71:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [71:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [71:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [71:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor42_9(
  input  [67:0] io_p_0,
  input  [67:0] io_p_1,
  input  [67:0] io_p_2,
  input  [67:0] io_p_3,
  output [67:0] io_s,
  output [67:0] io_ca
);
  wire [67:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [67:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [67:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [67:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [67:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [67:0] cin = {cout[66:0],1'h0}; // @[Cat.scala 31:58]
  wire [67:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [67:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [67:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [67:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [67:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor32(
  input  [62:0] io_in_0,
  input  [62:0] io_in_1,
  input  [62:0] io_in_2,
  output [62:0] io_s,
  output [62:0] io_ca
);
  wire [62:0] _io_s_T = io_in_0 ^ io_in_1; // @[Compressor32.scala 21:13]
  wire [62:0] _io_ca_T = io_in_0 & io_in_1; // @[Compressor32.scala 22:15]
  wire [62:0] _io_ca_T_1 = io_in_0 & io_in_2; // @[Compressor32.scala 22:25]
  wire [62:0] _io_ca_T_2 = _io_ca_T | _io_ca_T_1; // @[Compressor32.scala 22:20]
  wire [62:0] _io_ca_T_3 = io_in_1 & io_in_2; // @[Compressor32.scala 22:37]
  assign io_s = _io_s_T ^ io_in_2; // @[Compressor32.scala 21:17]
  assign io_ca = _io_ca_T_2 | _io_ca_T_3; // @[Compressor32.scala 22:32]
endmodule
module Compressor32_1(
  input  [87:0] io_in_0,
  input  [87:0] io_in_1,
  input  [87:0] io_in_2,
  output [87:0] io_s,
  output [87:0] io_ca
);
  wire [87:0] _io_s_T = io_in_0 ^ io_in_1; // @[Compressor32.scala 21:13]
  wire [87:0] _io_ca_T = io_in_0 & io_in_1; // @[Compressor32.scala 22:15]
  wire [87:0] _io_ca_T_1 = io_in_0 & io_in_2; // @[Compressor32.scala 22:25]
  wire [87:0] _io_ca_T_2 = _io_ca_T | _io_ca_T_1; // @[Compressor32.scala 22:20]
  wire [87:0] _io_ca_T_3 = io_in_1 & io_in_2; // @[Compressor32.scala 22:37]
  assign io_s = _io_s_T ^ io_in_2; // @[Compressor32.scala 21:17]
  assign io_ca = _io_ca_T_2 | _io_ca_T_3; // @[Compressor32.scala 22:32]
endmodule
module Compressor32_2(
  input  [83:0] io_in_0,
  input  [83:0] io_in_1,
  input  [83:0] io_in_2,
  output [83:0] io_s,
  output [83:0] io_ca
);
  wire [83:0] _io_s_T = io_in_0 ^ io_in_1; // @[Compressor32.scala 21:13]
  wire [83:0] _io_ca_T = io_in_0 & io_in_1; // @[Compressor32.scala 22:15]
  wire [83:0] _io_ca_T_1 = io_in_0 & io_in_2; // @[Compressor32.scala 22:25]
  wire [83:0] _io_ca_T_2 = _io_ca_T | _io_ca_T_1; // @[Compressor32.scala 22:20]
  wire [83:0] _io_ca_T_3 = io_in_1 & io_in_2; // @[Compressor32.scala 22:37]
  assign io_s = _io_s_T ^ io_in_2; // @[Compressor32.scala 21:17]
  assign io_ca = _io_ca_T_2 | _io_ca_T_3; // @[Compressor32.scala 22:32]
endmodule
module Compressor42_10(
  input  [101:0] io_p_0,
  input  [101:0] io_p_1,
  input  [101:0] io_p_2,
  input  [101:0] io_p_3,
  output [101:0] io_s,
  output [101:0] io_ca
);
  wire [101:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [101:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [101:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [101:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [101:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [101:0] cin = {cout[100:0],1'h0}; // @[Cat.scala 31:58]
  wire [101:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [101:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [101:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [101:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [101:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor42_11(
  input  [107:0] io_p_0,
  input  [107:0] io_p_1,
  input  [107:0] io_p_2,
  input  [107:0] io_p_3,
  output [107:0] io_s,
  output [107:0] io_ca
);
  wire [107:0] xor0 = io_p_0 ^ io_p_1; // @[Compressor42.scala 19:19]
  wire [107:0] _cout_T = xor0 & io_p_2; // @[Compressor42.scala 23:16]
  wire [107:0] _cout_T_1 = ~xor0; // @[Compressor42.scala 23:30]
  wire [107:0] _cout_T_2 = _cout_T_1 & io_p_0; // @[Compressor42.scala 23:44]
  wire [107:0] cout = _cout_T | _cout_T_2; // @[Compressor42.scala 23:26]
  wire [107:0] cin = {cout[106:0],1'h0}; // @[Cat.scala 31:58]
  wire [107:0] xor1 = io_p_2 ^ io_p_3; // @[Compressor42.scala 20:19]
  wire [107:0] xor2 = xor1 ^ xor0; // @[Compressor42.scala 21:16]
  wire [107:0] _io_ca_T = xor2 & cin; // @[Compressor42.scala 25:17]
  wire [107:0] _io_ca_T_1 = ~xor2; // @[Compressor42.scala 25:27]
  wire [107:0] _io_ca_T_2 = _io_ca_T_1 & io_p_3; // @[Compressor42.scala 25:41]
  assign io_s = xor2 ^ cin; // @[Compressor42.scala 24:16]
  assign io_ca = _io_ca_T | _io_ca_T_2; // @[Compressor42.scala 25:23]
endmodule
module Compressor32_3(
  input  [52:0] io_in_0,
  input  [52:0] io_in_1,
  input  [52:0] io_in_2,
  output [52:0] io_s,
  output [52:0] io_ca
);
  wire [52:0] _io_s_T = io_in_0 ^ io_in_1; // @[Compressor32.scala 21:13]
  wire [52:0] _io_ca_T = io_in_0 & io_in_1; // @[Compressor32.scala 22:15]
  wire [52:0] _io_ca_T_1 = io_in_0 & io_in_2; // @[Compressor32.scala 22:25]
  wire [52:0] _io_ca_T_2 = _io_ca_T | _io_ca_T_1; // @[Compressor32.scala 22:20]
  wire [52:0] _io_ca_T_3 = io_in_1 & io_in_2; // @[Compressor32.scala 22:37]
  assign io_s = _io_s_T ^ io_in_2; // @[Compressor32.scala 21:17]
  assign io_ca = _io_ca_T_2 | _io_ca_T_3; // @[Compressor32.scala 22:32]
endmodule
(*use_dsp = "yes"*)
module Multiplier39(
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
  clk_wiz_0 clk_wiz
   (
    // Clock out ports
    .clk_out1(clock),     		// output clk_out1
    // Clock in ports
    .clk_in1_p(clk_in1_p),    	// input clk_in1_p
    .clk_in1_n(clk_in1_n));    	// input clk_in1_n

`ifdef RANDOMIZE_REG_INIT
  reg [95:0] _RAND_0;
  reg [95:0] _RAND_1;
  reg [95:0] _RAND_2;
  reg [95:0] _RAND_3;
  reg [95:0] _RAND_4;
  reg [95:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [127:0] _RAND_9;
  reg [127:0] _RAND_10;
  reg [63:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire [52:0] boothCodeOutput_boothCodeUnit_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_1_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_1_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_2_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_2_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_3_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_3_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_4_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_4_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_5_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_5_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_6_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_6_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_7_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_7_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_8_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_8_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_9_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_9_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_10_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_10_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_11_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_11_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_12_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_12_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_13_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_13_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_14_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_14_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_15_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_15_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_16_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_16_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_17_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_17_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_18_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_18_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_19_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_19_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_20_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_20_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_21_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_21_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_22_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_22_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_23_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_23_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_24_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_24_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_25_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_25_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [52:0] boothCodeOutput_boothCodeUnit_26_io_A; // @[BoothCode.scala 66:31]
  wire [2:0] boothCodeOutput_boothCodeUnit_26_io_code; // @[BoothCode.scala 66:31]
  wire [53:0] boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_product; // @[BoothCode.scala 66:31]
  wire [1:0] boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_h; // @[BoothCode.scala 66:31]
  wire  boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_sn; // @[BoothCode.scala 66:31]
  wire [61:0] compressorOutLast_outs_compressor42_io_p_0; // @[Compressor42.scala 50:44]
  wire [61:0] compressorOutLast_outs_compressor42_io_p_1; // @[Compressor42.scala 50:44]
  wire [61:0] compressorOutLast_outs_compressor42_io_p_2; // @[Compressor42.scala 50:44]
  wire [61:0] compressorOutLast_outs_compressor42_io_p_3; // @[Compressor42.scala 50:44]
  wire [61:0] compressorOutLast_outs_compressor42_io_s; // @[Compressor42.scala 50:44]
  wire [61:0] compressorOutLast_outs_compressor42_io_ca; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_1_io_p_0; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_1_io_p_1; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_1_io_p_2; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_1_io_p_3; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_1_io_s; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_1_io_ca; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_2_io_p_0; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_2_io_p_1; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_2_io_p_2; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_2_io_p_3; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_2_io_s; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_2_io_ca; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_3_io_p_0; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_3_io_p_1; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_3_io_p_2; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_3_io_p_3; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_3_io_s; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_3_io_ca; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_4_io_p_0; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_4_io_p_1; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_4_io_p_2; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_4_io_p_3; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_4_io_s; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_4_io_ca; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_5_io_p_0; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_5_io_p_1; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_5_io_p_2; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_5_io_p_3; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_5_io_s; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor42_5_io_ca; // @[Compressor42.scala 50:44]
  wire [58:0] compressorOutLast_outs_compressor42_6_io_p_0; // @[Compressor42.scala 50:44]
  wire [58:0] compressorOutLast_outs_compressor42_6_io_p_1; // @[Compressor42.scala 50:44]
  wire [58:0] compressorOutLast_outs_compressor42_6_io_p_2; // @[Compressor42.scala 50:44]
  wire [58:0] compressorOutLast_outs_compressor42_6_io_p_3; // @[Compressor42.scala 50:44]
  wire [58:0] compressorOutLast_outs_compressor42_6_io_s; // @[Compressor42.scala 50:44]
  wire [58:0] compressorOutLast_outs_compressor42_6_io_ca; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_7_io_p_0; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_7_io_p_1; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_7_io_p_2; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_7_io_p_3; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_7_io_s; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_7_io_ca; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_8_io_p_0; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_8_io_p_1; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_8_io_p_2; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_8_io_p_3; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_8_io_s; // @[Compressor42.scala 50:44]
  wire [71:0] compressorOutLast_outs_compressor42_8_io_ca; // @[Compressor42.scala 50:44]
  wire [67:0] compressorOutLast_outs_compressor42_9_io_p_0; // @[Compressor42.scala 50:44]
  wire [67:0] compressorOutLast_outs_compressor42_9_io_p_1; // @[Compressor42.scala 50:44]
  wire [67:0] compressorOutLast_outs_compressor42_9_io_p_2; // @[Compressor42.scala 50:44]
  wire [67:0] compressorOutLast_outs_compressor42_9_io_p_3; // @[Compressor42.scala 50:44]
  wire [67:0] compressorOutLast_outs_compressor42_9_io_s; // @[Compressor42.scala 50:44]
  wire [67:0] compressorOutLast_outs_compressor42_9_io_ca; // @[Compressor42.scala 50:44]
  wire [62:0] compressorOutLast_outs_compressor32_io_in_0; // @[Compressor32.scala 42:44]
  wire [62:0] compressorOutLast_outs_compressor32_io_in_1; // @[Compressor32.scala 42:44]
  wire [62:0] compressorOutLast_outs_compressor32_io_in_2; // @[Compressor32.scala 42:44]
  wire [62:0] compressorOutLast_outs_compressor32_io_s; // @[Compressor32.scala 42:44]
  wire [62:0] compressorOutLast_outs_compressor32_io_ca; // @[Compressor32.scala 42:44]
  wire [87:0] compressorOutLast_outs_compressor32_1_io_in_0; // @[Compressor32.scala 42:44]
  wire [87:0] compressorOutLast_outs_compressor32_1_io_in_1; // @[Compressor32.scala 42:44]
  wire [87:0] compressorOutLast_outs_compressor32_1_io_in_2; // @[Compressor32.scala 42:44]
  wire [87:0] compressorOutLast_outs_compressor32_1_io_s; // @[Compressor32.scala 42:44]
  wire [87:0] compressorOutLast_outs_compressor32_1_io_ca; // @[Compressor32.scala 42:44]
  wire [83:0] compressorOutLast_outs_compressor32_2_io_in_0; // @[Compressor32.scala 42:44]
  wire [83:0] compressorOutLast_outs_compressor32_2_io_in_1; // @[Compressor32.scala 42:44]
  wire [83:0] compressorOutLast_outs_compressor32_2_io_in_2; // @[Compressor32.scala 42:44]
  wire [83:0] compressorOutLast_outs_compressor32_2_io_s; // @[Compressor32.scala 42:44]
  wire [83:0] compressorOutLast_outs_compressor32_2_io_ca; // @[Compressor32.scala 42:44]
  wire [101:0] compressorOutLast_outs_compressor42_10_io_p_0; // @[Compressor42.scala 50:44]
  wire [101:0] compressorOutLast_outs_compressor42_10_io_p_1; // @[Compressor42.scala 50:44]
  wire [101:0] compressorOutLast_outs_compressor42_10_io_p_2; // @[Compressor42.scala 50:44]
  wire [101:0] compressorOutLast_outs_compressor42_10_io_p_3; // @[Compressor42.scala 50:44]
  wire [101:0] compressorOutLast_outs_compressor42_10_io_s; // @[Compressor42.scala 50:44]
  wire [101:0] compressorOutLast_outs_compressor42_10_io_ca; // @[Compressor42.scala 50:44]
  wire [107:0] compressorOutLast_outs_compressor42_11_io_p_0; // @[Compressor42.scala 50:44]
  wire [107:0] compressorOutLast_outs_compressor42_11_io_p_1; // @[Compressor42.scala 50:44]
  wire [107:0] compressorOutLast_outs_compressor42_11_io_p_2; // @[Compressor42.scala 50:44]
  wire [107:0] compressorOutLast_outs_compressor42_11_io_p_3; // @[Compressor42.scala 50:44]
  wire [107:0] compressorOutLast_outs_compressor42_11_io_s; // @[Compressor42.scala 50:44]
  wire [107:0] compressorOutLast_outs_compressor42_11_io_ca; // @[Compressor42.scala 50:44]
  wire [52:0] compressor32Out_compressor32_io_in_0; // @[Compressor32.scala 42:44]
  wire [52:0] compressor32Out_compressor32_io_in_1; // @[Compressor32.scala 42:44]
  wire [52:0] compressor32Out_compressor32_io_in_2; // @[Compressor32.scala 42:44]
  wire [52:0] compressor32Out_compressor32_io_s; // @[Compressor32.scala 42:44]
  wire [52:0] compressor32Out_compressor32_io_ca; // @[Compressor32.scala 42:44]
  wire [52:0] _multiplicand_not_T_2 = ~io_multiplicand; // @[Multiplier.scala 22:44]
  wire [52:0] _boothCodeOutput_T = io_multiplier; // @[Multiplier.scala 28:92]
  wire [52:0] partProductLast = io_sub_vld ? io_multiplier : 53'h0; // @[Multiplier.scala 33:20 34:21 36:21]
  wire  boothCodeOutput_0_sn = boothCodeOutput_boothCodeUnit_io_boothCodeOutput_sn; // @[BoothCode.scala 83:{14,14}]
  wire  _partProducts_pProduct_0_value_T = ~boothCodeOutput_0_sn; // @[BCOutput2PProduct.scala 14:58]
  wire [53:0] boothCodeOutput_0_product = boothCodeOutput_boothCodeUnit_io_boothCodeOutput_product; // @[BoothCode.scala 83:{14,14}]
  wire [56:0] partProducts_pProduct_0_value = {boothCodeOutput_0_sn,_partProducts_pProduct_0_value_T,
    _partProducts_pProduct_0_value_T,boothCodeOutput_0_product}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_1_sn = boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_1_product = boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_0_h = boothCodeOutput_boothCodeUnit_io_boothCodeOutput_h; // @[BoothCode.scala 83:{14,14}]
  wire [56:0] partProducts_pProduct_1_value = {boothCodeOutput_1_sn,boothCodeOutput_1_product,boothCodeOutput_0_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_2_sn = boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_2_product = boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_1_h = boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_2_value = {boothCodeOutput_2_sn,boothCodeOutput_2_product,boothCodeOutput_1_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_3_sn = boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_3_product = boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_2_h = boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_3_value = {boothCodeOutput_3_sn,boothCodeOutput_3_product,boothCodeOutput_2_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_4_sn = boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_4_product = boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_3_h = boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_5_sn = boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_5_product = boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_4_h = boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_6_sn = boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_6_product = boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_5_h = boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_6_value = {boothCodeOutput_6_sn,boothCodeOutput_6_product,boothCodeOutput_5_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_7_sn = boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_7_product = boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_6_h = boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_7_value = {boothCodeOutput_7_sn,boothCodeOutput_7_product,boothCodeOutput_6_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_8_sn = boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_8_product = boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_7_h = boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_9_sn = boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_9_product = boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_8_h = boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_10_sn = boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_10_product = boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_9_h = boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_10_value = {boothCodeOutput_10_sn,boothCodeOutput_10_product,boothCodeOutput_9_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_11_sn = boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_11_product = boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_10_h = boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_11_value = {boothCodeOutput_11_sn,boothCodeOutput_11_product,boothCodeOutput_10_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_12_sn = boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_12_product = boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_11_h = boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_13_sn = boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_13_product = boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_12_h = boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_14_sn = boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_14_product = boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_13_h = boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_14_value = {boothCodeOutput_14_sn,boothCodeOutput_14_product,boothCodeOutput_13_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_15_sn = boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_15_product = boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_14_h = boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_15_value = {boothCodeOutput_15_sn,boothCodeOutput_15_product,boothCodeOutput_14_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_16_sn = boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_16_product = boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_15_h = boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_17_sn = boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_17_product = boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_16_h = boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_18_sn = boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_18_product = boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_17_h = boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_18_value = {boothCodeOutput_18_sn,boothCodeOutput_18_product,boothCodeOutput_17_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_19_sn = boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_19_product = boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_18_h = boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_19_value = {boothCodeOutput_19_sn,boothCodeOutput_19_product,boothCodeOutput_18_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_20_sn = boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_20_product = boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_19_h = boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_21_sn = boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_21_product = boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_20_h = boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_22_sn = boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_22_product = boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_21_h = boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_22_value = {boothCodeOutput_22_sn,boothCodeOutput_22_product,boothCodeOutput_21_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_23_sn = boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_23_product = boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_22_h = boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] partProducts_pProduct_23_value = {boothCodeOutput_23_sn,boothCodeOutput_23_product,boothCodeOutput_22_h}; // @[Cat.scala 31:58]
  wire  boothCodeOutput_24_sn = boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_24_product = boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_23_h = boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_25_sn = boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_sn; // @[BoothCode.scala 87:{14,14}]
  wire [53:0] boothCodeOutput_25_product = boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_product; // @[BoothCode.scala 87:{14,14}]
  wire [1:0] boothCodeOutput_24_h = boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire  boothCodeOutput_26_sn = boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_sn; // @[BoothCode.scala 91:{14,14}]
  wire [53:0] boothCodeOutput_26_product = boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_product; // @[BoothCode.scala 91:{14,14}]
  wire [1:0] boothCodeOutput_25_h = boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_h; // @[BoothCode.scala 87:{14,14}]
  wire [56:0] _partProducts_valueLen_value_T = {boothCodeOutput_26_sn,boothCodeOutput_26_product,boothCodeOutput_25_h}; // @[Cat.scala 31:58]
  wire [1:0] boothCodeOutput_26_h = boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_h; // @[BoothCode.scala 91:{14,14}]
  wire [53:0] partProducts_27_value = {49'h1555555555554,3'h7,boothCodeOutput_26_h}; // @[Cat.scala 31:58]
  wire  _partProducts_valueLenPlus2_value_T_1 = ~partProductLast[52]; // @[BCOutput2PProduct.scala 35:81]
  wire [54:0] partProducts_28_value = {_partProducts_valueLenPlus2_value_T_1,partProductLast[52],partProductLast}; // @[Cat.scala 31:58]
  wire [58:0] _compressorOutLast_outs_compressor42_io_p_1_T_1 = {boothCodeOutput_24_sn,boothCodeOutput_24_product,
    boothCodeOutput_23_h,2'h0}; // @[Cat.scala 31:58]
  wire [60:0] _compressorOutLast_outs_compressor42_io_p_2_T_1 = {boothCodeOutput_25_sn,boothCodeOutput_25_product,
    boothCodeOutput_24_h,4'h0}; // @[Cat.scala 31:58]
  wire [55:0] partProducts_26_value = _partProducts_valueLen_value_T[55:0]; // @[BCOutput2PProduct.scala 25:24 26:20]
  wire [58:0] _compressorOutLast_outs_compressor42_io_p_1_T_3 = {boothCodeOutput_20_sn,boothCodeOutput_20_product,
    boothCodeOutput_19_h,2'h0}; // @[Cat.scala 31:58]
  wire [60:0] _compressorOutLast_outs_compressor42_io_p_2_T_3 = {boothCodeOutput_21_sn,boothCodeOutput_21_product,
    boothCodeOutput_20_h,4'h0}; // @[Cat.scala 31:58]
  wire [58:0] _compressorOutLast_outs_compressor42_io_p_1_T_5 = {boothCodeOutput_16_sn,boothCodeOutput_16_product,
    boothCodeOutput_15_h,2'h0}; // @[Cat.scala 31:58]
  wire [60:0] _compressorOutLast_outs_compressor42_io_p_2_T_5 = {boothCodeOutput_17_sn,boothCodeOutput_17_product,
    boothCodeOutput_16_h,4'h0}; // @[Cat.scala 31:58]
  wire [58:0] _compressorOutLast_outs_compressor42_io_p_1_T_7 = {boothCodeOutput_12_sn,boothCodeOutput_12_product,
    boothCodeOutput_11_h,2'h0}; // @[Cat.scala 31:58]
  wire [60:0] _compressorOutLast_outs_compressor42_io_p_2_T_7 = {boothCodeOutput_13_sn,boothCodeOutput_13_product,
    boothCodeOutput_12_h,4'h0}; // @[Cat.scala 31:58]
  wire [58:0] _compressorOutLast_outs_compressor42_io_p_1_T_9 = {boothCodeOutput_8_sn,boothCodeOutput_8_product,
    boothCodeOutput_7_h,2'h0}; // @[Cat.scala 31:58]
  wire [60:0] _compressorOutLast_outs_compressor42_io_p_2_T_9 = {boothCodeOutput_9_sn,boothCodeOutput_9_product,
    boothCodeOutput_8_h,4'h0}; // @[Cat.scala 31:58]
  wire [58:0] _compressorOutLast_outs_compressor42_io_p_1_T_11 = {boothCodeOutput_4_sn,boothCodeOutput_4_product,
    boothCodeOutput_3_h,2'h0}; // @[Cat.scala 31:58]
  wire [60:0] _compressorOutLast_outs_compressor42_io_p_2_T_11 = {boothCodeOutput_5_sn,boothCodeOutput_5_product,
    boothCodeOutput_4_h,4'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_2_ca_value = compressorOutLast_outs_compressor42_2_io_ca; // @[Compressor42.scala 57:50 59:31]
  wire [63:0] _compressorOutLast_outs_compressor42_io_p_1_T_12 = {compressorOutLast_outs_2_ca_value,1'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_1_s_value = compressorOutLast_outs_compressor42_1_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [70:0] _compressorOutLast_outs_compressor42_io_p_2_T_13 = {compressorOutLast_outs_1_s_value,8'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_1_ca_value = compressorOutLast_outs_compressor42_1_io_ca; // @[Compressor42.scala 57:50 59:31]
  wire [62:0] compressorOutLast_outs_4_ca_value = compressorOutLast_outs_compressor42_4_io_ca; // @[Compressor42.scala 57:50 59:31]
  wire [63:0] _compressorOutLast_outs_compressor42_io_p_1_T_13 = {compressorOutLast_outs_4_ca_value,1'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_3_s_value = compressorOutLast_outs_compressor42_3_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [70:0] _compressorOutLast_outs_compressor42_io_p_2_T_15 = {compressorOutLast_outs_3_s_value,8'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_3_ca_value = compressorOutLast_outs_compressor42_3_io_ca; // @[Compressor42.scala 57:50 59:31]
  wire [58:0] compressorOutLast_outs_6_ca_value = compressorOutLast_outs_compressor42_6_io_ca; // @[Compressor42.scala 57:50 59:31]
  wire [59:0] _compressorOutLast_outs_compressor42_io_p_1_T_14 = {compressorOutLast_outs_6_ca_value,1'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_5_s_value = compressorOutLast_outs_compressor42_5_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [66:0] _compressorOutLast_outs_compressor42_io_p_2_T_17 = {compressorOutLast_outs_5_s_value,4'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_5_ca_value = compressorOutLast_outs_compressor42_5_io_ca; // @[Compressor42.scala 57:50 59:31]
  reg [67:0] compressorOutLast_regC; // @[Compressor.scala 109:29]
  wire [67:0] compressorOutLast_outs_9_s_value = compressorOutLast_outs_compressor42_9_io_s; // @[Compressor42.scala 57:50 58:30]
  reg [67:0] compressorOutLast_regC_1; // @[Compressor.scala 109:29]
  wire [67:0] compressorOutLast_outs_9_ca_value = compressorOutLast_outs_compressor42_9_io_ca; // @[Compressor42.scala 57:50 59:31]
  reg [71:0] compressorOutLast_regC_2; // @[Compressor.scala 109:29]
  wire [71:0] compressorOutLast_outs_8_s_value = compressorOutLast_outs_compressor42_8_io_s; // @[Compressor42.scala 57:50 58:30]
  reg [71:0] compressorOutLast_regC_3; // @[Compressor.scala 109:29]
  wire [71:0] compressorOutLast_outs_8_ca_value = compressorOutLast_outs_compressor42_8_io_ca; // @[Compressor42.scala 57:50 59:31]
  reg [71:0] compressorOutLast_regC_4; // @[Compressor.scala 109:29]
  wire [71:0] compressorOutLast_outs_7_s_value = compressorOutLast_outs_compressor42_7_io_s; // @[Compressor42.scala 57:50 58:30]
  reg [71:0] compressorOutLast_regC_5; // @[Compressor.scala 109:29]
  wire [71:0] compressorOutLast_outs_7_ca_value = compressorOutLast_outs_compressor42_7_io_ca; // @[Compressor42.scala 57:50 59:31]
  reg [61:0] compressorOutLast_regC_6; // @[Compressor.scala 109:29]
  wire [61:0] compressorOutLast_outs_s_value = compressorOutLast_outs_compressor42_io_s; // @[Compressor42.scala 57:50 58:30]
  reg [61:0] compressorOutLast_regC_7; // @[Compressor.scala 109:29]
  wire [61:0] compressorOutLast_outs_ca_value = compressorOutLast_outs_compressor42_io_ca; // @[Compressor42.scala 57:50 59:31]
  reg [53:0] compressorOutLast_regC_8; // @[Compressor.scala 109:29]
  wire [61:0] _compressorOutLast_outs_compressor32_io_in_1_T_1 = {compressorOutLast_regC_8,8'h0}; // @[Cat.scala 31:58]
  wire [86:0] _compressorOutLast_outs_compressor32_io_in_1_T_3 = {compressorOutLast_regC_4,15'h0}; // @[Cat.scala 31:58]
  wire [68:0] _compressorOutLast_outs_compressor32_io_in_1_T_4 = {compressorOutLast_regC_1,1'h0}; // @[Cat.scala 31:58]
  wire [83:0] compressorOutLast_outs_12_ca_value = compressorOutLast_outs_compressor32_2_io_ca; // @[Compressor32.scala 49:50 51:31]
  wire [84:0] _compressorOutLast_outs_compressor42_io_p_1_T_15 = {compressorOutLast_outs_12_ca_value,1'h0}; // @[Cat.scala 31:58]
  wire [87:0] compressorOutLast_outs_11_s_value = compressorOutLast_outs_compressor32_1_io_s; // @[Compressor32.scala 49:50 50:30]
  wire [100:0] _compressorOutLast_outs_compressor42_io_p_2_T_19 = {compressorOutLast_outs_11_s_value,13'h0}; // @[Cat.scala 31:58]
  wire [87:0] compressorOutLast_outs_11_ca_value = compressorOutLast_outs_compressor32_1_io_ca; // @[Compressor32.scala 49:50 51:31]
  wire [101:0] compressorOutLast_outs_13_ca_value = compressorOutLast_outs_compressor42_10_io_ca; // @[Compressor42.scala 57:50 59:31]
  wire [102:0] _compressorOutLast_outs_compressor42_io_p_1_T_16 = {compressorOutLast_outs_13_ca_value,1'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_10_s_value = compressorOutLast_outs_compressor32_io_s; // @[Compressor32.scala 49:50 50:30]
  wire [106:0] _compressorOutLast_outs_compressor42_io_p_2_T_21 = {compressorOutLast_outs_10_s_value,44'h0}; // @[Cat.scala 31:58]
  wire [62:0] compressorOutLast_outs_10_ca_value = compressorOutLast_outs_compressor32_io_ca; // @[Compressor32.scala 49:50 51:31]
  reg [107:0] compressorOutLast_regC_9; // @[Compressor.scala 109:29]
  wire [107:0] compressorOutLast_outs_14_s_value = compressorOutLast_outs_compressor42_11_io_s; // @[Compressor42.scala 57:50 58:30]
  reg [107:0] compressorOutLast_regC_10; // @[Compressor.scala 109:29]
  wire [107:0] compressorOutLast_outs_14_ca_value = compressorOutLast_outs_compressor42_11_io_ca; // @[Compressor42.scala 57:50 59:31]
  reg [51:0] compressor32Out_addendReg; // @[AddAddend.scala 18:28]
  wire [51:0] _compressor32Out_addendReg_T = io_addend[51:0]; // @[AddAddend.scala 20:27]
  wire [105:0] carry = compressorOutLast_regC_10[105:0]; // @[Multiplier.scala 55:25 58:9]
  wire [51:0] compressor32Out_compressor32In_1_value = carry[51:0]; // @[AddAddend.scala 17:42 26:29]
  wire [106:0] _productMult_T = {carry, 1'h0}; // @[Multiplier.scala 70:25]
  wire [105:0] sum = compressorOutLast_regC_9[105:0]; // @[Multiplier.scala 54:23 57:7]
  wire [106:0] _GEN_15 = {{1'd0}, sum}; // @[Multiplier.scala 70:38]
  wire [106:0] _productMult_T_2 = _productMult_T + _GEN_15; // @[Multiplier.scala 70:38]
  wire [52:0] compressor32Out_ca_value = compressor32Out_compressor32_io_ca; // @[Compressor32.scala 49:50 51:31]
  wire [53:0] _productMultAdd_T = {compressor32Out_ca_value, 1'h0}; // @[Multiplier.scala 71:47]
  wire [52:0] compressor32Out_s_value = compressor32Out_compressor32_io_s; // @[Compressor32.scala 49:50 50:30]
  wire [53:0] _GEN_16 = {{1'd0}, compressor32Out_s_value}; // @[Multiplier.scala 71:60]
  wire [53:0] _productMultAdd_T_2 = _productMultAdd_T + _GEN_16; // @[Multiplier.scala 71:60]
  wire [105:0] productMult = _productMult_T_2[105:0]; // @[Multiplier.scala 68:31 70:15]
  wire [51:0] productMultAdd = _productMultAdd_T_2[51:0]; // @[Multiplier.scala 69:34 71:18]
  wire [62:0] compressorOutLast_outs_2_s_value = compressorOutLast_outs_compressor42_2_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [62:0] compressorOutLast_outs_4_s_value = compressorOutLast_outs_compressor42_4_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [58:0] compressorOutLast_outs_6_s_value = compressorOutLast_outs_compressor42_6_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [83:0] compressorOutLast_outs_12_s_value = compressorOutLast_outs_compressor32_2_io_s; // @[Compressor32.scala 49:50 50:30]
  wire [101:0] compressorOutLast_outs_13_s_value = compressorOutLast_outs_compressor42_10_io_s; // @[Compressor42.scala 57:50 58:30]
  wire [51:0] compressor32Out_compressor32In_0_value = sum[51:0]; // @[AddAddend.scala 17:42 24:29]
  BoothCodeUnit boothCodeOutput_boothCodeUnit ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_1 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_1_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_1_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_1_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_2 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_2_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_2_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_2_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_3 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_3_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_3_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_3_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_4 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_4_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_4_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_4_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_5 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_5_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_5_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_5_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_6 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_6_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_6_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_6_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_7 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_7_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_7_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_7_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_8 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_8_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_8_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_8_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_9 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_9_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_9_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_9_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_10 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_10_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_10_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_10_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_11 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_11_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_11_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_11_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_12 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_12_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_12_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_12_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_13 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_13_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_13_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_13_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_14 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_14_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_14_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_14_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_15 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_15_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_15_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_15_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_16 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_16_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_16_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_16_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_17 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_17_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_17_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_17_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_18 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_18_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_18_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_18_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_19 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_19_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_19_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_19_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_20 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_20_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_20_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_20_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_21 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_21_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_21_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_21_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_22 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_22_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_22_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_22_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_23 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_23_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_23_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_23_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_24 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_24_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_24_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_24_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_25 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_25_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_25_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_25_io_boothCodeOutput_sn)
  );
  BoothCodeUnit boothCodeOutput_boothCodeUnit_26 ( // @[BoothCode.scala 66:31]
    .io_A(boothCodeOutput_boothCodeUnit_26_io_A),
    .io_code(boothCodeOutput_boothCodeUnit_26_io_code),
    .io_boothCodeOutput_product(boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_product),
    .io_boothCodeOutput_h(boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_h),
    .io_boothCodeOutput_sn(boothCodeOutput_boothCodeUnit_26_io_boothCodeOutput_sn)
  );
  Compressor42 compressorOutLast_outs_compressor42 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_io_s),
    .io_ca(compressorOutLast_outs_compressor42_io_ca)
  );
  Compressor42_1 compressorOutLast_outs_compressor42_1 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_1_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_1_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_1_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_1_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_1_io_s),
    .io_ca(compressorOutLast_outs_compressor42_1_io_ca)
  );
  Compressor42_1 compressorOutLast_outs_compressor42_2 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_2_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_2_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_2_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_2_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_2_io_s),
    .io_ca(compressorOutLast_outs_compressor42_2_io_ca)
  );
  Compressor42_1 compressorOutLast_outs_compressor42_3 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_3_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_3_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_3_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_3_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_3_io_s),
    .io_ca(compressorOutLast_outs_compressor42_3_io_ca)
  );
  Compressor42_1 compressorOutLast_outs_compressor42_4 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_4_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_4_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_4_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_4_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_4_io_s),
    .io_ca(compressorOutLast_outs_compressor42_4_io_ca)
  );
  Compressor42_1 compressorOutLast_outs_compressor42_5 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_5_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_5_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_5_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_5_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_5_io_s),
    .io_ca(compressorOutLast_outs_compressor42_5_io_ca)
  );
  Compressor42_6 compressorOutLast_outs_compressor42_6 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_6_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_6_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_6_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_6_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_6_io_s),
    .io_ca(compressorOutLast_outs_compressor42_6_io_ca)
  );
  Compressor42_7 compressorOutLast_outs_compressor42_7 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_7_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_7_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_7_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_7_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_7_io_s),
    .io_ca(compressorOutLast_outs_compressor42_7_io_ca)
  );
  Compressor42_7 compressorOutLast_outs_compressor42_8 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_8_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_8_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_8_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_8_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_8_io_s),
    .io_ca(compressorOutLast_outs_compressor42_8_io_ca)
  );
  Compressor42_9 compressorOutLast_outs_compressor42_9 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_9_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_9_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_9_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_9_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_9_io_s),
    .io_ca(compressorOutLast_outs_compressor42_9_io_ca)
  );
  Compressor32 compressorOutLast_outs_compressor32 ( // @[Compressor32.scala 42:44]
    .io_in_0(compressorOutLast_outs_compressor32_io_in_0),
    .io_in_1(compressorOutLast_outs_compressor32_io_in_1),
    .io_in_2(compressorOutLast_outs_compressor32_io_in_2),
    .io_s(compressorOutLast_outs_compressor32_io_s),
    .io_ca(compressorOutLast_outs_compressor32_io_ca)
  );
  Compressor32_1 compressorOutLast_outs_compressor32_1 ( // @[Compressor32.scala 42:44]
    .io_in_0(compressorOutLast_outs_compressor32_1_io_in_0),
    .io_in_1(compressorOutLast_outs_compressor32_1_io_in_1),
    .io_in_2(compressorOutLast_outs_compressor32_1_io_in_2),
    .io_s(compressorOutLast_outs_compressor32_1_io_s),
    .io_ca(compressorOutLast_outs_compressor32_1_io_ca)
  );
  Compressor32_2 compressorOutLast_outs_compressor32_2 ( // @[Compressor32.scala 42:44]
    .io_in_0(compressorOutLast_outs_compressor32_2_io_in_0),
    .io_in_1(compressorOutLast_outs_compressor32_2_io_in_1),
    .io_in_2(compressorOutLast_outs_compressor32_2_io_in_2),
    .io_s(compressorOutLast_outs_compressor32_2_io_s),
    .io_ca(compressorOutLast_outs_compressor32_2_io_ca)
  );
  Compressor42_10 compressorOutLast_outs_compressor42_10 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_10_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_10_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_10_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_10_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_10_io_s),
    .io_ca(compressorOutLast_outs_compressor42_10_io_ca)
  );
  Compressor42_11 compressorOutLast_outs_compressor42_11 ( // @[Compressor42.scala 50:44]
    .io_p_0(compressorOutLast_outs_compressor42_11_io_p_0),
    .io_p_1(compressorOutLast_outs_compressor42_11_io_p_1),
    .io_p_2(compressorOutLast_outs_compressor42_11_io_p_2),
    .io_p_3(compressorOutLast_outs_compressor42_11_io_p_3),
    .io_s(compressorOutLast_outs_compressor42_11_io_s),
    .io_ca(compressorOutLast_outs_compressor42_11_io_ca)
  );
  Compressor32_3 compressor32Out_compressor32 ( // @[Compressor32.scala 42:44]
    .io_in_0(compressor32Out_compressor32_io_in_0),
    .io_in_1(compressor32Out_compressor32_io_in_1),
    .io_in_2(compressor32Out_compressor32_io_in_2),
    .io_s(compressor32Out_compressor32_io_s),
    .io_ca(compressor32Out_compressor32_io_ca)
  );
  assign io_product = {productMult[105:52],productMultAdd}; // @[Multiplier.scala 73:67]
  assign boothCodeOutput_boothCodeUnit_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_io_code = {_boothCodeOutput_T[1:0],1'h0}; // @[Cat.scala 31:58]
  assign boothCodeOutput_boothCodeUnit_1_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_1_io_code = _boothCodeOutput_T[3:1]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_2_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_2_io_code = _boothCodeOutput_T[5:3]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_3_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_3_io_code = _boothCodeOutput_T[7:5]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_4_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_4_io_code = _boothCodeOutput_T[9:7]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_5_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_5_io_code = _boothCodeOutput_T[11:9]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_6_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_6_io_code = _boothCodeOutput_T[13:11]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_7_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_7_io_code = _boothCodeOutput_T[15:13]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_8_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_8_io_code = _boothCodeOutput_T[17:15]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_9_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_9_io_code = _boothCodeOutput_T[19:17]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_10_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_10_io_code = _boothCodeOutput_T[21:19]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_11_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_11_io_code = _boothCodeOutput_T[23:21]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_12_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_12_io_code = _boothCodeOutput_T[25:23]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_13_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_13_io_code = _boothCodeOutput_T[27:25]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_14_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_14_io_code = _boothCodeOutput_T[29:27]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_15_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_15_io_code = _boothCodeOutput_T[31:29]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_16_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_16_io_code = _boothCodeOutput_T[33:31]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_17_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_17_io_code = _boothCodeOutput_T[35:33]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_18_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_18_io_code = _boothCodeOutput_T[37:35]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_19_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_19_io_code = _boothCodeOutput_T[39:37]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_20_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_20_io_code = _boothCodeOutput_T[41:39]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_21_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_21_io_code = _boothCodeOutput_T[43:41]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_22_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_22_io_code = _boothCodeOutput_T[45:43]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_23_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_23_io_code = _boothCodeOutput_T[47:45]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_24_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_24_io_code = _boothCodeOutput_T[49:47]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_25_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_25_io_code = _boothCodeOutput_T[51:49]; // @[BoothCode.scala 87:78]
  assign boothCodeOutput_boothCodeUnit_26_io_A = io_sub_vld ? _multiplicand_not_T_2 : io_multiplicand; // @[Multiplier.scala 21:20 22:22 24:22]
  assign boothCodeOutput_boothCodeUnit_26_io_code = {_boothCodeOutput_T[52],_boothCodeOutput_T[52:51]}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_io_p_0 = {{5'd0}, partProducts_pProduct_23_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_io_p_1 = {{3'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_1}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_io_p_2 = {{1'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_1}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_io_p_3 = {partProducts_26_value,6'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_1_io_p_0 = {{6'd0}, partProducts_pProduct_19_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_1_io_p_1 = {{4'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_3}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_1_io_p_2 = {{2'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_3}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_1_io_p_3 = {partProducts_pProduct_22_value,6'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_2_io_p_0 = {{6'd0}, partProducts_pProduct_15_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_2_io_p_1 = {{4'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_5}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_2_io_p_2 = {{2'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_5}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_2_io_p_3 = {partProducts_pProduct_18_value,6'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_3_io_p_0 = {{6'd0}, partProducts_pProduct_11_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_3_io_p_1 = {{4'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_7}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_3_io_p_2 = {{2'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_7}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_3_io_p_3 = {partProducts_pProduct_14_value,6'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_4_io_p_0 = {{6'd0}, partProducts_pProduct_7_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_4_io_p_1 = {{4'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_9}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_4_io_p_2 = {{2'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_9}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_4_io_p_3 = {partProducts_pProduct_10_value,6'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_5_io_p_0 = {{6'd0}, partProducts_pProduct_3_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_5_io_p_1 = {{4'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_11}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_5_io_p_2 = {{2'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_11}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_5_io_p_3 = {partProducts_pProduct_6_value,6'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_6_io_p_0 = {{4'd0}, partProducts_28_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_6_io_p_1 = {{2'd0}, partProducts_pProduct_0_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_6_io_p_2 = {{2'd0}, partProducts_pProduct_1_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_6_io_p_3 = {partProducts_pProduct_2_value,2'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_7_io_p_0 = {{9'd0}, compressorOutLast_outs_2_s_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_7_io_p_1 = {{8'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_12}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_7_io_p_2 = {{1'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_13}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_7_io_p_3 = {compressorOutLast_outs_1_ca_value,9'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_8_io_p_0 = {{9'd0}, compressorOutLast_outs_4_s_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_8_io_p_1 = {{8'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_13}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_8_io_p_2 = {{1'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_15}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_8_io_p_3 = {compressorOutLast_outs_3_ca_value,9'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_9_io_p_0 = {{9'd0}, compressorOutLast_outs_6_s_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_9_io_p_1 = {{8'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_14}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_9_io_p_2 = {{1'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_17}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_9_io_p_3 = {compressorOutLast_outs_5_ca_value,5'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor32_io_in_0 = {{1'd0}, compressorOutLast_regC_6}; // @[Compressor32.scala 45:51]
  assign compressorOutLast_outs_compressor32_io_in_1 = {{1'd0}, _compressorOutLast_outs_compressor32_io_in_1_T_1}; // @[Compressor32.scala 46:34]
  assign compressorOutLast_outs_compressor32_io_in_2 = {compressorOutLast_regC_7,1'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor32_1_io_in_0 = {{16'd0}, compressorOutLast_regC_3}; // @[Compressor32.scala 45:51]
  assign compressorOutLast_outs_compressor32_1_io_in_1 = {{1'd0}, _compressorOutLast_outs_compressor32_io_in_1_T_3}; // @[Compressor32.scala 46:34]
  assign compressorOutLast_outs_compressor32_1_io_in_2 = {compressorOutLast_regC_5,16'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor32_2_io_in_0 = {{16'd0}, compressorOutLast_regC}; // @[Compressor32.scala 45:51]
  assign compressorOutLast_outs_compressor32_2_io_in_1 = {{15'd0}, _compressorOutLast_outs_compressor32_io_in_1_T_4}; // @[Compressor32.scala 46:34]
  assign compressorOutLast_outs_compressor32_2_io_in_2 = {compressorOutLast_regC_2,12'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_10_io_p_0 = {{18'd0}, compressorOutLast_outs_12_s_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_10_io_p_1 = {{17'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_15}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_10_io_p_2 = {{1'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_19}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_10_io_p_3 = {compressorOutLast_outs_11_ca_value,14'h0}; // @[Cat.scala 31:58]
  assign compressorOutLast_outs_compressor42_11_io_p_0 = {{6'd0}, compressorOutLast_outs_13_s_value}; // @[Compressor42.scala 53:50]
  assign compressorOutLast_outs_compressor42_11_io_p_1 = {{5'd0}, _compressorOutLast_outs_compressor42_io_p_1_T_16}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_11_io_p_2 = {{1'd0}, _compressorOutLast_outs_compressor42_io_p_2_T_21}; // @[Compressor42.scala 54:33]
  assign compressorOutLast_outs_compressor42_11_io_p_3 = {compressorOutLast_outs_10_ca_value,45'h0}; // @[Cat.scala 31:58]
  assign compressor32Out_compressor32_io_in_0 = {{1'd0}, compressor32Out_compressor32In_0_value}; // @[Compressor32.scala 45:51]
  assign compressor32Out_compressor32_io_in_1 = {{1'd0}, compressor32Out_addendReg}; // @[Compressor32.scala 45:51]
  assign compressor32Out_compressor32_io_in_2 = {compressor32Out_compressor32In_1_value,1'h0}; // @[Cat.scala 31:58]
  always @(posedge clock) begin
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC <= 68'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC <= compressorOutLast_outs_9_s_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_1 <= 68'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_1 <= compressorOutLast_outs_9_ca_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_2 <= 72'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_2 <= compressorOutLast_outs_8_s_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_3 <= 72'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_3 <= compressorOutLast_outs_8_ca_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_4 <= 72'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_4 <= compressorOutLast_outs_7_s_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_5 <= 72'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_5 <= compressorOutLast_outs_7_ca_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_6 <= 62'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_6 <= compressorOutLast_outs_s_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_7 <= 62'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_7 <= compressorOutLast_outs_ca_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_8 <= 54'h0; // @[Compressor.scala 109:29]
    end else if (io_down_0) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_8 <= partProducts_27_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_9 <= 108'h0; // @[Compressor.scala 109:29]
    end else if (io_down_1) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_9 <= compressorOutLast_outs_14_s_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[Compressor.scala 109:29]
      compressorOutLast_regC_10 <= 108'h0; // @[Compressor.scala 109:29]
    end else if (io_down_1) begin // @[Compressor.scala 111:28]
      compressorOutLast_regC_10 <= compressorOutLast_outs_14_ca_value; // @[Compressor.scala 112:18]
    end
    if (reset) begin // @[AddAddend.scala 18:28]
      compressor32Out_addendReg <= 52'h0; // @[AddAddend.scala 18:28]
    end else if (io_down_1) begin // @[AddAddend.scala 19:16]
      compressor32Out_addendReg <= _compressor32Out_addendReg_T; // @[AddAddend.scala 20:17]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {3{`RANDOM}};
  compressorOutLast_regC = _RAND_0[67:0];
  _RAND_1 = {3{`RANDOM}};
  compressorOutLast_regC_1 = _RAND_1[67:0];
  _RAND_2 = {3{`RANDOM}};
  compressorOutLast_regC_2 = _RAND_2[71:0];
  _RAND_3 = {3{`RANDOM}};
  compressorOutLast_regC_3 = _RAND_3[71:0];
  _RAND_4 = {3{`RANDOM}};
  compressorOutLast_regC_4 = _RAND_4[71:0];
  _RAND_5 = {3{`RANDOM}};
  compressorOutLast_regC_5 = _RAND_5[71:0];
  _RAND_6 = {2{`RANDOM}};
  compressorOutLast_regC_6 = _RAND_6[61:0];
  _RAND_7 = {2{`RANDOM}};
  compressorOutLast_regC_7 = _RAND_7[61:0];
  _RAND_8 = {2{`RANDOM}};
  compressorOutLast_regC_8 = _RAND_8[53:0];
  _RAND_9 = {4{`RANDOM}};
  compressorOutLast_regC_9 = _RAND_9[107:0];
  _RAND_10 = {4{`RANDOM}};
  compressorOutLast_regC_10 = _RAND_10[107:0];
  _RAND_11 = {2{`RANDOM}};
  compressor32Out_addendReg = _RAND_11[51:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
