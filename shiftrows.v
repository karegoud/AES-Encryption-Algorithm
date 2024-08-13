module shiftrows(clk,shiftrows_in,shiftrows_out);
input clk;
input [0:127]shiftrows_in;
output reg [0:127]shiftrows_out;

always@(posedge clk)
begin
shiftrows_out[120:127]<=shiftrows_in[88:95];
shiftrows_out[112:119]<=shiftrows_in[48:55];
shiftrows_out[104:111]<=shiftrows_in[8:15];
shiftrows_out[96:103]<=shiftrows_in[96:103]; 
shiftrows_out[88:95]<=shiftrows_in[56:63];
shiftrows_out[80:87]<=shiftrows_in[16:23];
shiftrows_out[72:79]<=shiftrows_in[104:111];
shiftrows_out[64:71]<=shiftrows_in[64:71];
shiftrows_out[56:63]<=shiftrows_in[24:31];
shiftrows_out[48:55]<=shiftrows_in[112:119];
shiftrows_out[40:47]<=shiftrows_in[72:79];
shiftrows_out[32:39]<=shiftrows_in[32:39];
shiftrows_out[24:31]<=shiftrows_in[120:127];
shiftrows_out[16:23]<=shiftrows_in[80:87];
shiftrows_out[8:15]<= shiftrows_in[40:47];
shiftrows_out[0:7]<=shiftrows_in[0:7];
end
endmodule
