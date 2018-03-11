module cla_16_test ();

reg signed [15:0] a, b;
reg sub;

wire signed [15:0] addr, subr;

wire signed [15:0] sum;
wire gen, prop, cout;

assign addr = a + b;
assign subr = a - b;

cla_16 idut(a[15:0], b[15:0], sub, sum, cout);

initial begin
forever begin
#1;
    a[15:0] = $random;
    b[15:0] = $random;
    sub = 0;
#1;
    $display("a %d, b %d, cin %b, sum %d, cout %b", a[15:0], b[15:0], sub, sum, cout);
    if (sub == 0 && addr != sum || sub == 1 && subr != sum) begin
	    $display("ERROR: wrong calc for sat");
    end
end
end

initial begin

#300;
$stop;
end

endmodule
