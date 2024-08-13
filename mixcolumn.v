module mixcolumn(clk,mixcolumn_in,mixcolumn_out);
input clk;
input [0:127]mixcolumn_in;
output  [0:127]mixcolumn_out;
mix_cul c1 (clk,mixcolumn_in[0:31],mixcolumn_out[0:31]);
mix_cul c2 (clk,mixcolumn_in[32:63],mixcolumn_out[32:63]);
mix_cul c3 (clk,mixcolumn_in[64:95],mixcolumn_out[64:95]);
mix_cul c4 (clk,mixcolumn_in[96:127],mixcolumn_out[96:127]);
endmodule

module GF28_times2(clk,data_in,data_out);
input[0:7] data_in;
input clk;
output reg [0:7]data_out; 
always@(posedge clk)
data_out<={data_in[1:7],1'b0} ^ (8'h1b & {8{data_in[0]}});
endmodule

module GF28_times3(clk,data_in,data_out);
input clk;
input [0:7]data_in;
output  [0:7] data_out;
wire [0:7]t1;
GF28_times2  g1(clk,data_in,t1);
assign  data_out=t1^data_in;
endmodule

module mix_cul(clk,data_in,data_out);
input clk;
input [0:31]data_in;
output [0:31]data_out;
wire [0:7] t1,t2,t3,t4;
wire [0:7] c0,c1,c2,c3;
wire [0:7] m2_t1,m2_t2,m2_t3,m2_t4;
wire [0:7] m3_t1,m3_t2,m3_t3,m3_t4;

assign t1=data_in[0:7];
assign t2=data_in[8:15];
assign t3=data_in[16:23];
assign t4=data_in[24:31];

GF28_times2 m1 (clk,t1,m2_t1);
GF28_times2 m2 (clk,t2,m2_t2);
GF28_times2 m3 (clk,t3,m2_t3);
GF28_times2 m4 (clk,t4,m2_t4);

GF28_times3 m5( clk,t1,m3_t1);
GF28_times3 m6( clk,t2,m3_t2);
GF28_times3 m7( clk,t3,m3_t3);
GF28_times3 m8( clk,t4,m3_t4);

assign c0 = m2_t1 ^m3_t2^t3^t4;
assign c1 = t1 ^m2_t2 ^m3_t3 ^ t4;
assign c2 = t1^t2 ^ m2_t3 ^m3_t4;
assign c3 = m3_t1 ^t2^t3^m2_t4;
assign data_out = {c0,c1,c2,c3};
endmodule





