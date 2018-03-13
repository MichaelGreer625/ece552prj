/*
  ADD,SUB :            Modify ZVN
  XOR, SLL, SRA, ROR : Modify Z
  wen[2] enables Z write
  wen[1] enables V write
  wen[0] enables N write
*/

module flag_reg
(
    input clk,
    input rst,
    input [2;0] wen,
    input [2:0] flags_in,
    output [2:0] flags_out
);

dff Z(.d(flags_in[2]), .q(flags_out[2]), .wen(wen[2]), .clk(clk), .rst(rst));
dff V(.d(flags_in[1]), .q(flags_out[1]), .wen(wen[1]), .clk(clk), .rst(rst));
dff N(.d(flags_in[0]), .q(flags_out[0]), .wen(wen[0]), .clk(clk), .rst(rst));

endmodule
