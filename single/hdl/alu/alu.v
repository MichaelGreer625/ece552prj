/*
  control table
  2 1 0 | OP
  --------------
  0 0 0 | ADD
  0 0 1 | SUB
  0 1 0 | PADDSB
  0 1 1 | RED
  1 0 0 | SLL 
  1 0 1 | SRA
  1 1 0 | ROR
  1 1 1 | XOR
*/

module alu
(
    input [15:0] a,
    input [15:0] b,
    input [2:0] ctl,
    output [15:0] result,
    output [2:0] flags
);

wire [15:0] add_out, red_out, shift_out, xor_out;

// mux outputs based on ctl
assign result = ctl[2] ? ((ctl[1] & ctl[0]) ? xor_out : shift_out) :
                         ((ctl[1] & ctl[0]) ? red_out : add_out);

// XOR support
assign xor_out = a ^ b;

// shifter module
shifter shift_blk(.shift_in(a), .shift_val(), .mode(ctl[1:0]), .shift_out(shift_out));

// more adders to support RED
red red_blk(.psum(add_out), .result(red_out));

// 16bit CLA to support ADD/SUB/PADDSB/RED
adder16 adder(.a(a), .b(b), .mode(ctl[1:0]), .sum(add_out), .cout());

endmodule
