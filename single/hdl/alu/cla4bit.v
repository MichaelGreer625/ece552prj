module cla_4
(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout,
    output gen,
    output prop
);

wire g0, g1, g2, g3;
wire p0, p1, p2, p3;
wire c1, c2, c3;

assign c1 = g0 | p0 & cin;
assign c2 = g1 | p1 & c1;
assign c3 = g2 | p2 & c2;
assign cout = g3 | p3 & c3;

assign gen = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0;
assign prop = p3 & p2 & p1 & p0;

cla_1 cla0(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .gen(g0), .prop(p0));
cla_1 cla1(.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]), .gen(g1), .prop(p1));
cla_1 cla2(.a(a[2]), .b(b[2]), .cin(c2), .sum(sum[2]), .gen(g2), .prop(p2));
cla_1 cla3(.a(a[3]), .b(b[3]), .cin(c3), .sum(sum[3]), .gen(g3), .prop(p3));

endmodule
