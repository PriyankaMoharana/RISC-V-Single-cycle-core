module Data_Memory(clk,rst,WE,WD,A,RD);
  //Declaration of input output
    input clk,rst,WE;
    input [31:0]A,WD;
    output [31:0]RD;
//Memory
    reg [31:0] mem [1023:0];
//Write
    always @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end
//Read
    assign RD = (~rst) ? 32'd0 : mem[A];

    initial begin
        mem[28] = 32'h00000020;
        //mem[40] = 32'h00000002;
    end


endmodule