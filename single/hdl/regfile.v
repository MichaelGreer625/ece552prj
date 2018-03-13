//Used a decoder module for both read and write
//Read always enabled, write depends on WriteReg
module ReadDecoder_4_16(
input [3:0] RegId, 
output [15:0] Wordline);

dc4to16 dcR(.RegId(RegId), .en(1), .Wordline(Wordline));
endmodule


module WriteDecoder_4_16(
input [3:0] RegId, 
input WriteReg, 
output [15:0] Wordline);

dc4to16 dcW(.RegId(RegId), .en(WriteReg), .Wordline(Wordline));
endmodule

//each BitCell instantiates 1 D flip-flop
module BitCell( 
input clk,  
input rst, 
input D, 
input WriteEnable, 
input ReadEnable1, 
input ReadEnable2, 
inout Bitline1, 
inout Bitline2);
wire dout;

dff d(.q(dout), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));
tristate t1(.a(dout), .en(ReadEnable1), .b(Bitline1));
tristate t2(.a(dout), .en(ReadEnable2), .b(Bitline2));
endmodule

//each Register instanstiates 16 BitCells
module Register( 
input clk,  
input rst, 
input [15:0] D, 
input WriteReg, 
input ReadEnable1, 
input ReadEnable2, 
inout [15:0] Bitline1, 
inout [15:0] Bitline2);

BitCell B15(.clk(clk), .rst(rst), .D(D[15]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[15]), .Bitline2(Bitline2[15]));
BitCell B14(.clk(clk), .rst(rst), .D(D[14]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[14]), .Bitline2(Bitline2[14]));
BitCell B13(.clk(clk), .rst(rst), .D(D[13]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[13]), .Bitline2(Bitline2[13]));
BitCell B12(.clk(clk), .rst(rst), .D(D[12]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[12]), .Bitline2(Bitline2[12]));
BitCell B11(.clk(clk), .rst(rst), .D(D[11]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[11]), .Bitline2(Bitline2[11]));
BitCell B10(.clk(clk), .rst(rst), .D(D[10]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[10]), .Bitline2(Bitline2[10]));
BitCell B9(.clk(clk), .rst(rst), .D(D[9]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[9]), .Bitline2(Bitline2[9]));
BitCell B8(.clk(clk), .rst(rst), .D(D[8]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[8]), .Bitline2(Bitline2[8]));
BitCell B7(.clk(clk), .rst(rst), .D(D[7]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[7]), .Bitline2(Bitline2[7]));
BitCell B6(.clk(clk), .rst(rst), .D(D[6]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[6]), .Bitline2(Bitline2[6]));
BitCell B5(.clk(clk), .rst(rst), .D(D[5]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[5]), .Bitline2(Bitline2[5]));
BitCell B4(.clk(clk), .rst(rst), .D(D[4]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[4]), .Bitline2(Bitline2[4]));
BitCell B3(.clk(clk), .rst(rst), .D(D[3]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[3]), .Bitline2(Bitline2[3]));
BitCell B2(.clk(clk), .rst(rst), .D(D[2]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[2]), .Bitline2(Bitline2[2]));
BitCell B1(.clk(clk), .rst(rst), .D(D[1]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[1]), .Bitline2(Bitline2[1]));
BitCell B0(.clk(clk), .rst(rst), .D(D[0]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[0]), .Bitline2(Bitline2[0]));
endmodule

//RegisterFile instantiates 16 Registers
module RegisterFile(
input clk, 
input rst, 
input [3:0] SrcReg1, 
input [3:0] SrcReg2, 
input [3:0] DstReg, 
input WriteReg, 
input [15:0] DstData, 
inout [15:0] SrcData1, 
inout [15:0] SrcData2);

wire [15:0] SrcReg1RD1, SrcReg2RD2, DstRegWD1, bitline1, bitline2;

assign SrcData1 = ((DstReg == SrcReg1) & WriteReg) ? DstData : bitline1;
assign SrcData2 = ((DstReg == SrcReg2) & WriteReg) ? DstData : bitline2;

ReadDecoder_4_16 RD1(.RegId(SrcReg1), .Wordline(SrcReg1RD1));
ReadDecoder_4_16 RD2(.RegId(SrcReg2), .Wordline(SrcReg2RD2));
WriteDecoder_4_16 WD1(.RegId(DstReg), .WriteReg(WriteReg), .Wordline(DstRegWD1));

