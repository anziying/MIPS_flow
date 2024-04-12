`timescale 1ps/1ps

module Testbench;
    reg [31:0]PC_incr4_ID;
    wire [31:0] PC_incr4_EX;
    reg [31:0] JumpAddr_ID;
    wire [31:0] JumpAddr_EX;
    reg clk;
    reg [1:0] ALUOp_ID;
    wire [1:0] ALUOp_EX;
    reg [15:0] immediate_ID;
    wire [15:0] immediate_EX;
    reg Jump_ID;
    wire Jump_EX;
    reg Branch_ID;
    wire Branch_EX;
    reg MemRead_ID;
    wire MemRead_EX;
    reg MemtoReg_ID;
    wire MemtoReg_EX;
    reg MemWrite_ID;
    wire MemWrite_EX;
    reg ALUSrc_ID;
    wire ALUSrc_EX;
    reg [4:0] writeAddr_ID;
    wire [4:0] writeAddr_EX;
    reg RegWrite_ID;
    wire RegWrite_EX;

    Reg_ID2EX dut(
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
    initial begin
        clk =  1'b0;
        
        forever #10 clk = ~clk; 
    end
    initial begin
        PC_incr4_ID <= 32'h12345678;
        JumpAddr_ID <= 32'h12345678;
        ALUOp_ID <= 2'b01;
        immediate_ID <= 16'h1000;
        Jump_ID <= 1'b1;
        Branch_ID <= 1'b0;
        MemRead_ID <= 1'b0;
    // wire MemRead_EX;
    // reg MemtoReg_ID;
    // wire MemtoReg_EX;
    // reg MemWrite_ID;
    // wire MemWrite_EX;
    // reg ALUSrc_ID;
    // wire ALUSrc_EX;
    // reg [4:0] writeAddr_ID;
    // wire [4:0] writeAddr_EX;
    // reg RegWrite_ID;
    // wire RegWrite_EX;
        #10;
        PC_incr4_ID <= 32'h12345679;
        JumpAddr_ID <= 32'h12345679;
        ALUOp_ID <= 2'b10;
        immediate_ID <= 16'h1001;
        Jump_ID <= 1'b0;
        Branch_ID <= 1'b1;
        MemRead_ID <= 1'b1;
        #20;
        PC_incr4_ID <= 32'h1234567a;
        JumpAddr_ID <= 32'h1234567a;
        ALUOp_ID <= 2'b11;
        immediate_ID <= 16'h1002;
        Jump_ID <= 1'b1;
        Branch_ID <= 1'b0;
        MemRead_ID <= 1'b0;
        #20;
        $finish;
    end
endmodule