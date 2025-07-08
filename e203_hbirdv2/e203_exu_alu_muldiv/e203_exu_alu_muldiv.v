 /*                                                                      
 Copyright 2018-2020 Nuclei System Technology, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
//
// Designer   : Bob Hu
//
// Description:
//  This module to implement the 17cycles MUL and 33 cycles DIV unit, which is mostly 
//  share the datapath with ALU_DPATH module to save gatecount to mininum
//
//
// ====================================================================
`include "e203_defines.v"

`ifdef E203_SUPPORT_MULDIV //{
module e203_exu_alu_muldiv(
  input  mdv_nob2b,

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The Issue Handshake Interface to MULDIV 
  //
  input  muldiv_i_valid, // Handshake valid
  output muldiv_i_ready, // Handshake ready

  input  [`E203_XLEN-1:0] muldiv_i_rs1,
  input  [`E203_XLEN-1:0] muldiv_i_rs2,
  input  [`E203_XLEN-1:0] muldiv_i_imm,
  input  [`E203_DECINFO_MULDIV_WIDTH-1:0] muldiv_i_info,
  input  [`E203_ITAG_WIDTH-1:0] muldiv_i_itag,

  output muldiv_i_longpipe,

  input  flush_pulse,

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The MULDIV Write-Back/Commit Interface
  output muldiv_o_valid, // Handshake valid
  input  muldiv_o_ready, // Handshake ready
  output [`E203_XLEN-1:0] muldiv_o_wbck_wdat,
  output muldiv_o_wbck_err,   
  //   There is no exception cases for MULDIV, so no addtional cmt signals

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // To share the ALU datapath, generate interface to ALU
  // 
  // The operands and info to ALU
  output [`E203_MULDIV_ADDER_WIDTH-1:0] muldiv_req_alu_op1,
  output [`E203_MULDIV_ADDER_WIDTH-1:0] muldiv_req_alu_op2,
  output                                muldiv_req_alu_add ,
  output                                muldiv_req_alu_sub ,
  input  [`E203_MULDIV_ADDER_WIDTH-1:0] muldiv_req_alu_res,

     // The Shared-Buffer interface to ALU-Shared-Buffer
  output          muldiv_sbf_0_ena,
  output [33-1:0] muldiv_sbf_0_nxt,
  input  [33-1:0] muldiv_sbf_0_r,

  output          muldiv_sbf_1_ena,
  output [33-1:0] muldiv_sbf_1_nxt,
  input  [33-1:0] muldiv_sbf_1_r,

  input  clk,
  input  rst_n
  );

  
endmodule                                      
`endif//}
                                               
                                               
                                               
