module cla_16_test ();

reg signed [15:0] a, b;
reg padd, sub;

wire signed [15:0] addr, subr, paddr;

wire signed [15:0] sum;
wire gen, prop, cout;

assign addr = a + b;
assign subr = a - b;

assign paddr = {a[15:12] + b[15:12], a[11:8] + b[11:8], a[7:4] + b[7:4], a[3:0] + b[3:0]};

adder16 idut(a[15:0], b[15:0], padd, sub, sum, cout);

initial begin
forever begin
#1;
    a[15:0] = $random;
    b[15:0] = $random;
    sub = 0;
    padd = 1;
#1;
    $display("a %h, b %h, padd %b, sub %b, sum %h, cout %b", a[15:0], b[15:0], padd, sub, sum, cout);
    if (padd == 1) begin
        if (paddr != sum) 
            $display("paddr not equal to sum");
    end else if (sub == 0 && addr != sum) begin
        $display("addr not equal sum");
    end else if (sub == 1 && subr != sum) begin
        $display("subr not equal sum");
    end
end
end

initial begin

#300;
$stop;
end

endmodule
