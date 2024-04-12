`timescale 1ps/1ps

module Testbench;
    reg clk;
    reg [31:0] PC_next_EX;
    output reg [31:0] PC_next_MEM;
    reg MemtoReg_EX;
    output reg MemtoReg_MEM;
    reg RegWrite_EX;
    output reg RegWrite_MEM;
    reg [4:0] writeAddr_EX;
    output reg [4:0] writeAddr_MEM;
    reg [31:0] ALU_result_EX;
    output reg [31:0] ALU_result_MEM;
    Reg_EX2MEM dut(
    clk,PC_next_EX,PC_next_MEM,MemtoReg_EX,
    MemtoReg_MEM,RegWrite_EX,RegWrite_MEM,
    writeAddr_EX,writeAddr_MEM,ALU_result_EX,
    ALU_result_MEM
);
    initial begin
        clk =  1'b0;
        
        forever #10 clk = ~clk; 
    end
    initial begin
        readAddr1 = 5'b00000;
        readAddr2 = 5'b00000;
        writeAddr = 5'b00000;
        writeData = 32'h00000000;
        RegWrite = 1'b0;
        #5;
        #20;
        // readData should be 00000000;
        writeAddr = 5'b00000;
        writeData = 32'habc12345;
        RegWrite = 1'b1;
        #20;
        writeAddr = 5'b00001;
        writeData = 32'habc12345;
        RegWrite = 1'b1;
        #20;
        writeAddr = 5'b00010;
        writeData = 32'h30663220;
        RegWrite = 1'b1;
        #20;
        writeAddr = 5'b00011;
        writeData = 32'h12345678;
        RegWrite = 1'b1;
        #20;
        readAddr1 = 5'b00001;
        readAddr2 = 5'b00010;
        RegWrite = 1'b0;
        #20;
        readAddr1 = 5'b00000;
        readAddr2 = 5'b00001;
        RegWrite = 1'b0;
        #20;
        $finish;
    end
endmodule