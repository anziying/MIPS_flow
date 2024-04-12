module TS1N28HPCPL2LVTB2048X32M4MWBASO (SLP, SD,
            CLK, CEB, WEB,
            CEBM, WEBM,
            AWT,
            A, D, BWEB, AM, DM, 
            BWEBM, BIST, Q);

    // Mode Control
    input BIST;
    input AWT;
    // Normal Mode Input
    input SLP;
    input SD;
    input CLK;
    input CEB;
    input WEB;
    input [10:0] A;
    input [31:0] D;
    input [31:0] BWEB;

// BIST Mode Input
    input CEBM;
    input WEBM;
    input [10:0] AM;
    input [31:0] DM;
    input [31:0] BWEBM;

// Data Output
    output [31:0] Q;

endmodule