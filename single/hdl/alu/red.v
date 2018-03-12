module red
(
    input [15:0] psum,
    output [15:0] result
);

cla_4 cla0(.a(), .b(), .cin(), .sum(), .cout(), .gen(), .prop());
cla_4 cla1(.a(), .b(), .cin(), .sum(), .cout(), .gen(), .prop());
cla_4 cla2(.a(), .b(), .cin(), .sum(), .cout(), .gen(), .prop());

endmodule
