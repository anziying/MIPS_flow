`timescale 1ns/1ps

module Testbench;
    reg [31:0]addr;
    reg [31:0]writeData;
    reg MemWrite, MemRead, clk;
    wire [31:0]readData;


    Data_Memory_16384x32 dut(
    addr, writeData, MemWrite, MemRead, clk, readData);

    initial begin
        clk =  1'b0;
        forever #20 clk = ~clk; 
    end
    // h00000000:00000001
    // h00000001:00000abc
    // h00000002:00000112
    // h00003002:00000cba

    initial begin
        addr = 32'h00000000;
        writeData = 32'h00000001;
        MemWrite = 1'b1;
        MemRead = 1'b0;
        #5;
        #40;
        addr = 32'h00000000;
        writeData = 32'h00000001;
        MemWrite = 1'b1;
        MemRead = 1'b0;
        #40;
        addr = 32'h00000004;
        writeData = 32'h00000abc;
        MemWrite = 1'b1;
        MemRead = 1'b0;
        #40;
        addr = 32'h00000008;
        writeData = 32'h00000112;
        MemWrite = 1'b1;
        MemRead = 1'b1;
        #40;
        addr = 32'h0000c008;
        writeData = 32'h00000cba;
        MemWrite = 1'b1;
        MemRead = 1'b1;
        #40;
        addr = 32'h00000000;
        MemWrite = 1'b0;
        MemRead = 1'b1;
        #40;
        addr = 32'h00000004;
        MemWrite = 1'b0;
        MemRead = 1'b1;
        #40;
        addr = 32'h00000008;
        MemWrite = 1'b0;
        MemRead = 1'b1;
        #40;
        addr = 32'h0000c008;
        MemWrite = 1'b0;
        MemRead = 1'b1;
        #40;
        $finish;
    end
endmodule

