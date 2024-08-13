module encryption_last_round(clk,round_data_in,round_key_in,round_data_out);
input clk;
input [0:127]round_data_in;
input [0:127]round_key_in;
output [0:127]round_data_out;
wire [0:127] subbytes_out,shiftrows_out;

subbytes s1(clk,round_data_in,subbytes_out);
shiftrows s2(clk,subbytes_out,shiftrows_out);
assign round_data_out=shiftrows_out^round_key_in;
endmodule


