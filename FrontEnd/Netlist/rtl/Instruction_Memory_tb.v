`timescale 1ns/1ps

module Testbench;
    reg [10:0] writeAddr;
    reg [31:0] PC;
    reg [31:0] instructionInput;
    reg clk;
    reg writeEnable;
    wire [31:0] instructionOutput;


    Instruction_Memory dut(.writeAddr(writeAddr), .PC(PC), .instructionInput(instructionInput), 
    .writeEnable(writeEnable), .clk(clk), .instructionOutput(instructionOutput));

    initial begin
        clk =  1'b0;
        
        forever #20 clk = ~clk; 
    end

    initial begin
        writeAddr = 11'b00000000000;
        PC = 32'h00000000; //PC lowest 2 bits should keep 0!
        instructionInput = 32'habcd0000;
        writeEnable = 1'b0;
        #5;
        #40;
        writeAddr = 11'b00000000000;
        PC = 32'h00000000; //PC lowest 2 bits should keep 0!
        instructionInput = 32'habcd0000;
        writeEnable = 1'b1;
        #40;
        writeAddr = 11'b00000000001;
        PC = 32'h00000000; //PC lowest 2 bits should keep 0!
        instructionInput = 32'habcdef00;
        writeEnable = 1'b1;
        #40;
        writeAddr = 11'b00000000010;
        PC = 32'h00000000; //PC lowest 2 bits should keep 0!
        instructionInput = 32'h00000001;
        writeEnable = 1'b1;
        #40;
        writeAddr = 11'b00000000010;
        PC = 32'h00000000; //PC lowest 2 bits should keep 0!
        instructionInput = 32'h00000001;
        writeEnable = 1'b0;
        #40;
        writeAddr = 11'b00000000010;
        PC = 32'h00000004; //PC lowest 2 bits should keep 0!
        instructionInput = 32'h00000001;
        writeEnable = 1'b0;
        #40;
        writeAddr = 11'b00000000010;
        PC = 32'h00000008; //PC lowest 2 bits should keep 0!
        instructionInput = 32'h00000001;
        writeEnable = 1'b0;
        #40;
        writeAddr = 11'b00000000010;
        PC = 32'h00000008; //PC lowest 2 bits should keep 0!
        instructionInput = 32'h00000001;
        writeEnable = 1'b0;
        $finish;
    end
endmodule

