module Reg_EX2MEM (
    clk,
    PC_next_EX,
    PC_next_MEM,
    MemtoReg_EX,
    MemtoReg_MEM,
    RegWrite_EX,
    RegWrite_MEM,
    writeAddr_EX,
    writeAddr_MEM,
    ALU_result_EX,
    ALU_result_MEM
);
    input clk;
    input [31:0] PC_next_EX;
    output reg [31:0] PC_next_MEM;
    input MemtoReg_EX;
    output reg MemtoReg_MEM;
    input RegWrite_EX;
    output reg RegWrite_MEM;
    input [4:0] writeAddr_EX;
    output reg [4:0] writeAddr_MEM;
    input [31:0] ALU_result_EX;
    output reg [31:0] ALU_result_MEM;

    always @(posedge clk) begin
        PC_next_MEM <= PC_next_EX;
        MemtoReg_MEM <= MemtoReg_EX;
        RegWrite_MEM <= RegWrite_EX;
        writeAddr_MEM <= writeAddr_EX;
        ALU_result_MEM <= ALU_result_EX;
    end
endmodule