Register R15(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[15]), .ReadEnable1(SrcReg1RD1[15]), .ReadEnable2(SrcReg2RD2[15]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R14(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[14]), .ReadEnable1(SrcReg1RD1[14]), .ReadEnable2(SrcReg2RD2[14]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R13(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[13]), .ReadEnable1(SrcReg1RD1[13]), .ReadEnable2(SrcReg2RD2[13]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R12(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[12]), .ReadEnable1(SrcReg1RD1[12]), .ReadEnable2(SrcReg2RD2[12]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R11(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[11]), .ReadEnable1(SrcReg1RD1[11]), .ReadEnable2(SrcReg2RD2[11]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R10(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[10]), .ReadEnable1(SrcReg1RD1[10]), .ReadEnable2(SrcReg2RD2[10]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R9(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[9]), .ReadEnable1(SrcReg1RD1[9]), .ReadEnable2(SrcReg2RD2[9]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R8(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[8]), .ReadEnable1(SrcReg1RD1[8]), .ReadEnable2(SrcReg2RD2[8]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R7(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[7]), .ReadEnable1(SrcReg1RD1[7]), .ReadEnable2(SrcReg2RD2[7]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R6(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[6]), .ReadEnable1(SrcReg1RD1[6]), .ReadEnable2(SrcReg2RD2[6]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R5(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[5]), .ReadEnable1(SrcReg1RD1[5]), .ReadEnable2(SrcReg2RD2[5]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R4(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[4]), .ReadEnable1(SrcReg1RD1[4]), .ReadEnable2(SrcReg2RD2[4]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R3(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[3]), .ReadEnable1(SrcReg1RD1[3]), .ReadEnable2(SrcReg2RD2[3]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R2(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[2]), .ReadEnable1(SrcReg1RD1[2]), .ReadEnable2(SrcReg2RD2[2]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R1(.clk(clk), .rst(rst), .D(DstData), .WriteReg(DstRegWD1[1]), .ReadEnable1(SrcReg1RD1[1]), .ReadEnable2(SrcReg2RD2[1]), .Bitline1(bitline1), .Bitline2(bitline2));
Register R0(.clk(clk), .rst(rst), .D(0), .WriteReg(DstRegWD1[0]), .ReadEnable1(SrcReg1RD1[0]), .ReadEnable2(SrcReg2RD2[0]), .Bitline1(0), .Bitline2(0));
endmodule


//decoder module, works for both read and write
module dc4to16(
input [3:0] RegId,
input en, 
output [15:0] Wordline);

assign Wordline[15] = RegId[3] & RegId[2] & RegId[1] & RegId[0]; 
assign Wordline[14] = RegId[3] & RegId[2] & RegId[1] & ~RegId[0]; 
assign Wordline[13] = RegId[3] & RegId[2] & ~RegId[1] & RegId[0]; 
assign Wordline[12] = RegId[3] & RegId[2] & ~RegId[1] & ~RegId[0]; 
assign Wordline[11] = RegId[3] & ~RegId[2] & RegId[1] & RegId[0]; 
assign Wordline[10] = RegId[3] & ~RegId[2] & RegId[1] & ~RegId[0]; 
assign Wordline[9] = RegId[3] & ~RegId[2] & ~RegId[1] & RegId[0];
assign Wordline[8] = RegId[3] & ~RegId[2] & ~RegId[1] & ~RegId[0];
assign Wordline[7] = ~RegId[3] & RegId[2] & RegId[1] & RegId[0];
assign Wordline[6] = ~RegId[3] & RegId[2] & RegId[1] & ~RegId[0];
assign Wordline[5] = ~RegId[3] & RegId[2] & ~RegId[1] & RegId[0];
assign Wordline[4] = ~RegId[3] & RegId[2] & ~RegId[1] & ~RegId[0];
assign Wordline[3] = ~RegId[3] & ~RegId[2] & RegId[1] & RegId[0];
assign Wordline[2] = ~RegId[3] & ~RegId[2] & RegId[1] & ~RegId[0];
assign Wordline[1] = ~RegId[3] & ~RegId[2] & ~RegId[1] & RegId[0];
assign Wordline[0] = ~RegId[3] & ~RegId[2] & ~RegId[1] & ~RegId[0];

assign Wordline[15:0] = (en)? Wordline[15:0] : 16'b0;
endmodule

//tristate buffer, active-low
module tristate(
input a,
input en,
output b);

assign b = (en)? 1'bz : a;
endmodule
