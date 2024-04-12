module Reg_EX (
    readData1_in, readData1_out,
    readData2_in, readData2_out,
    ALUSrc_in, ALUSrc_out,
    ALUOp_in, ALUOp_out,
    funct_in, funct_out, 
    clk
);
    input [31:0] readData1_in;
    output reg [31:0] readData1_out;
    input [31:0] readData2_in;
    output reg [31:0] readData2_out;
    input ALUSrc_in;
    output reg ALUSrc_out;
    input [1:0] ALUOp_in;
    output reg [1:0] ALUOp_out;
    input [5:0] funct_in;
    output reg [5:0] funct_out;
    input clk;
    always @(posedge clk) begin
        readData1_out = readData1_in;
        readData2_out = readData2_in;
        ALUSrc_out = ALUSrc_in;
        ALUOp_out = ALUOp_in;
        funct_out = funct_in;
    end


    
endmodule