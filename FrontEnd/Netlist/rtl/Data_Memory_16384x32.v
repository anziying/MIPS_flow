module Data_Memory_16384x32 (
    addr, writeData, MemWrite, MemRead, clk, readData
);
    // Here we use 2^14 (16384) * 4byte as data memory
    input [31:0]addr;
    input [31:0]writeData;
    input MemWrite, MemRead, clk;
    output [31:0]readData;
    // reg [31:0] data [16383:0];
    wire [3:0]decoded_CEB;
    wire [31:0] data_out [3:0];
    reg [1:0] sel;
    Decoder_2to4 decoder(.I(addr[15:14]), .D(decoded_CEB));

    TS1N28HPCPL2LVTB4096X32M4MWBASO ram0 (
            .SLP({1'b0}), .SD({1'b0}),
            .CLK(clk), .CEB(~decoded_CEB[0]), .WEB(~MemWrite),
            .CEBM({1'b0}), .WEBM({1'b1}),
            .AWT({1'b0}),
            .A(addr[13:2]), .D(writeData),
            .BWEB({32'h00000000}),
            .AM({12'h000}), .DM(writeData), 
            .BWEBM({32'h00000000}),
            .BIST({1'b0}),
            .Q(data_out[0]));
    TS1N28HPCPL2LVTB4096X32M4MWBASO ram1 (
            .SLP({1'b0}), .SD({1'b0}),
            .CLK(clk), .CEB(~decoded_CEB[1]), .WEB(~MemWrite),
            .CEBM({1'b0}), .WEBM({1'b1}),
            .AWT({1'b0}),
            .A(addr[13:2]), .D(writeData),
            .BWEB({32'h00000000}),
            .AM({12'h000}), .DM(writeData), 
            .BWEBM({32'h00000000}),
            .BIST({1'b0}),
            .Q(data_out[1]));
    TS1N28HPCPL2LVTB4096X32M4MWBASO ram2 (
            .SLP({1'b0}), .SD({1'b0}),
            .CLK(clk), .CEB(~decoded_CEB[2]), .WEB(~MemWrite),
            .CEBM({1'b0}), .WEBM({1'b1}),
            .AWT({1'b0}),
            .A(addr[13:2]), .D(writeData),
            .BWEB({32'h00000000}),
            .AM({12'h000}), .DM(writeData), 
            .BWEBM({32'h00000000}),
            .BIST({1'b0}),
            .Q(data_out[2]));
    TS1N28HPCPL2LVTB4096X32M4MWBASO ram3 (
            .SLP({1'b0}), .SD({1'b0}),
            .CLK(clk), .CEB(~decoded_CEB[3]), .WEB(~MemWrite),
            .CEBM({1'b0}), .WEBM({1'b1}),
            .AWT({1'b0}),
            .A(addr[13:2]), .D(writeData),
            .BWEB({32'h00000000}),
            .AM({12'h000}), .DM(writeData), 
            .BWEBM({32'h00000000}),
            .BIST({1'b0}),
            .Q(data_out[3]));
    Mux_4x32 mux(.in3(data_out[3]),.in2(data_out[2]),.in1(data_out[1]),.in0(data_out[0]), .sel(sel), .out(readData));
    always @(posedge clk) begin
        sel = addr[15:14];
    end
endmodule

module Decoder_2to4(I, D);
    input [1:0] I;
    output reg [3:0] D;
    always @(*) begin
        D = 4'b0000;
        D[I] = 1'b1;
    end
endmodule

module Mux_4x32(in3,in2,in1,in0, sel, out);
    input [31:0] in3;
    input [31:0] in2;
    input [31:0] in1;
    input [31:0] in0;
    input [1:0] sel;
    output reg [31:0] out;
    always @(*) begin
        case(sel)
            2'b00:
            out = in0;
            2'b01:
            out = in1;
            2'b10:
            out = in2;
            2'b11:
            out = in3;
            default:begin
            end
        endcase
        
    end
endmodule