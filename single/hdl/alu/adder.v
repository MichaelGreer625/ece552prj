module adder16
(
    input [15:0] a,
    input [15:0] b,
    input padd,
    input sub,
    output [15:0] sum, 
    output cout
);

wire [15:0] bx, sumx;
wire [3:0] ovfl_pos, ovfl_neg;
wire cin;
wire c1, c2, c3;
wire g0, g1, g2, g3;
wire p0, p1, p2, p3;

assign bx = b ^ {16{cin}};

// overflow detection
assign ovfl_pos[0] = padd ? sumx[3] & ~a[3] & ~bx[3] : ovfl_pos[3];
assign ovfl_pos[1] = padd ? sumx[7] & ~a[7] & ~bx[7] : ovfl_pos[3];
assign ovfl_pos[2] = padd ? sumx[11] & ~a[11] & ~bx[11] : ovfl_pos[3];
assign ovfl_pos[3] = sumx[15] & ~a[15] & ~bx[15];

assign ovfl_neg[0] = padd ? ~sumx[3] & a[3] & bx[3] : ovfl_neg[3];
assign ovfl_neg[1] = padd ? ~sumx[7] & a[7] & bx[7] : ovfl_neg[3];
assign ovfl_neg[2] = padd ? ~sumx[11] & a[11] & bx[11] : ovfl_neg[3];
assign ovfl_neg[3] = ~sumx[15] & a[15] & bx[15];

// saturation logic
assign sum[2:0] = (sumx[2:0] | {3{ovfl_pos[0]}}) & {3{~ovfl_neg[0]}};
assign sum[3] = padd ? (sumx[3] & ~ovfl_pos[0]) | ovfl_neg[0] :
                       (sumx[3] | ovfl_pos[0]) & ~ovfl_neg[0];

assign sum[6:4] = (sumx[6:4] | {3{ovfl_pos[1]}}) & {3{~ovfl_neg[1]}};
assign sum[7] = padd ? (sumx[7] & ~ovfl_pos[1]) | ovfl_neg[1] :
                       (sumx[7] | ovfl_pos[1]) & ~ovfl_neg[1];

assign sum[10:8] = (sumx[10:8] | {3{ovfl_pos[2]}}) & {3{~ovfl_neg[2]}};
assign sum[11] = padd ? (sumx[11] & ~ovfl_pos[2]) | ovfl_neg[2] :
                        (sumx[11] | ovfl_pos[2]) & ~ovfl_neg[2];

assign sum[14:12] = (sumx[14:12] | {3{ovfl_pos[3]}}) & {3{~ovfl_neg[3]}};
assign sum[15] = (sumx[15] & ~ovfl_pos[3]) | ovfl_neg[3]; 


// carry gen
assign cin = ~padd & sub;
assign c1 = ~padd & (g0 | p0 & cin);
assign c2 = ~padd & (g1 | p1 & c1);
assign c3 = ~padd & (g2 | p2 & c2);
assign cout = ~padd & (g3 | p3 & c3);

cla_4 cla0(.a(a[3:0]), .b(bx[3:0]), .cin(cin), .sum(sumx[3:0]), .cout(), .gen(g0), .prop(p0));
cla_4 cla1(.a(a[7:4]), .b(bx[7:4]), .cin(c1), .sum(sumx[7:4]), .cout(), .gen(g1), .prop(p1));
cla_4 cla2(.a(a[11:8]), .b(bx[11:8]), .cin(c2), .sum(sumx[11:8]), .cout(), .gen(g2), .prop(p2));
cla_4 cla3(.a(a[15:12]), .b(bx[15:12]), .cin(c3), .sum(sumx[15:12]), .cout(), .gen(g3), .prop(p3));

endmodule
