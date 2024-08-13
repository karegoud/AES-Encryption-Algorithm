module encryption_round(clk,round_data_in,round_key_in,round_data_out);
input clk;
input [0:127]round_data_in,round_key_in;
output [0:127]round_data_out;
wire [0:127]subbytes_out,shiftrows_out,mixcolumn_out; 
subbytes p1(clk,round_data_in,subbytes_out);
shiftrows p2(clk,subbytes_out,shiftrows_out);
mixcolumn p3(clk,shiftrows_out,mixcolumn_out);
assign round_data_out=mixcolumn_out^round_key_in;
endmodule



