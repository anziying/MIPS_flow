module Reg_ID2EX (
    clk,
    PC_incr4_ID,
    PC_incr4_EX,
    JumpAddr_ID,
    JumpAddr_EX,
    ALUOp_ID,
    ALUOp_EX,
    immediate_ID, 
    immediate_EX,
    Jump_ID,
    Jump_EX,
    Branch_ID,
    Branch_EX,
    MemRead_ID,
    MemRead_EX,
    MemtoReg_ID,
    MemtoReg_EX,
    MemWrite_ID,
    MemWrite_EX,
    ALUSrc_ID,
    ALUSrc_EX,
    writeAddr_ID,
    writeAddr_EX,
    RegWrite_ID,
    RegWrite_EX
);
    input [31:0]PC_incr4_ID;
    output reg [31:0] PC_incr4_EX;
    input [31:0] JumpAddr_ID;
    output reg [31:0] JumpAddr_EX;
    input clk;
    input [1:0] ALUOp_ID;
    output reg [1:0] ALUOp_EX;
    input [15:0] immediate_ID;
    output reg [15:0] immediate_EX;
    input Jump_ID;
    output reg Jump_EX;
    input Branch_ID;
    output reg Branch_EX;
    input MemRead_ID;
    output reg MemRead_EX;
    input MemtoReg_ID;
    output reg MemtoReg_EX;
    input MemWrite_ID;
    output reg MemWrite_EX;
    input ALUSrc_ID;
    output reg ALUSrc_EX;
    input [4:0] writeAddr_ID;
    output reg [4:0] writeAddr_EX;
    input RegWrite_ID;
    output reg RegWrite_EX;

    always @(posedge clk) begin
        PC_incr4_EX <= PC_incr4_ID;
        ALUOp_EX <= ALUOp_ID;
        immediate_EX <= immediate_ID;
        JumpAddr_EX <= JumpAddr_ID;
        Jump_EX <= Jump_ID;
        Branch_EX <= Branch_ID;
        MemRead_EX <= MemRead_ID;
        MemtoReg_EX <= MemtoReg_ID;
        MemWrite_EX <= MemWrite_ID;
        ALUSrc_EX <= ALUSrc_ID;
        writeAddr_EX <= writeAddr_ID;
        RegWrite_EX <= RegWrite_ID;
    end
    
endmodule