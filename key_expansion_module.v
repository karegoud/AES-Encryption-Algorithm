module key_expansion_module( clk,round_key0,round_key1,round_key2,round_key3,
                           round_key4,round_key5,round_key6,
                           round_key7,round_key8,round_key9,round_key10);
input	[0:127]round_key0;
input clk;
output [0:127] round_key1,round_key2,round_key3,round_key4,round_key5,round_key6,round_key7,round_key8,round_key9,round_key10;

reg	[0:31]	w0,w1,w2,w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, 
               w15, w16, w17,w18, w19, w20,w21, w22, w23, w24, w25, w26, 
					w27, w28, w29, w30, w31, w32, w33,w34, w35, w36, w37, w38, 
					w39,w40, w41, w42, w43;
wire	[0:31]	subword1, subword2,subword3,subword4,subword5, subword6, subword7,subword8,subword9,subword10;			
wire	[0:7]	round_constant1, round_constant2,round_constant3,round_constant4,
            round_constant5, round_constant6, round_constant7,round_constant8,
				round_constant9,round_constant10;	

always @*
begin 
w3 =  round_key0[96:127];
w2 =  round_key0[64:95];
w1 =  round_key0[32:63];
w0 =  round_key0[0:31];

w4 =  round_key0[0:31]^subword1^{8'h01,24'b0};
w5 =  round_key0[32:63]^round_key0[0:31]^subword1^{8'h01,24'b0};
w6 =  round_key0[64:95]^round_key0[32:63]^round_key0[0:31]^subword1^{8'h01,24'b0}; 
w7 =  round_key0[96:127]^round_key0[64:95]^round_key0[32:63]^round_key0[0:31]^subword1^{8'h01,24'b0};

