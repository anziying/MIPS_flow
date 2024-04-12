`timescale 1ps/1ps

module Testbench;
    reg [31:0]A; 
    reg [31:0]B;
    reg [3:0] control;
    wire [31:0] S;
    wire carryout;
    wire zero;
    wire overflow;
    ALU dut (.A(A) , .B (B), .control (control), .S(S), .carryout (carryout), .zero(zero), .overflow(overflow));
    initial begin
    A = 32'h00000000;
    B = 32'h00000000;
    control = 4'b0000;
    #10;
    // and
    control = 4'b0000;
    A = 32'h00000001;
    B = 32'h00000003;
    #10;
    // and
    control = 4'b0000;
    A = 32'hf0000001;
    B = 32'hf0000003;
    #10;
    // subtract
    control = 4'b0110;
    A = 32'h00000001;
    B = 32'h00000003;
    #10;
    // subtract to overflow
    control = 4'b0110;
    A = 32'h80000000;
    B = 32'h00111111;
    #10;
    // add to overflow
    control = 4'b0010;
    A = 32'h7fffffff;
    B = 32'h00111111;
    #10;
    // SLT
    control = 4'b0111;
    A = 32'hf0000001;
    B = 32'hf0000003;
    #10;
    // SLT
    control = 4'b0111;
    A = 32'hf0000001;
    B = 32'hf0000003;
    $finish;
    end
endmodule


    