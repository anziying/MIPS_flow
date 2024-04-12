`timescale 1ps/1ps

module Testbench;
    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] S;
    wire overflow;

    Adder dut(.A(A), .B(B), .S(S), .overflow(overflow));

    initial begin
        A = 32'h80000000;
        B = 32'h80000000;
        #10;
        // overflow
        A = 32'h80000000;
        B = 32'h80000000;
        #10;
        // no overflow
        A = 32'h80000000;
        B = 32'h00000007;
        #10;
        // no overflow
        A = 32'h80000008;
        B = 32'h00000007;
        #10;
        // no overflow
        A = 32'h8000000a;
        B = 32'h00000007;
        #10;
        // overflow
        A = 32'h7f234123;
        B = 32'h0a000000;
        #10;
        $finish;
    end
endmodule