w8 =  w4^subword2^{round_constant2,24'b0};
w9  =  w5^w4^subword2^{round_constant2,24'b0};
w10 =  w6^w5^w4^subword2^{round_constant2,24'b0}; 
w11 =  w7^w6^w5^w4^subword2^{round_constant2,24'b0};

w12  =  w8^subword3^{round_constant3,24'b0};
w13  =  w8^w9^subword3^{round_constant3,24'b0};
w14  =  w8^w9^w10^subword3^{round_constant3,24'b0}; 
w15  =  w8^w9^w10^w11^subword3^{round_constant3,24'b0};

w16  =  w12^subword4^{round_constant4,24'b0};
w17  =  w12^w13^subword4^{round_constant4,24'b0};
w18  =  w12^w13^w14^subword4^{round_constant4,24'b0}; 
w19  =  w12^w13^w14^w15^subword4^{round_constant4,24'b0};

w20  =  w16^subword5^{round_constant5,24'b0};
w21  =  w16^w17^subword5^{round_constant5,24'b0};
w22  =  w16^w17^w18^subword5^{round_constant5,24'b0}; 
w23  =  w16^w17^w18^w19^subword5^{round_constant5,24'b0};

w24  =  w20^subword6^{round_constant6,24'b0};
w25  =  w20^w21^subword6^{round_constant6,24'b0};
w26  =  w20^w21^w22^subword6^{round_constant6,24'b0}; 
w27  =  w20^w21^w22^w23^subword6^{round_constant6,24'b0};

w28  =  w24^subword7^{round_constant7,24'b0};
w29  =  w24^w25^subword7^{round_constant7,24'b0};
w30  =  w24^w25^w26^subword7^{round_constant7,24'b0}; 
w31  =  w24^w25^w26^w27^subword7^{round_constant7,24'b0};

w32  =  w28^subword8^{round_constant8,24'b0};
w33  =  w28^w29^subword8^{round_constant8,24'b0};
w34  =  w28^w29^w30^subword8^{round_constant8,24'b0}; 
w35  =  w28^w29^w30^w31^subword8^{round_constant8,24'b0};

w36  =  w32^subword9^{round_constant9,24'b0};
w37  =  w32^w33^subword9^{round_constant9,24'b0};
w38  =  w32^w33^w34^subword9^{round_constant9,24'b0}; 
w39  =  w32^w33^w34^w35^subword9^{round_constant9,24'b0};

w40  =  w36^subword10^{round_constant10,24'b0};
w41  =  w36^w37^subword10^{round_constant10,24'b0};
w42  =  w36^w37^w38^subword10^{round_constant10,24'b0}; 
w43  =  w36^w37^w38^w39^subword10^{round_constant10,24'b0};
end
Round_constant_generation r0(clk,round_constant,round_constant2,
                round_constant3,round_constant4,round_constant5,
                round_constant6,round_constant7,round_constant8,
					 round_constant9,round_constant10); 

sbox u0(	w3[8:15],subword1[0:7]);
sbox u1(	w3[16:23], subword1[8:15]);
sbox u2(	w3[24:31], subword1[16:23]);
sbox u3(	w3[0:7], subword1[24:31]); 

sbox u4(	w7[8:15], subword2[0:7]);
sbox u5(	w7[16:23], subword2[8:15]);
sbox u6(	w7[24:31], subword2[16:23]);
sbox u7(	w7[0:7], subword2[24:31]); 

sbox u8(	w11[8:15], subword3[0:7]);
sbox u9(	w11[16:23], subword3[8:15]);
sbox u10(w11[24:31], subword3[16:23]);
sbox u11(w11[0:7], subword3[24:31]); 


sbox u12(w15[8:15], subword4[0:7]);
sbox u13(w15[16:23], subword4[8:15]);
sbox u14(w15[24:31], subword4[16:23]);
sbox u15(w15[0:7], subword4[24:31]); 

sbox u16(w19[8:15],subword5[0:7]);
sbox u17(w19[16:23], subword5[8:15]);
sbox u18(w19[24:31], subword5[16:23]);
sbox u19(w19[0:7], subword5[24:31]); 

sbox u20(w23[8:15], subword6[0:7]);
sbox u21(w23[16:23], subword6[8:15]);
sbox u22(w23[24:31], subword6[16:23]);
sbox u23(w23[0:7], subword6[24:31]); 

sbox u24(w27[8:15], subword7[0:7]);
sbox u25(w27[16:23], subword7[8:15]);
sbox u26(w27[24:31], subword7[16:23]);
sbox u27(w27[0:7], subword7[24:31]); 

sbox u28(w31[8:15], subword8[0:7]);
sbox u29(w31[16:23], subword8[8:15]);
sbox u30(w31[24:31], subword8[16:23]);
sbox u31(w31[0:7], subword8[24:31]); 

sbox u32(w35[8:15], subword9[0:7]);
sbox u33(w35[16:23], subword9[8:15]);
sbox u34(w35[24:31], subword9[16:23]);
sbox u35(w35[0:7], subword9[24:31]); 

sbox u36(w39[8:15], subword10[0:7]);
sbox u37(w39[16:23], subword10[8:15]);
sbox u38(w39[24:31], subword10[16:23]);
sbox u39(w39[0:7], subword10[24:31]); 

assign round_key1={w4,w5,w6,w7};
assign round_key2={w8,w9,w10,w11};
assign round_key3={w12,w13,w14,w15};
assign round_key4={w16,w17,w18,w19};
assign round_key5={w20,w21,w22,w23};
assign round_key6={w24,w25,w26,w27};
assign round_key7={w28,w29,w30,w31};
assign round_key8={w32,w33,w34,w35};
assign round_key9={w36,w37,w38,w39};
assign round_key10={w40,w41,w42,w43};

endmodule


module Round_constant_generation(clk,r_out1,r_out2,r_out3,r_out4,r_out5,r_out6,r_out7,r_out8,r_out9,r_out10);
input clk;
output [0:7]r_out1,r_out2,r_out3,r_out4,r_out5,r_out6,r_out7,r_out8,r_out9,r_out10;

assign		r_out1  = fround_constant(0);
assign		r_out2 = fround_constant(1); 
assign		r_out3 = fround_constant(2);
assign		r_out4 = fround_constant(3);
assign		r_out5 = fround_constant(4);
assign		r_out6 = fround_constant(5);
assign		r_out7 = fround_constant(6); 
assign		r_out8 = fround_constant(7);
assign		r_out9 = fround_constant(8);
assign		r_out10 = fround_constant(9);		 

function [0:7]	fround_constant;
input	[0:3]	i;
case(i)	
   4'h0: fround_constant=8'h01;		
   4'h1: fround_constant=8'h02;		
   4'h2: fround_constant=8'h04;		
   4'h3: fround_constant=8'h08;		
   4'h4: fround_constant=8'h10;		
   4'h5: fround_constant=8'h20;		
   4'h6: fround_constant=8'h40;		
   4'h7: fround_constant=8'h80;		
   4'h8: fround_constant=8'h1b;		
   4'h9: fround_constant=8'h36;		
   default: fround_constant=8'h00;
endcase
endfunction

endmodule




