`timescale 1ns/1ps

module Testbench;
    // Mode Control
    reg BIST;
    reg AWT;
    // Normal Mode Input
    reg SLP;
    reg SD;
    reg CLK;
    reg CEB;
    reg WEB;
    reg [10:0] A;
    reg [31:0] D;
    reg [31:0] BWEB;

    // BIST Mode Input
    reg CEBM;
    reg WEBM;
    reg [10:0] AM;
    reg [31:0] DM;
    reg [31:0] BWEBM;

    // Data Output
    wire [31:0] Q;


    TS1N28HPCPL2LVTB2048X32M4MWBASO dur(.SLP(SLP), .SD(SD),
            .CLK(CLK), .CEB(CEB), .WEB(WEB),
            .CEBM(CEBM), .WEBM(WEBM),
            .AWT(AWT),
            .A(A), .D(D), .BWEB(BWEB), .AM(AM), .DM(DM), 
            .BWEBM(BWEBM), .BIST(BIST), .Q(Q));

    initial begin
        CLK =  1'b0;
        forever #20 CLK = ~CLK; // switch signal every half period
    end

    initial begin
        BIST = 1'b0;
        AWT = 1'b0;
    // Normal Mode Input
        SLP = 1'b0;
        SD = 1'b0;
        CEB = 1'b0;
        WEB = 1'b0;
        A = 11'b00000000000;
        D = 32'h12345678;
        BWEB = 32'h00000000;

    // BIST Mode Input
        CEBM = 1'b0;
        WEBM = 1'b1;
        AM = 11'b00000000000;
        DM = 32'h12345678;
        BWEBM = 32'h00000000;
        #45;
        #40;
        A = 11'b00000000001;
        D = 32'h12345678;
        #40;
        A = 11'b00000000010;
        D = 32'h87654321;
        #40;
        WEB = 1'b1;
        #40;
        A = 11'b00000000010;
        #40;
        A = 11'b00000000010;
        $finish;
    end
endmodule

