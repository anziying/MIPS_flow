`timescale 1ps/1ps

module Testbench;
    reg [4:0] readAddr1;
    reg [4:0] readAddr2;
    reg [4:0] writeAddr;
    reg [31:0] writeData;
    reg RegWrite;
    reg clk;
    wire [31:0] readData1;
    wire [31:0] readData2;
    RegFile32x32 dut(readAddr1, readAddr2, writeAddr, writeData, RegWrite, 
        clk, readData1, readData2);
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