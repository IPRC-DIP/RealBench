/////////////////////////////////////////////////////////////////////
////                                                             ////
////  AES Inverse Cipher Top Level                               ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/aes_core/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: aes_inv_cipher_top.v,v 1.1.1.1 2002-11-09 11:22:53 rudi Exp $
//
//  $Date: 2002-11-09 11:22:53 $
//  $Revision: 1.1.1.1 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//
//
//
//
//

//`include "timescale.v"

module ref_aes_inv_cipher_top(clk, rst, kld, ld, done, key, text_in, text_out );
input		clk, rst;
input		kld, ld;
output		done;
input	[127:0]	key;
input	[127:0]	text_in;
output	[127:0]	text_out;

////////////////////////////////////////////////////////////////////
//
// Local Wires
//

wire	[31:0]	wk0, wk1, wk2, wk3;
reg	[31:0]	w0, w1, w2, w3;
reg	[127:0]	text_in_r;
reg	[127:0]	text_out;
reg	[7:0]	sa00, sa01, sa02, sa03;
reg	[7:0]	sa10, sa11, sa12, sa13;
reg	[7:0]	sa20, sa21, sa22, sa23;
reg	[7:0]	sa30, sa31, sa32, sa33;
wire	[7:0]	sa00_next, sa01_next, sa02_next, sa03_next;
wire	[7:0]	sa10_next, sa11_next, sa12_next, sa13_next;
wire	[7:0]	sa20_next, sa21_next, sa22_next, sa23_next;
wire	[7:0]	sa30_next, sa31_next, sa32_next, sa33_next;
wire	[7:0]	sa00_sub, sa01_sub, sa02_sub, sa03_sub;
wire	[7:0]	sa10_sub, sa11_sub, sa12_sub, sa13_sub;
wire	[7:0]	sa20_sub, sa21_sub, sa22_sub, sa23_sub;
wire	[7:0]	sa30_sub, sa31_sub, sa32_sub, sa33_sub;
wire	[7:0]	sa00_sr, sa01_sr, sa02_sr, sa03_sr;
wire	[7:0]	sa10_sr, sa11_sr, sa12_sr, sa13_sr;
wire	[7:0]	sa20_sr, sa21_sr, sa22_sr, sa23_sr;
wire	[7:0]	sa30_sr, sa31_sr, sa32_sr, sa33_sr;
wire	[7:0]	sa00_ark, sa01_ark, sa02_ark, sa03_ark;
wire	[7:0]	sa10_ark, sa11_ark, sa12_ark, sa13_ark;
wire	[7:0]	sa20_ark, sa21_ark, sa22_ark, sa23_ark;
wire	[7:0]	sa30_ark, sa31_ark, sa32_ark, sa33_ark;
reg		ld_r, go, done;
reg	[3:0]	dcnt;

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//解密过程的轮控制：
//复位时计数器清零；完成时计数器清零；加载新数据时计数器置1；
//go信号有效时每周期递增
//计数到11且不在加载状态时置位完成信号

always @(posedge clk)
	if(!rst)	dcnt <=  4'h0;
	else
	if(done)	dcnt <=  4'h0;
	else
	if(ld)		dcnt <=  4'h1;
	else
	if(go)		dcnt <=  dcnt + 4'h1;

