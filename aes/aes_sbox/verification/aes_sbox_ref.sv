/////////////////////////////////////////////////////////////////////
////                                                             ////
////  AES SBOX (ROM)                                             ////
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
//  $Id: aes_sbox.v,v 1.1.1.1 2002-11-09 11:22:38 rudi Exp $
//
//  $Date: 2002-11-09 11:22:38 $
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

module ref_aes_sbox(a,b);
input	[7:0]	a;
output	[7:0]	b;
reg	[7:0]	b;

always @(a)
	case(a)		// synopsys full_case parallel_case
	   8'h00: b=8'h63;
	   8'h01: b=8'h7c;
	   8'h02: b=8'h77;
	   8'h03: b=8'h7b;
	   8'h04: b=8'hf2;
	   8'h05: b=8'h6b;
	   8'h06: b=8'h6f;
	   8'h07: b=8'hc5;
	   8'h08: b=8'h30;
	   8'h09: b=8'h01;
	   8'h0a: b=8'h67;
	   8'h0b: b=8'h2b;
	   8'h0c: b=8'hfe;
	   8'h0d: b=8'hd7;
	   8'h0e: b=8'hab;
	   8'h0f: b=8'h76;
	   8'h10: b=8'hca;
	   8'h11: b=8'h82;
	   8'h12: b=8'hc9;
	   8'h13: b=8'h7d;
	   8'h14: b=8'hfa;
	   8'h15: b=8'h59;
	   8'h16: b=8'h47;
	   8'h17: b=8'hf0;
	   8'h18: b=8'had;
	   8'h19: b=8'hd4;
	   8'h1a: b=8'ha2;
	   8'h1b: b=8'haf;
	   8'h1c: b=8'h9c;
	   8'h1d: b=8'ha4;
	   8'h1e: b=8'h72;
	   8'h1f: b=8'hc0;
	   8'h20: b=8'hb7;
	   8'h21: b=8'hfd;
	   8'h22: b=8'h93;
	   8'h23: b=8'h26;
	   8'h24: b=8'h36;
	   8'h25: b=8'h3f;
	   8'h26: b=8'hf7;
	   8'h27: b=8'hcc;
	   8'h28: b=8'h34;
	   8'h29: b=8'ha5;
	   8'h2a: b=8'he5;
	   8'h2b: b=8'hf1;
	   8'h2c: b=8'h71;
	   8'h2d: b=8'hd8;
	   8'h2e: b=8'h31;
	   8'h2f: b=8'h15;
	   8'h30: b=8'h04;
	   8'h31: b=8'hc7;
	   8'h32: b=8'h23;
	   8'h33: b=8'hc3;
	   8'h34: b=8'h18;
	   8'h35: b=8'h96;
	   8'h36: b=8'h05;
	   8'h37: b=8'h9a;
	   8'h38: b=8'h07;
	   8'h39: b=8'h12;
	   8'h3a: b=8'h80;
	   8'h3b: b=8'he2;
	   8'h3c: b=8'heb;
	   8'h3d: b=8'h27;
	   8'h3e: b=8'hb2;
	   8'h3f: b=8'h75;
	   8'h40: b=8'h09;
	   8'h41: b=8'h83;
	   8'h42: b=8'h2c;
	   8'h43: b=8'h1a;
	   8'h44: b=8'h1b;
	   8'h45: b=8'h6e;
	   8'h46: b=8'h5a;
	   8'h47: b=8'ha0;
	   8'h48: b=8'h52;
	   8'h49: b=8'h3b;
	   8'h4a: b=8'hd6;
	   8'h4b: b=8'hb3;
	   8'h4c: b=8'h29;
	   8'h4d: b=8'he3;
	   8'h4e: b=8'h2f;
	   8'h4f: b=8'h84;
	   8'h50: b=8'h53;
	   8'h51: b=8'hd1;
	   8'h52: b=8'h00;
	   8'h53: b=8'hed;
	   8'h54: b=8'h20;
	   8'h55: b=8'hfc;
	   8'h56: b=8'hb1;
	   8'h57: b=8'h5b;
	   8'h58: b=8'h6a;
	   8'h59: b=8'hcb;
	   8'h5a: b=8'hbe;
	   8'h5b: b=8'h39;
	   8'h5c: b=8'h4a;
	   8'h5d: b=8'h4c;
	   8'h5e: b=8'h58;
	   8'h5f: b=8'hcf;
	   8'h60: b=8'hd0;
	   8'h61: b=8'hef;
	   8'h62: b=8'haa;
	   8'h63: b=8'hfb;
	   8'h64: b=8'h43;
	   8'h65: b=8'h4d;
	   8'h66: b=8'h33;
	   8'h67: b=8'h85;
	   8'h68: b=8'h45;
	   8'h69: b=8'hf9;
	   8'h6a: b=8'h02;
	   8'h6b: b=8'h7f;
	   8'h6c: b=8'h50;
	   8'h6d: b=8'h3c;
	   8'h6e: b=8'h9f;
	   8'h6f: b=8'ha8;
	   8'h70: b=8'h51;
	   8'h71: b=8'ha3;
	   8'h72: b=8'h40;
	   8'h73: b=8'h8f;
	   8'h74: b=8'h92;
	   8'h75: b=8'h9d;
	   8'h76: b=8'h38;
	   8'h77: b=8'hf5;
	   8'h78: b=8'hbc;
	   8'h79: b=8'hb6;
	   8'h7a: b=8'hda;
	   8'h7b: b=8'h21;
	   8'h7c: b=8'h10;
	   8'h7d: b=8'hff;
	   8'h7e: b=8'hf3;
	   8'h7f: b=8'hd2;
	   8'h80: b=8'hcd;
	   8'h81: b=8'h0c;
	   8'h82: b=8'h13;
	   8'h83: b=8'hec;
	   8'h84: b=8'h5f;
	   8'h85: b=8'h97;
	   8'h86: b=8'h44;
	   8'h87: b=8'h17;
	   8'h88: b=8'hc4;
	   8'h89: b=8'ha7;
	   8'h8a: b=8'h7e;
	   8'h8b: b=8'h3d;
	   8'h8c: b=8'h64;
	   8'h8d: b=8'h5d;
	   8'h8e: b=8'h19;
	   8'h8f: b=8'h73;
	   8'h90: b=8'h60;
	   8'h91: b=8'h81;
	   8'h92: b=8'h4f;
	   8'h93: b=8'hdc;
	   8'h94: b=8'h22;
	   8'h95: b=8'h2a;
	   8'h96: b=8'h90;
	   8'h97: b=8'h88;
	   8'h98: b=8'h46;
	   8'h99: b=8'hee;
	   8'h9a: b=8'hb8;
	   8'h9b: b=8'h14;
	   8'h9c: b=8'hde;
	   8'h9d: b=8'h5e;
	   8'h9e: b=8'h0b;
	   8'h9f: b=8'hdb;
	   8'ha0: b=8'he0;
	   8'ha1: b=8'h32;
	   8'ha2: b=8'h3a;
	   8'ha3: b=8'h0a;
	   8'ha4: b=8'h49;
	   8'ha5: b=8'h06;
	   8'ha6: b=8'h24;
	   8'ha7: b=8'h5c;
	   8'ha8: b=8'hc2;
	   8'ha9: b=8'hd3;
	   8'haa: b=8'hac;
	   8'hab: b=8'h62;
	   8'hac: b=8'h91;
	   8'had: b=8'h95;
	   8'hae: b=8'he4;
	   8'haf: b=8'h79;
	   8'hb0: b=8'he7;
	   8'hb1: b=8'hc8;
	   8'hb2: b=8'h37;
	   8'hb3: b=8'h6d;
	   8'hb4: b=8'h8d;
	   8'hb5: b=8'hd5;
	   8'hb6: b=8'h4e;
	   8'hb7: b=8'ha9;
	   8'hb8: b=8'h6c;
	   8'hb9: b=8'h56;
	   8'hba: b=8'hf4;
	   8'hbb: b=8'hea;
	   8'hbc: b=8'h65;
	   8'hbd: b=8'h7a;
	   8'hbe: b=8'hae;
	   8'hbf: b=8'h08;
	   8'hc0: b=8'hba;
	   8'hc1: b=8'h78;
	   8'hc2: b=8'h25;
	   8'hc3: b=8'h2e;
	   8'hc4: b=8'h1c;
	   8'hc5: b=8'ha6;
	   8'hc6: b=8'hb4;
	   8'hc7: b=8'hc6;
	   8'hc8: b=8'he8;
	   8'hc9: b=8'hdd;
	   8'hca: b=8'h74;
	   8'hcb: b=8'h1f;
	   8'hcc: b=8'h4b;
	   8'hcd: b=8'hbd;
	   8'hce: b=8'h8b;
	   8'hcf: b=8'h8a;
	   8'hd0: b=8'h70;
	   8'hd1: b=8'h3e;
	   8'hd2: b=8'hb5;
	   8'hd3: b=8'h66;
	   8'hd4: b=8'h48;
	   8'hd5: b=8'h03;
	   8'hd6: b=8'hf6;
	   8'hd7: b=8'h0e;
	   8'hd8: b=8'h61;
	   8'hd9: b=8'h35;
	   8'hda: b=8'h57;
	   8'hdb: b=8'hb9;
	   8'hdc: b=8'h86;
	   8'hdd: b=8'hc1;
	   8'hde: b=8'h1d;
	   8'hdf: b=8'h9e;
	   8'he0: b=8'he1;
	   8'he1: b=8'hf8;
	   8'he2: b=8'h98;
	   8'he3: b=8'h11;
	   8'he4: b=8'h69;
	   8'he5: b=8'hd9;
	   8'he6: b=8'h8e;
	   8'he7: b=8'h94;
	   8'he8: b=8'h9b;
	   8'he9: b=8'h1e;
	   8'hea: b=8'h87;
	   8'heb: b=8'he9;
	   8'hec: b=8'hce;
	   8'hed: b=8'h55;
	   8'hee: b=8'h28;
	   8'hef: b=8'hdf;
	   8'hf0: b=8'h8c;
	   8'hf1: b=8'ha1;
	   8'hf2: b=8'h89;
	   8'hf3: b=8'h0d;
	   8'hf4: b=8'hbf;
	   8'hf5: b=8'he6;
	   8'hf6: b=8'h42;
	   8'hf7: b=8'h68;
	   8'hf8: b=8'h41;
	   8'hf9: b=8'h99;
	   8'hfa: b=8'h2d;
	   8'hfb: b=8'h0f;
	   8'hfc: b=8'hb0;
	   8'hfd: b=8'h54;
	   8'hfe: b=8'hbb;
	   8'hff: b=8'h16;
	endcase

endmodule