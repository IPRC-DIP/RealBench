module ref_aes_key_expand_128(clk, kld, key, wo_0, wo_1, wo_2, wo_3);
input		clk;
input		kld;
input	[127:0]	key;
output	[31:0]	wo_0, wo_1, wo_2, wo_3;
reg	[31:0]	w[3:0];
wire	[31:0]	tmp_w;
wire	[31:0]	subword;
wire	[31:0]	rcon;

assign wo_0 = w[0];
assign wo_1 = w[1];
assign wo_2 = w[2];
assign wo_3 = w[3];
always @(posedge clk)	w[0] <= #1 kld ? key[127:096] : w[0]^subword^rcon;
always @(posedge clk)	w[1] <= #1 kld ? key[095:064] : w[0]^w[1]^subword^rcon;
always @(posedge clk)	w[2] <= #1 kld ? key[063:032] : w[0]^w[2]^w[1]^subword^rcon;
always @(posedge clk)	w[3] <= #1 kld ? key[031:000] : w[0]^w[3]^w[2]^w[1]^subword^rcon;
assign tmp_w = w[3];
ref_aes_sbox u0(	.a(tmp_w[23:16]), .b(subword[31:24]));
ref_aes_sbox u1(	.a(tmp_w[15:08]), .b(subword[23:16]));
ref_aes_sbox u2(	.a(tmp_w[07:00]), .b(subword[15:08]));
ref_aes_sbox u3(	.a(tmp_w[31:24]), .b(subword[07:00]));
ref_aes_rcon r0(	.clk(clk), .kld(kld), .out(rcon));
endmodule