module RegFile32x32(readAddr1, readAddr2, writeAddr, writeData, RegWrite, 
        clk, readData1, readData2);
    input [4:0] readAddr1;
    input [4:0] readAddr2;
    input [4:0] writeAddr;
    input [31:0] writeData;
    input RegWrite;
    input clk;
    output reg [31:0] readData1;
    output reg [31:0] readData2;
    parameter numWord = 32;
    reg [31:0] data [0:numWord-1];
    // assign data[0] = 32'h00000000;
    initial begin
        data[0] = 32'h00000000;
    end

    always @(posedge clk) begin
        if(RegWrite == 1'b1 && writeAddr != 5'b00000) begin
            data[writeAddr] = writeData;
        end
        readData1 = data[readAddr1];
        readData2 = data[readAddr2];
    end
endmodule