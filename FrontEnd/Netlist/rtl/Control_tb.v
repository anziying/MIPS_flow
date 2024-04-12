`timescale 1ps/1ps

module Testbench;
    reg [5:0] opcode;
    wire RegDst;
    wire Jump;
    wire Branch, MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUSrc, RegWrite;
    Control dut(opcode, RegDst, Jump, Branch, MemRead, 
                MemtoReg, ALUOp, MemWrite,
                ALUSrc, RegWrite);
    initial begin
    opcode = 6'b000000;
    #10;
    // no change
    opcode = 6'b000001;
    #10;
    // jump
    opcode = 6'b000010;
    #10;
    // load word
    opcode = 6'b100011;
    #10;
    // store word
    opcode = 6'b101011;
    #10;
    $finish;
    end
endmodule