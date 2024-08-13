`timescale 1ns / 1ps
module tb_aes_main();
reg clk=0;
wire [127:0] data_in,key;
wire  [127:0] data_out;

always #10 clk = ~clk;
assign data_in = 128'h54776F204F6E65204E696E652054776F;
assign key = 128'h5468617473206D79204B756E67204675;

Aes_encryption Component1(.clk(clk),.data_in(data_in),.key(key),.data_out(data_out));

endmodule 