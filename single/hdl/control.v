module control
(
    input [3:0] opcode,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg Branch,
    output reg ALUSrc,
    output reg [2:0] ALUOp,
    output reg [1:0] SetFlags
);

always @* case (opcode)
4'b40000 : begin        // ADD 
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000 
                SetFlags = 3'b111; 
           end
4'b40001 : begin        // SUB
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b001; 
                SetFlags = 3'b111; 
           end
4'b40010 : begin        // RED
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b011; 
                SetFlags = 3'b000; 
           end
4'b40011 : begin        // XOR
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b111;
                SetFlags = 3'b000; 
           end
4'b40100 : begin        // SLL
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b100;
                SetFlags = 3'b000; 
           end
4'b40101 : begin        // SRA
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b101;
                SetFlags = 3'b000; 
           end
4'b40110 : begin        // ROR
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b40111 : begin        // PADDSB
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 

           end
4'b41000 : begin        // LW
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41001 : begin        // SW
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41010 : begin        // LHB
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41011 : begin        // LLB
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41100 : begin        // B
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41101 : begin        // BR
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41110 : begin        // PCS
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
4'b41111 : begin        // HALT
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch = 1'b0;
                ALUSrc = 1'b0;
                ALUOp = 3'b000;
                SetFlags = 3'b000; 
           end
endcase

endmodule
