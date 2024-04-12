`timescale 1ns/1ps

module Testbench;
    reg [31:0]instructionInput;
    reg instructionWriteEnable;
    reg [10:0] writeAddr;
    reg [31:0] PC;
    reg PC_set;
    reg clk;
    
    wire [31:0] ALU_result;;
    wire [31:0] writeDataReg_WB;
    wire [31:0] instruction_ID;

    wire [31:0] readData1_EX;
    wire [31:0] readData2_EX;
    wire [31:0] PC_ID;
    wire [31:0] PC_incr4_ID;
    wire [31:0] PC_incr4_EX;
    wire MemtoReg_MEM;
    wire RegWrite_ID;
    wire RegWrite_MEM;
    wire [4:0] writeAddr_ID;
    wire [4:0] writeAddr_EX;
    wire [4:0] writeAddr_WB;



    MIPS_Core core(
    clk, instructionInput, instructionWriteEnable, writeAddr, PC, PC_set, ALU_result, writeDataReg_WB, instruction_ID,
    readData1_EX, readData2_EX, PC_ID, PC_incr4_ID, PC_incr4_EX, MemtoReg_MEM, RegWrite_MEM, RegWrite_ID, writeAddr_WB,
    writeAddr_EX, writeAddr_ID
);

    initial begin
        clk =  1'b0;
        
        forever #20 clk = ~clk; 
    end
    // 00000000:00000001
    // 00000001:00000abc
    // 00000002:00000112
    // 00003002:00000cba

    initial begin
        instructionInput = 32'h00000000;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b00000000000;
        PC = 32'h00000000;
        PC_set = 1'b1;
        #5;
        #40; // write instruction add $1 $0 $0
        instructionInput = 32'h00000820;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b00000000000;
        PC = 32'h00000000;
        PC_set = 1'b1;
        #40; // write instruction addi $29 $0 0x03fc
        instructionInput = 32'h201d03fc;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b00000000001;
        #40; // write instruction addi $16 $0 0x000f
        instructionInput = 32'h2010000f;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b00000000010;
        #40; // write instruction addi $17 $0 0x0009
        instructionInput = 32'h20110009;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b00000000011;
        #40; // write instruction stall
        instructionInput = 32'h00000000;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b00000000100;
        #40; // write instruction add $18 $17 $16
        instructionInput = 32'h02119020;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b0000000101;
        #40; // write instruction stall
        instructionInput = 32'h00000000;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b0000000110;
        #40; // write instruction sw $18 100($0)
        instructionInput = 32'hac120064;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b0000000111;
        #40; // write instruction stall
        instructionInput = 32'h00000000;
        instructionWriteEnable = 1'b1;
        writeAddr = 11'b0000001000;
        #40; // start, the ID stage is ready to be filled with add $1 $0 $0
        instructionInput = 32'h00000000;
        instructionWriteEnable = 1'b0;
        writeAddr = 11'b0000000110;
        PC = 32'h00000000;
        PC_set = 1'b0;
        #40; // ID: addi $29 $0 0x03fc / EX: add $1 $0 $0
        #40; // ID: addi $16 $0 0x000f / EX: addi $29 $0 0x03fc / MEM: add $1 $0 $0
        #40; // ID: addi $17 $0 0x0009 / EX: addi $16 $0 0x000f / MEM: addi $29 $0 0x03fc
        #40; // ID: stall              / EX: addi $17 $0 0x0009 / MEM: addi $16 $0 0x000f
        #40; // ID: add $18 $17 $16    / EX: stall              / MEM: addi $17 $0 0x0009
        #40; // ID: stall              / EX: add $18 $17 $16    / MEM: stall              
        #40; // ID: sw $18 100($0)     / EX: stall              / MEM: add $18 $17 $16
        #40; // ID: stall              / EX: sw $18 100($0)     / MEM: stall              / WB: add $18 $17 $16
        $finish;
    end
endmodule