always @(posedge clk)	done <=  (dcnt==4'hb) & !ld;

always @(posedge clk)
	if(!rst)	go <=  1'b0;
	else
	if(ld)		go <=  1'b1;
	else
	if(done)	go <=  1'b0;

always @(posedge clk)	if(ld)	text_in_r <=  text_in;

always @(posedge clk)	ld_r <=  ld;

////////////////////////////////////////////////////////////////////
//
// Initial Permutation
//

always @(posedge clk)	sa33 <=  ld_r ? text_in_r[007:000] ^ w3[07:00] : sa33_next;
always @(posedge clk)	sa23 <=  ld_r ? text_in_r[015:008] ^ w3[15:08] : sa23_next;
always @(posedge clk)	sa13 <=  ld_r ? text_in_r[023:016] ^ w3[23:16] : sa13_next;
always @(posedge clk)	sa03 <=  ld_r ? text_in_r[031:024] ^ w3[31:24] : sa03_next;
always @(posedge clk)	sa32 <=  ld_r ? text_in_r[039:032] ^ w2[07:00] : sa32_next;
always @(posedge clk)	sa22 <=  ld_r ? text_in_r[047:040] ^ w2[15:08] : sa22_next;
always @(posedge clk)	sa12 <=  ld_r ? text_in_r[055:048] ^ w2[23:16] : sa12_next;
always @(posedge clk)	sa02 <=  ld_r ? text_in_r[063:056] ^ w2[31:24] : sa02_next;
always @(posedge clk)	sa31 <=  ld_r ? text_in_r[071:064] ^ w1[07:00] : sa31_next;
always @(posedge clk)	sa21 <=  ld_r ? text_in_r[079:072] ^ w1[15:08] : sa21_next;
always @(posedge clk)	sa11 <=  ld_r ? text_in_r[087:080] ^ w1[23:16] : sa11_next;
always @(posedge clk)	sa01 <=  ld_r ? text_in_r[095:088] ^ w1[31:24] : sa01_next;
always @(posedge clk)	sa30 <=  ld_r ? text_in_r[103:096] ^ w0[07:00] : sa30_next;
always @(posedge clk)	sa20 <=  ld_r ? text_in_r[111:104] ^ w0[15:08] : sa20_next;
always @(posedge clk)	sa10 <=  ld_r ? text_in_r[119:112] ^ w0[23:16] : sa10_next;
always @(posedge clk)	sa00 <=  ld_r ? text_in_r[127:120] ^ w0[31:24] : sa00_next;

////////////////////////////////////////////////////////////////////
//
// Round Permutations
//
//逆向轮变换实现
//1.逆向行位移变换
assign sa00_sr = sa00;//0行不移位
assign sa01_sr = sa01;
assign sa02_sr = sa02;
assign sa03_sr = sa03;
assign sa10_sr = sa13;//1行右移3字节
assign sa11_sr = sa10;
assign sa12_sr = sa11;
assign sa13_sr = sa12;
assign sa20_sr = sa22;//2行右移2字节
assign sa21_sr = sa23;
assign sa22_sr = sa20;
assign sa23_sr = sa21;
assign sa30_sr = sa31;//3行右移1字节
assign sa31_sr = sa32;
assign sa32_sr = sa33;
assign sa33_sr = sa30;

//2.轮密钥加
assign sa00_ark = sa00_sub ^ w0[31:24];
assign sa01_ark = sa01_sub ^ w1[31:24];
assign sa02_ark = sa02_sub ^ w2[31:24];
assign sa03_ark = sa03_sub ^ w3[31:24];
assign sa10_ark = sa10_sub ^ w0[23:16];
assign sa11_ark = sa11_sub ^ w1[23:16];
assign sa12_ark = sa12_sub ^ w2[23:16];
assign sa13_ark = sa13_sub ^ w3[23:16];
assign sa20_ark = sa20_sub ^ w0[15:08];
assign sa21_ark = sa21_sub ^ w1[15:08];
assign sa22_ark = sa22_sub ^ w2[15:08];
assign sa23_ark = sa23_sub ^ w3[15:08];
assign sa30_ark = sa30_sub ^ w0[07:00];
assign sa31_ark = sa31_sub ^ w1[07:00];
assign sa32_ark = sa32_sub ^ w2[07:00];
assign sa33_ark = sa33_sub ^ w3[07:00];

//3.逆向列混合
//assign {sa00_next, sa10_next, sa20_next, sa30_next} = inv_mix_col(sa00_ark,sa10_ark,sa20_ark,sa30_ark);
//assign {sa01_next, sa11_next, sa21_next, sa31_next} = inv_mix_col(sa01_ark,sa11_ark,sa21_ark,sa31_ark);
//assign {sa02_next, sa12_next, sa22_next, sa32_next} = inv_mix_col(sa02_ark,sa12_ark,sa22_ark,sa32_ark);
//assign {sa03_next, sa13_next, sa23_next, sa33_next} = inv_mix_col(sa03_ark,sa13_ark,sa23_ark,sa33_ark);
wire [31:0] temp_result;
assign temp_result = inv_mix_col(sa00_ark, sa10_ark, sa20_ark, sa30_ark);
assign {sa00_next, sa10_next, sa20_next, sa30_next} = temp_result;

wire [31:0] temp_result1;
assign temp_result1 = inv_mix_col(sa01_ark, sa11_ark, sa21_ark, sa31_ark);
assign {sa01_next, sa11_next, sa21_next, sa31_next} = temp_result1;

wire [31:0] temp_result2;
assign temp_result2 = inv_mix_col(sa02_ark, sa12_ark, sa22_ark, sa32_ark);
assign {sa02_next, sa12_next, sa22_next, sa32_next} = temp_result2;

wire [31:0] temp_result3;
assign temp_result3 = inv_mix_col(sa03_ark, sa13_ark, sa23_ark, sa33_ark);
assign {sa03_next, sa13_next, sa23_next, sa33_next} = temp_result3;

////////////////////////////////////////////////////////////////////
//
// Final Text Output
//

always @(posedge clk) text_out[127:120] <=  sa00_ark;
always @(posedge clk) text_out[095:088] <=  sa01_ark;
always @(posedge clk) text_out[063:056] <=  sa02_ark;
always @(posedge clk) text_out[031:024] <=  sa03_ark;
always @(posedge clk) text_out[119:112] <=  sa10_ark;
always @(posedge clk) text_out[087:080] <=  sa11_ark;
always @(posedge clk) text_out[055:048] <=  sa12_ark;
always @(posedge clk) text_out[023:016] <=  sa13_ark;
always @(posedge clk) text_out[111:104] <=  sa20_ark;
always @(posedge clk) text_out[079:072] <=  sa21_ark;
always @(posedge clk) text_out[047:040] <=  sa22_ark;
always @(posedge clk) text_out[015:008] <=  sa23_ark;
always @(posedge clk) text_out[103:096] <=  sa30_ark;
always @(posedge clk) text_out[071:064] <=  sa31_ark;
always @(posedge clk) text_out[039:032] <=  sa32_ark;
always @(posedge clk) text_out[007:000] <=  sa33_ark;

////////////////////////////////////////////////////////////////////
//
// Generic Functions
//列混合运算

function [31:0] inv_mix_col;
input	[7:0]	s0,s1,s2,s3;
begin
inv_mix_col[31:24]=pmul_e(s0)^pmul_b(s1)^pmul_d(s2)^pmul_9(s3);
inv_mix_col[23:16]=pmul_9(s0)^pmul_e(s1)^pmul_b(s2)^pmul_d(s3);
inv_mix_col[15:08]=pmul_d(s0)^pmul_9(s1)^pmul_e(s2)^pmul_b(s3);
inv_mix_col[07:00]=pmul_b(s0)^pmul_d(s1)^pmul_9(s2)^pmul_e(s3);
end
endfunction

// Some synthesis tools don't like xtime being called recursevly ...
//GF(2^8)乘法运算

//×14
function [7:0] pmul_e;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);//×2
four=xtime(two);//×4
eight=xtime(four);//×8
pmul_e=eight^four^two;//8+4+2=14
end
endfunction

