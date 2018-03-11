module cla_1
(
    input a,
    input b,
    input cin,
    output sum,
    output gen,
    output prop
);

assign gen = a & b;
assign prop = a | b;

assign sum = a ^ b ^ cin;

endmodule
