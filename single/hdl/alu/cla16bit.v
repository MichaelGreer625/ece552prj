module cla_16 
(
    input [15:0] a,
    input [15:0] b,
    input sub,
    output [15:0] sum,
    output cout
);

wire ovfl_pos, ovfl_neg,test;
wire [15:0] bx, sumx;

//assign bx = b;
assign bx = b ^ {16{sub}};

assign ovfl_neg = ~sumx[15] & a[15] & bx[15];
assign ovfl_pos = sumx[15:0] & ~a[15] & ~bx[15];

assign test = (1'b0 | ovfl_pos) & ~ovfl_neg;
assign sum[14:0] = (sumx[14:0] | {15{ovfl_pos}}) & {15{~ovfl_neg}};
assign sum[15] = sumx[15] & ~ovfl_pos | ovfl_neg;

wire g0, g1, g2, g3;
wire p0, p1, p2, p3;
wire c1, c2, c3;

assign c1 = g0 | p0 & sub;
assign c2 = g1 | p1 & c1;
assign c3 = g2 | p2 & c2;
assign cout = g3 | p3 & c3;

cla_4 cla0(.a(a[3:0]), .b(bx[3:0]), .cin(sub), .sum(sumx[3:0]), .cout(), .gen(g0), .prop(p0));
cla_4 cla1(.a(a[7:4]), .b(bx[7:4]), .cin(c1), .sum(sumx[7:4]), .cout(), .gen(g1), .prop(p1));
cla_4 cla2(.a(a[11:8]), .b(bx[11:8]), .cin(c2), .sum(sumx[11:8]), .cout(), .gen(g2), .prop(p2));
cla_4 cla3(.a(a[15:12]), .b(bx[15:12]), .cin(c3), .sum(sumx[15:12]), .cout(), .gen(g3), .prop(p3));

endmodule