function [7:0] pmul_9;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_9=eight^b;
end
endfunction

function [7:0] pmul_d;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_d=eight^four^b;
end
endfunction

function [7:0] pmul_b;
input [7:0] b;
reg [7:0] two,four,eight;
begin
two=xtime(b);four=xtime(two);eight=xtime(four);pmul_b=eight^two^b;
end
endfunction

function [7:0] xtime;
input [7:0] b;xtime={b[6:0],1'b0}^(8'h1b&{8{b[7]}});
endfunction

////////////////////////////////////////////////////////////////////
//
// Key Buffer
//
//密钥缓存相关寄存器和计数器
reg	[127:0]	kb[10:0];//11个轮密钥的缓存
reg	[3:0]	kcnt;//密钥缓存计数器
reg		kdone;//密钥加载完成标志
reg		kb_ld;//密钥缓存加载使能

//密钥缓存计数器控制，kcnt逆序存储轮密钥
always @(posedge clk)
	if(!rst)	kcnt <=  4'ha;
	else
	if(kld)		kcnt <=  4'ha;
	else
	if(kb_ld)	kcnt <=  kcnt - 4'h1;

//密钥加载控制
always @(posedge clk)
	if(!rst)	kb_ld <=  1'b0;
	else
	if(kld)		kb_ld <=  1'b1;
	else
	if(kcnt==4'h0)	kb_ld <=  1'b0;

always @(posedge clk)	kdone <=  (kcnt==4'h0) & !kld;

//密钥缓存写入和读取
always @(posedge clk)	if(kb_ld) kb[kcnt] <=  {wk3, wk2, wk1, wk0};//存储轮密钥
always @(posedge clk)	{w3, w2, w1, w0} <=  kb[dcnt];//读取轮密钥

////////////////////////////////////////////////////////////////////
//
// Modules
//

aes_key_expand_128 u0(
	.clk(		clk	),
	.kld(		kld	),
	.key(		key	),
	.wo_0(		wk0	),
	.wo_1(		wk1	),
	.wo_2(		wk2	),
	.wo_3(		wk3	));

aes_inv_sbox us00(	.a(	sa00_sr	),	.b(	sa00_sub	));
aes_inv_sbox us01(	.a(	sa01_sr	),	.b(	sa01_sub	));
aes_inv_sbox us02(	.a(	sa02_sr	),	.b(	sa02_sub	));
aes_inv_sbox us03(	.a(	sa03_sr	),	.b(	sa03_sub	));
aes_inv_sbox us10(	.a(	sa10_sr	),	.b(	sa10_sub	));
aes_inv_sbox us11(	.a(	sa11_sr	),	.b(	sa11_sub	));
aes_inv_sbox us12(	.a(	sa12_sr	),	.b(	sa12_sub	));
aes_inv_sbox us13(	.a(	sa13_sr	),	.b(	sa13_sub	));
aes_inv_sbox us20(	.a(	sa20_sr	),	.b(	sa20_sub	));
aes_inv_sbox us21(	.a(	sa21_sr	),	.b(	sa21_sub	));
aes_inv_sbox us22(	.a(	sa22_sr	),	.b(	sa22_sub	));
aes_inv_sbox us23(	.a(	sa23_sr	),	.b(	sa23_sub	));
aes_inv_sbox us30(	.a(	sa30_sr	),	.b(	sa30_sub	));
aes_inv_sbox us31(	.a(	sa31_sr	),	.b(	sa31_sub	));
aes_inv_sbox us32(	.a(	sa32_sr	),	.b(	sa32_sub	));
aes_inv_sbox us33(	.a(	sa33_sr	),	.b(	sa33_sub	));

endmodule