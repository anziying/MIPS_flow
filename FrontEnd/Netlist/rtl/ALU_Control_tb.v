`timescale 1ps/1ps

module Testbench;
    reg [5:0] funct;
    reg [1:0] ALUOp;
    wire [3:0] out;

    ALU_Control dut(.funct(funct),.ALUOp(ALUOp),.out(out));
    initial begin
        // out = 0000;
        ALUOp = 2'b11;
        funct = 6'b000000;
        #10;
        // out = 0010;
        ALUOp = 2'b00;
        funct = 6'b000000;
        #10;
        // out = 0010;
        ALUOp = 2'b10;
        funct = 6'b100000;
        #10;
        // out = 0000; AND
        ALUOp = 2'b10;
        funct = 6'b100100;
        #10;
        // out = 0110;
        ALUOp = 2'b10;
        funct = 6'b100010;
        #10;
        // out = 0111;
        ALUOp = 2'b10;
        funct = 6'b101010;
        #10;
        // out = 0111;
        ALUOp = 2'b10;
        funct = 6'b101010;
        $finish;
    end
endmodule

