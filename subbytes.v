module subbytes(clk,subbytes_in,subbytes_out);
input clk;
input [0:127]subbytes_in;
output  reg [0:127]subbytes_out;
wire [0:127] wire_out;		

sbox s1(subbytes_in[120:127], wire_out[120:127]);
sbox s2(subbytes_in[112:119], wire_out[112:119]);
sbox s3(subbytes_in[104:111], wire_out[104:111]);
sbox s4(subbytes_in[96:103], wire_out[96:103]);
sbox s5(subbytes_in[88:95], wire_out[88:95]);
sbox s6(subbytes_in[80:87], wire_out[80:87]);
sbox s7(subbytes_in[72:79], wire_out[72:79]);
sbox s8(subbytes_in[64:71], wire_out[64:71]);
sbox s9(subbytes_in[56:63], wire_out[56:63]);
sbox s10(subbytes_in[48:55], wire_out[48:55]);
sbox s11(subbytes_in[40:47], wire_out[40:47]);
sbox s12(subbytes_in[32:39], wire_out[32:39]);
sbox s13(subbytes_in[24:31], wire_out[24:31]);
sbox s14(subbytes_in[16:23], wire_out[16:23]);
sbox s15(subbytes_in[8:15], wire_out[8:15]);
sbox s16(subbytes_in[0:7], wire_out[0:7]);
  
always@(posedge clk)
begin
subbytes_out<=wire_out;
end
endmodule
