module Aes_encryption(clk,data_in,key,data_out);
input clk;
input [0:127] data_in,key;
output[0:127] data_out;
wire [0:127] round_key0,round_key1,round_key2,round_key3,round_key4,round_key5,round_key6,round_key7,round_key8,round_key9,round_key10;
wire [0:127]round_out0,round_out1,round_out2,round_out3,round_out4,round_out5,round_out6,round_out7,round_out8,round_out9,round_out10;

key_expansion_module k0( clk,round_key0,round_key1,round_key2,round_key3,round_key4,round_key5,round_key6,round_key7,round_key8,round_key9,round_key10);

assign round_key0=key;
assign round_out0=data_in^round_key0;

encryption_round r1(clk,round_out0,round_key1,round_out1);
encryption_round r2(clk,round_out1,round_key2,round_out2);
encryption_round r3(clk,round_out2,round_key3,round_out3);
encryption_round r4(clk,round_out3,round_key4,round_out4);
encryption_round r5(clk,round_out4,round_key5,round_out5);
encryption_round r6(clk,round_out5,round_key6,round_out6);
encryption_round r7(clk,round_out6,round_key7,round_out7);
encryption_round r8(clk,round_out7,round_key8,round_out8);
encryption_round r9(clk,round_out8,round_key9,round_out9);
encryption_last_round r10(clk,round_out9,round_key10,round_out10);

assign data_out=round_out10;
endmodule
