module Instruction_Memory(writeAddr, PC, instructionInput, writeEnable, clk, instructionOutput);
    // writeEnable=1 is the enable mode
    input [10:0] writeAddr;
    input [31:0] PC;
    input [31:0] instructionInput;
    input clk;
    input writeEnable;
    output [31:0] instructionOutput;
    wire [31:0] PC_next;
    wire [10:0] addr_ram_in;
    wire WEB;
    parameter valid_addr_width = 11;
    // 2^11 = 2048
    

    assign addr_ram_in = (writeEnable == 1'b0) ? PC[12:2]:writeAddr;
    assign WEB = ~writeEnable;


    TS1N28HPCPL2LVTB2048X32M4MWBASO instruction_ram (
            .SLP({1'b0}), .SD({1'b0}),
            .CLK(clk), .CEB({1'b0}), .WEB(WEB),
            .CEBM({1'b0}), .WEBM({1'b1}),
            .AWT({1'b0}),
            .A(addr_ram_in), .D(instructionInput),
            .BWEB({32'h00000000}),
            .AM({11'b00000000000}), .DM(instructionInput), 
            .BWEBM({32'h00000000}),
            .BIST({1'b0}),
            .Q(instructionOutput));
endmodule

// module TS1N28HPCPL2LVTB2048X32M4MWBASO (SLP, SD,
//             CLK, CEB, WEB,
//             CEBM, WEBM,
//             AWT,
//             A, D, BWEB, AM, DM, 
//             BWEBM, BIST, Q);

//     // Mode Control
//     input BIST;
//     input AWT;
//     // Normal Mode Input
//     input SLP;
//     input SD;
//     input CLK;
//     input CEB;
//     input WEB;
//     input [10:0] A;
//     input [31:0] D;
//     input [31:0] BWEB;

// // BIST Mode Input
//     input CEBM;
//     input WEBM;
//     input [10:0] AM;
//     input [31:0] DM;
//     input [31:0] BWEBM;

// // Data Output
//     output [31:0] Q;

// endmodule