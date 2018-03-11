module cla_4_test ();

reg [4:0] a, b;
reg cin;

wire [3:0] sum;
wire gen, prop, cout;

assign a[4] = 0;
assign b[4] = 0;

cla_4 idut(a[3:0], b[3:0], cin, sum, cout, gen, prop);

initial begin
forever begin
#1;
    a[3:0] = $random;
    b[3:0] = $random;
    cin = $random;
#1;
    $display("a %x, b %x, cin %b, sum %x, gen %b, prop %b", a[3:0], b[3:0], cin, {cout,sum}, gen, prop);
    if (a + b + cin != {cout,sum}) begin
        $display("a not equal b");
    end
end
end

initial begin

#300;
$stop;
end

endmodule
