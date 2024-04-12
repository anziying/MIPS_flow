module Reg_MEM(clk, ALU_result_in, ALU_result_out,
        RegWrite_in, RegWrite_out);
    input clk;
    input [31:0] ALU_result_in;
    output reg [31:0] ALU_result_out;
    input RegWrite_in;
    output reg RegWrite_out;
    always @(posedge clk) begin
        ALU_result_out = ALU_result_in;
        RegWrite_out = RegWrite_in;
    end


    
endmodule