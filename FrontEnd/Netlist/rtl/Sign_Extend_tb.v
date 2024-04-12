`timescale 1ps/1ps

module Testbench;
    reg [15:0] in;
    reg Unsigned;
    wire [31:0] out;

    Sign_Extend dut(.in(in), .Unsigned(Unsigned), .out(out));

    initial begin
        Unsigned = 1'b0;
        in = 16'b1000000000000000;
        #10;
        in = 16'b1000000000000111;
        #10;
        in = 16'b1100000000010111;
        #10;
        in = 16'b0000000000010111;
        #10;
        in = 16'b0000000000000000;
        #10;
        in = 16'b0000000000001111;
        #10;
        in = 16'b0000000000001111;
        $finish;
    end
endmodule

