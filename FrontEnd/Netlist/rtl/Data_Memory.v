module Data_Memory_16384x32 (
    addr, writeData, MemWrite, MemRead, clk, readData
);
    // Here we use 2^14 (16384) * 4byte as data memory
    input [31:0]addr;
    input [31:0]writeData;
    input MemWrite, MemRead, clk;
    output reg [31:0]readData;
    integer i;
    reg [31:0] data [16383:0];
    initial begin
        for(i = 0; i < 16384; i = i+1)begin
            data[i] = 32'h00000000;
        end
    end

    always @(posedge clk) begin
        if(MemWrite == 1'b1)begin
            data[addr[15:2]] = writeData;
        end
        if(MemRead == 1'b1) begin
            readData = data[addr[15:2]];
        end
    end

endmodule