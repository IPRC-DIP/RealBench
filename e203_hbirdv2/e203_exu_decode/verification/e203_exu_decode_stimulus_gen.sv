module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    output logic [31:0] i_instr,
    output logic [31:0] i_pc,
    output logic i_prdt_taken,
    output logic i_misalgn,
    output logic i_buserr,
    output logic i_muldiv_b2b,
    output logic dbg_mode,
    output logic nice_xs_off,
    output logic [511:0] wavedrom_title,
    output logic wavedrom_enable
);

    task wavedrom_start(input [511:0] title = "");
        wavedrom_title <= title;
        wavedrom_enable <= 1;
    endtask

    task wavedrom_stop;
        wavedrom_enable <= 0;
    endtask

    // Other Signal Test
    task other_signal_random_test();    //  
        i_prdt_taken    = $urandom;
        i_misalgn       = $urandom;
        i_buserr        = $urandom;
        i_muldiv_b2b    = $urandom;
        dbg_mode        = '0;   // 这两个信号需要特定指令才发挥作用，放在单独测试中
        nice_xs_off     = '0;
        i_pc            = $urandom;
        i_instr = 32'b0000000_00010_00001_000_00011_0110011; // Example: ADD x3, x1, x2
    endtask //

    task Debug(input ena = 0);  // 测试debug模块分别处于开关状态下，dret指令译码的结果
        i_prdt_taken    = 0;
        i_misalgn       = 0;
        i_buserr        = 0;
        i_muldiv_b2b    = 0;
        dbg_mode        = ena;
        nice_xs_off     = 0;
        i_pc            = $urandom;
        i_instr         = $urandom;
        i_instr[6:0] = 7'b11_100_11;    // dret
        i_instr[31:20] = 12'b0111_1011_0010;
        i_instr[14:12] = 3'b000;
    endtask

    task NICE(input ena = 0,input [3:0] custom_number = 0);   // 测试nice模块分别处于打开和关闭状态下，nice指令译码的结果
        i_prdt_taken    = 0;
        i_misalgn       = 0;
        i_buserr        = 0;
        i_muldiv_b2b    = 0;
        dbg_mode        = 0;   // 这两个信号需要特定指令才发挥作用，放在单独测试中
        nice_xs_off     = ena;
        i_pc            = $urandom;
        i_instr         = $urandom;
        begin
            case (custom_number)
                0: i_instr[6:0] = 7'b00_010_11; // custom0
                1: i_instr[6:0] = 7'b01_010_11; // custom1
                2: i_instr[6:0] = 7'b10_010_11; // custom2
                3: i_instr[6:0] = 7'b11_010_11; // custom3
                default: i_instr[6:0] = 7'b00_010_11; // custom0
            endcase
        end
    endtask

    // RV32I Base Instruction Set
    task RV32_default();
        i_prdt_taken    = $urandom;
        i_misalgn       = 0;
        i_buserr        = 0;
        i_muldiv_b2b    = 0;
        dbg_mode        = 0;
        nice_xs_off     = 0;
        i_pc            = $urandom;
    endtask //RV32_default

    task R_type(input[6:0]funct7,input[2:0]funct3,input[6:0]opcode);
        i_instr = $random;
        i_instr[31:25] = funct7;
        i_instr[14:12] = funct3;
        i_instr[6:0] = opcode;
    endtask

    task R_amo_type(input[6:0]funct7,input[2:0]funct3,input[6:0]opcode);
        i_instr = $random;
        i_instr[31:27] = funct7[6:2];
        i_instr[14:12] = funct3;
        i_instr[6:0] = opcode;
    endtask

    task I_type(input[2:0]funct3,input[6:0]opcode);
        i_instr = $random;
        i_instr[14:12] = funct3;
        i_instr[6:0] = opcode;
    endtask

    task S_type(input[2:0]funct3,input[6:0]opcode);
        i_instr = $random;
        i_instr[14:12] = funct3;
        i_instr[6:0] = opcode;
    endtask

    task SB_type(input[2:0]funct3,input[6:0]opcode);
        i_instr = $random;
        i_instr[14:12] = funct3;
        i_instr[6:0] = opcode;
    endtask

    task U_type(input[6:0]opcode);
        i_instr = $random;
        i_instr[6:0] = opcode;
    endtask

    task UJ_type(input[6:0]opcode);
        i_instr = $random;
        i_instr[6:0] = opcode;
    endtask

    task RVC00(input[2:0]funct3,input[1:0]opcode);
        i_instr = $random;
        i_instr[15:13] = funct3;
        i_instr[1:0] = opcode;
    endtask

    task RVC01(input[2:0]funct3,input[1:0]opcode);
        i_instr = $random;
        i_instr[15:13] = funct3;
        i_instr[1:0] = opcode;
    endtask

    task RVC10(input[2:0]funct3,input[1:0]opcode);
        i_instr = $random;
        i_instr[15:13] = funct3;
        i_instr[1:0] = opcode;
    endtask

    task ADD; // Add
        RV32_default();
        R_type(7'b0000000, 3'b000, 7'b0110011);
    endtask

    task SUB; // Subtract
        RV32_default();
        R_type(7'b0100000, 3'b000, 7'b0110011);
    endtask

    task SLL; // Shift left logical
        RV32_default();
        R_type(7'b0000000, 3'b001, 7'b0110011);
    endtask

    task SLT; // Set less than (signed)
        RV32_default();
        R_type(7'b0000000, 3'b010, 7'b0110011);
    endtask

    task SLTU; // Set less than (unsigned)
        RV32_default();
        R_type(7'b0000000, 3'b011, 7'b0110011);
    endtask

    task XOR; // Exclusive OR
        RV32_default();
        R_type(7'b0000000, 3'b100, 7'b0110011);
    endtask

    task SRL; // Shift right logical
        RV32_default();
        R_type(7'b0000000, 3'b101, 7'b0110011);
    endtask

    task SRA; // Shift right arithmetic
        RV32_default();
        R_type(7'b0100000, 3'b101, 7'b0110011);
    endtask

    task OR; // OR
        RV32_default();
        R_type(7'b0000000, 3'b110, 7'b0110011);
    endtask

    task AND; // AND
        RV32_default();
        R_type(7'b0000000, 3'b111, 7'b0110011);
    endtask

    task LRW; // Load Reserved (lr.w)
        RV32_default();
        R_amo_type(7'b00010_11, 3'b010, 7'b0101111); // func7 = {00010, aq=1, rl=1}
        i_instr[24:20] = 5'b0;
    endtask

    task SCW; // Store Conditional (sc.w)
        RV32_default();
        R_amo_type(7'b00011_11, 3'b010, 7'b0101111); // func7 = {00011, aq=1, rl=1}
    endtask

    task AMOSWAPW; // Atomic Swap (amoswap.w)
        RV32_default();
        R_amo_type(7'b00001_11, 3'b010, 7'b0101111); // func7 = {00001, aq=1, rl=1}
    endtask

    task AMOADDW; // Atomic Add (amoadd.w)
        RV32_default();
        R_amo_type(7'b00000_11, 3'b010, 7'b0101111); // func7 = {00000, aq=1, rl=1}
    endtask

    task AMOXORW; // Atomic XOR (amoxor.w)
        RV32_default();
        R_amo_type(7'b00100_11, 3'b010, 7'b0101111); // func7 = {00100, aq=1, rl=1}
    endtask

    task AMOANDW; // Atomic AND (amoand.w)
        RV32_default();
        R_amo_type(7'b01100_11, 3'b010, 7'b0101111); // func7 = {01100, aq=1, rl=1}
    endtask

    task AMOORW; // Atomic OR (amoor.w)
        RV32_default();
        R_amo_type(7'b01000_11, 3'b010, 7'b0101111); // func7 = {01000, aq=1, rl=1}
    endtask

    task AMOMINW; // Atomic Minimum (amomin.w)
        RV32_default();
        R_amo_type(7'b10000_11, 3'b010, 7'b0101111); // func7 = {10000, aq=1, rl=1}
    endtask

    task AMOMAXW; // Atomic Maximum (amomax.w)
        RV32_default();
        R_amo_type(7'b10100_11, 3'b010, 7'b0101111); // func7 = {10100, aq=1, rl=1}
    endtask

    task AMOMINUW; // Atomic Minimum Unsigned (amominu.w)
        RV32_default();
        R_amo_type(7'b11000_11, 3'b010, 7'b0101111); // func7 = {11000, aq=1, rl=1}
    endtask

    task AMOMAXUW; // Atomic Maximum Unsigned (amomaxu.w)
        RV32_default();
        R_amo_type(7'b11100_11, 3'b010, 7'b0101111); // func7 = {11100, aq=1, rl=1}
    endtask

    task MUL; // Multiply
        RV32_default();
        R_type(7'b0000001, 3'b000, 7'b0110011); // func7 = 0000001, funct3 = 000, opcode = 0110011
    endtask

    task MULH; // Multiply Upper Half
        RV32_default();
        R_type(7'b0000001, 3'b001, 7'b0110011); // func7 = 0000001, funct3 = 001, opcode = 0110011
    endtask

    task MULHSU; // Multiply Upper Half Unsigned
        RV32_default();
        R_type(7'b0000001, 3'b010, 7'b0110011); // func7 = 0000001, funct3 = 010, opcode = 0110011
    endtask

    task MULHU; // Multiply Upper Half Sign/Unsigned
        RV32_default();
        R_type(7'b0000001, 3'b011, 7'b0110011); // func7 = 0000001, funct3 = 011, opcode = 0110011
    endtask

    task DIV; // Divide
        RV32_default();
        R_type(7'b0000001, 3'b100, 7'b0110011); // func7 = 0000001, funct3 = 100, opcode = 0110011
    endtask

    task DIVU; // Divide Unsigned
        RV32_default();
        R_type(7'b0000001, 3'b101, 7'b0110011); // func7 = 0000001, funct3 = 101, opcode = 0110011
    endtask

    task REM; // Remainder
        RV32_default();
        R_type(7'b0000001, 3'b110, 7'b0110011); // func7 = 0000001, funct3 = 110, opcode = 0110011
    endtask

    task REMU; // Remainder Unsigned
        RV32_default();
        R_type(7'b0000001, 3'b111, 7'b0110011); // func7 = 0000001, funct3 = 111, opcode = 0110011
    endtask

    task ADDI; // Add Immediate
        RV32_default();
        I_type(3'b000, 7'b0010011);
    endtask

    task SLTI; // Set Less Than Immediate (signed)
        RV32_default();
        I_type(3'b010, 7'b0010011);
    endtask

    task SLTIU; // Set Less Than Immediate (unsigned)
        RV32_default();
        I_type(3'b011, 7'b0010011);
    endtask

    task XORI; // XOR Immediate
        RV32_default();
        I_type(3'b100, 7'b0010011);
    endtask

    task ORI; // OR Immediate
        RV32_default();
        I_type(3'b110, 7'b0010011);
    endtask

    task ANDI; // AND Immediate
        RV32_default();
        I_type(3'b111, 7'b0010011);
    endtask

    task SLLI; // Shift Left Logical Immediate
        RV32_default();
        I_type(3'b001, 7'b0010011);
        i_instr[31:25] = 7'b0000000; // Set imm[11:5] = 0
    endtask

    task SRLI; // Shift Right Logical Immediate
        RV32_default();
        I_type(3'b101, 7'b0010011);
        i_instr[31:25] = 7'b0000000; // Set imm[11:5] = 0
    endtask

    task SRAI; // Shift Right Arithmetic Immediate
        RV32_default();
        I_type(3'b101, 7'b0010011);
        i_instr[31:25] = 7'b0100000; // Set imm[11:5] = 0100000
    endtask

    // Define tasks for Load instructions
    task LB; // Load Byte
        RV32_default();
        I_type(3'b000, 7'b0000011);
    endtask

    task LH; // Load Halfword
        RV32_default();
        I_type(3'b001, 7'b0000011);
    endtask

    task LW; // Load Word
        RV32_default();
        I_type(3'b010, 7'b0000011);
    endtask

    task LBU; // Load Byte Unsigned
        RV32_default();
        I_type(3'b100, 7'b0000011);
    endtask

    task LHU; // Load Halfword Unsigned
        RV32_default();
        I_type(3'b101, 7'b0000011);
    endtask

    // Define tasks for Jump and System instructions
    task JALR; // Jump and Link Register
        RV32_default();
        I_type(3'b000, 7'b1100111);
    endtask

    task ECALL; // Environment Call
        RV32_default();
        I_type(3'b000, 7'b1110011);
        i_instr[31:20] = 12'b000000000000; // imm[11:0] = 0
    endtask

    task EBREAK; // Environment Break
        RV32_default();
        I_type(3'b000, 7'b1110011);
        i_instr[31:20] = 12'b000000000001; // imm[11:0] = 1
    endtask

    task MRET; // Machine Return
        RV32_default();
        I_type(3'b000, 7'b1110011);
        i_instr[31:20] = 12'b001100000010; // imm[11:0] = 001100000010
    endtask

    task DRET; // Debug Return
        RV32_default();
        I_type(3'b000, 7'b1110011);
        i_instr[31:20] = 12'b011110110010; // imm[11:0] = 011110110010
    endtask

    task WFI; // Wait For Interrupt
        RV32_default();
        I_type(3'b000, 7'b1110011);
        i_instr[31:20] = 12'b000100000101; // imm[11:0] = 000100000101
    endtask

    // Define tasks for FENCE instructions
    task FENCE; // Fence
        RV32_default();
        I_type(3'b000, 7'b0001111);
        i_instr[31:28] = 4'b0000; // imm[11:8] = 0000
    endtask

    task FENCEI; // Fence.I
        RV32_default();
        I_type(3'b001, 7'b0001111);
        i_instr[31:20] = 12'b000000000000; // imm[11:0] = 0
    endtask

    // Define tasks for CSR instructions
    task CSRRW;
        RV32_default();
        I_type(3'b001, 7'b1110011);
    endtask

    task CSRRS;
        RV32_default();
        I_type(3'b010, 7'b1110011);
    endtask

    task CSRRC;
        RV32_default();
        I_type(3'b011, 7'b1110011);
    endtask

    task CSRRWI;
        RV32_default();
        I_type(3'b101, 7'b1110011);
    endtask

    task CSRRSI;
        RV32_default();
        I_type(3'b110, 7'b1110011);
    endtask

    task CSRRCI;
        RV32_default();
        I_type(3'b111, 7'b1110011);
    endtask

    task SB;
        RV32_default();
        S_type(3'b000, 7'b0100011); // funct3 = 000, opcode = 0100011
    endtask

    // Define task for Store Halfword (sh)
    task SH;
        RV32_default();
        S_type(3'b001, 7'b0100011); // funct3 = 001, opcode = 0100011
    endtask

    // Define task for Store Word (sw)
    task SW;
        RV32_default();
        S_type(3'b010, 7'b0100011); // funct3 = 010, opcode = 0100011
    endtask

    task BEQ;
        RV32_default();
        SB_type(3'b000, 7'b1100011); // funct3 = 000, opcode = 1100011
    endtask

    // Define task for Branch if Not Equal (bne)
    task BNE;
        RV32_default();
        SB_type(3'b001, 7'b1100011); // funct3 = 001, opcode = 1100011
    endtask

    // Define task for Branch if Less Than (signed) (blt)
    task BLT;
        RV32_default();
        SB_type(3'b100, 7'b1100011); // funct3 = 100, opcode = 1100011
    endtask

    // Define task for Branch if Greater Than or Equal (signed) (bge)
    task BGE;
        RV32_default();
        SB_type(3'b101, 7'b1100011); // funct3 = 101, opcode = 1100011
    endtask

    // Define task for Branch if Less Than (unsigned) (bltu)
    task BLTU;
        RV32_default();
        SB_type(3'b110, 7'b1100011); // funct3 = 110, opcode = 1100011
    endtask

    // Define task for Branch if Greater Than or Equal (unsigned) (bgeu)
    task BGEU;
        RV32_default();
        SB_type(3'b111, 7'b1100011); // funct3 = 111, opcode = 1100011
    endtask

    task LUI;
        RV32_default();
        U_type(7'b0110111); // opcode = 0110111
    endtask

    // Define task for AUIPC (Add Upper Immediate to Program Counter)
    task AUIPC;
        RV32_default();
        U_type(7'b0010111); // opcode = 0010111
    endtask

    task JAL;
        RV32_default();
        UJ_type(7'b1101111); // opcode = 1101111
    endtask

    task CLW;
        RV32_default();
        RVC00(3'b010,2'b00);
    endtask

    task CSW;
        RV32_default();
        RVC00(3'b110,2'b00);
    endtask

    task CADDI4SPN();
        RV32_default();
        RVC00(3'b000,2'b00);
    endtask



    // c.nop
    task CNOP;
        RV32_default();
        RVC01(3'b000, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:7] = 5'b00000;  // [11:7] = 00000
        i_instr[6:2] = 5'b00000;   // [6:2] = 00000
    endtask

    // c.addi
    task CADDI;
        RV32_default();
        RVC01(3'b000, 2'b01);
        i_instr[12] = $random;     // [12] = nzimm[5]
        i_instr[11:7] = $random;   // [11:7] = rs1/rd ≠ 0
        i_instr[6:2] = $random;    // [6:2] = nzimm[4:0]
    endtask

    // c.jal
    task CJAL;
        RV32_default();
        RVC01(3'b001, 2'b01);
        i_instr[12] = $random;     // [12] = imm[11]
        i_instr[11:7] = $random;   // [11:7] = imm[4|9:8|10|6]
        i_instr[6:2] = $random;    // [6:2] = imm[7|3:1|5]
    endtask

    // c.li
    task CLI;
        RV32_default();
        RVC01(3'b010, 2'b01);
        i_instr[12] = $random;     // [12] = imm[5]
        i_instr[11:7] = $random;   // [11:7] = rd ≠ 0
        i_instr[6:2] = $random;    // [6:2] = imm[4:0]
    endtask

    // c.addi16sp
    task CADDI16SP;
        RV32_default();
        RVC01(3'b011, 2'b01);
        i_instr[12] = $random;     // [12] = nzimm[9]
        i_instr[11:7] = 5'b00010;  // [11:7] = 2
        i_instr[6:2] = $random;    // [6:2] = nzimm[4|6|8:7|5]
    endtask

    // c.lui
    task CLUI;
        RV32_default();
        RVC01(3'b011, 2'b01);
        i_instr[12] = $random;     // [12] = nzimm[17]
        i_instr[11:7] = $random;   // [11:7] = rd ≠ {0,2}
        i_instr[6:2] = $random;    // [6:2] = nzimm[16:12]
    endtask

    // c.srli
    task CSRLI;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = $random;     // [12] = nzuimm[5]
        i_instr[11:10] = 2'b00;    // [11:10] = 00
        i_instr[6:2] = $random;    // [6:2] = nzuimm[4:0]
    endtask

    // c.srai
    task CSRAI;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = $random;     // [12] = nzuimm[5]
        i_instr[11:10] = 2'b01;    // [11:10] = 01
        i_instr[6:2] = $random;    // [6:2] = nzuimm[4:0]
    endtask

    // c.andi
    task CANDI;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = $random;     // [12] = imm[5]
        i_instr[11:10] = 2'b10;    // [11:10] = 10
        i_instr[6:2] = $random;    // [6:2] = imm[4:0]
    endtask

    // c.sub
    task CSUB;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:10] = 2'b11;    // [11:10] = 11
        i_instr[6:2] = 5'b00000;   // [6:2] = {00,rs2'}
    endtask

    // c.xor
    task CXOR;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:10] = 2'b11;    // [11:10] = 11
        i_instr[6:2] = 5'b00010;   // [6:2] = {02,rs2'}
    endtask

    // c.slli
    task CSLLI;
        RV32_default();
        RVC01(3'b000, 2'b01);
        i_instr[12] = $random;     // [12] = nzuimm[5]
        i_instr[11:7] = $random;   // [11:7] = rs1/rd ≠ 0
        i_instr[6:2] = $random;    // [6:2] = nzuimm[4:0]
    endtask

    // c.lwsp
    task CLWSP;
        RV32_default();
        RVC01(3'b010, 2'b01);
        i_instr[12] = $random;     // [12] = uimm[5]
        i_instr[11:7] = $random;   // [11:7] = rd ≠ 0
        i_instr[6:2] = $random;    // [6:2] = uimm[4:2|7:6]
    endtask

    // c.jr
    task CJR;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:7] = $random;   // [11:7] = rs1 ≠ 0
        i_instr[6:2] = 5'b00000;   // [6:2] = 0
    endtask

    // c.mv
    task CMV;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:7] = $random;   // [11:7] = rd ≠ 0
        i_instr[6:2] = $random;    // [6:2] = rs2 ≠ 0
    endtask

    // c.ebreak
    task CEBREAK;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b1;        // [12] = 1
        i_instr[11:7] = 5'b00000;  // [11:7] = 0
        i_instr[6:2] = 5'b00000;   // [6:2] = 0
    endtask

    // c.jalr
    task CJALR;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b1;        // [12] = 1
        i_instr[11:7] = $random;   // [11:7] = rs1 ≠ 0
        i_instr[6:2] = 5'b00000;   // [6:2] = 0
    endtask

    // c.add
    task CADD;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b1;        // [12] = 1
        i_instr[11:7] = $random;   // [11:7] = rs1/rd ≠ 0
        i_instr[6:2] = $random;    // [6:2] = rs2 ≠ 0
    endtask

    // c.swsp
    task CSWSP;
        RV32_default();
        RVC01(3'b110, 2'b01);
        i_instr[12] = $random;     // [12] = uimm[5]
        i_instr[11:7] = $random;   // [11:7] = uimm[4:2|7:6]
        i_instr[6:2] = $random;    // [6:2] = rs2
    endtask

    // c.or
    task COR;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:10] = 2'b11;    // [11:10] = 11
        i_instr[6:2] = 5'b00010;   // [6:2] = {10, rs2'}
    endtask

    // c.and
    task CAND;
        RV32_default();
        RVC01(3'b100, 2'b01);
        i_instr[12] = 1'b0;        // [12] = 0
        i_instr[11:10] = 2'b11;    // [11:10] = 11
        i_instr[6:2] = 5'b00011;   // [6:2] = {11, rs2'}
    endtask

    // c.j
    task CJ;
        RV32_default();
        RVC01(3'b101, 2'b01);
        i_instr[12] = $random;     // [12] = imm[11]
        i_instr[11:7] = $random;   // [11:7] = imm[4|9:8|10|6]
        i_instr[6:2] = $random;    // [6:2] = imm[7|3:1|5]
    endtask

    // c.beqz
    task CBEQZ;
        RV32_default();
        RVC01(3'b110, 2'b01);
        i_instr[12] = $random;     // [12] = imm[8]
        i_instr[11:10] = $random;  // [11:10] = {imm[4:3], rs1'}
        i_instr[6:2] = $random;    // [6:2] = imm[7:6|2:1|5]
    endtask

    // c.bnez
    task CBNEZ;
        RV32_default();
        RVC01(3'b111, 2'b01);
        i_instr[12] = $random;     // [12] = imm[8]
        i_instr[11:10] = $random;  // [11:10] = {imm[4:3], rs1'}
        i_instr[6:2] = $random;    // [6:2] = imm[7:6|2:1|5]
    endtask

    task test_R_type;
        @(negedge clk);
        // Call each R_type task with a negedge clk delay in between
        ADD; 
        @(negedge clk); // Wait for a negative edge
        SUB;
        @(negedge clk); // Wait for a negative edge
        SLL;
        @(negedge clk); // Wait for a negative edge
        SLT;
        @(negedge clk); // Wait for a negative edge
        SLTU;
        @(negedge clk); // Wait for a negative edge
        XOR;
        @(negedge clk); // Wait for a negative edge
        SRL;
        @(negedge clk); // Wait for a negative edge
        SRA;
        @(negedge clk); // Wait for a negative edge
        OR;
        @(negedge clk); // Wait for a negative edge
        AND;
        @(negedge clk); // Wait for a negative edge
        $display("All R_type tasks executed successfully.");
    endtask

    task test_RA_type;
        // Call each AMO task with a negedge clk delay in between
        LRW(); 
        @(negedge clk); // Wait for a negative edge
        SCW();
        @(negedge clk); // Wait for a negative edge
        AMOSWAPW();
        @(negedge clk); // Wait for a negative edge
        AMOADDW();
        @(negedge clk); // Wait for a negative edge
        AMOXORW();
        @(negedge clk); // Wait for a negative edge
        AMOANDW();
        @(negedge clk); // Wait for a negative edge
        AMOORW();
        @(negedge clk); // Wait for a negative edge
        AMOMINW();
        @(negedge clk); // Wait for a negative edge
        AMOMAXW();
        @(negedge clk); // Wait for a negative edge
        AMOMINUW();
        @(negedge clk); // Wait for a negative edge
        AMOMAXUW();
        @(negedge clk); // Wait for a negative edge
        $display("All RA_type (AMO) tasks executed successfully.");
    endtask

    // Task to test all RV32M instructions
    task test_RM_type;
        // Call each RV32M task with a negedge clk delay in between
        @(negedge clk);
        MUL(); 
        @(negedge clk); // Wait for a negative edge
        MULH();
        @(negedge clk); // Wait for a negative edge
        MULHSU();
        @(negedge clk); // Wait for a negative edge
        MULHU();
        @(negedge clk); // Wait for a negative edge
        DIV();
        @(negedge clk); // Wait for a negative edge
        DIVU();
        @(negedge clk); // Wait for a negative edge
        REM();
        @(negedge clk); // Wait for a negative edge
        REMU();
        @(negedge clk); // Wait for a negative edge
        $display("All RV32M (Multiply and Divide) tasks executed successfully.");
    endtask

    task test_I_type;
        // Test I-type arithmetic and logical instructions
        ADDI;
        @(negedge clk); // Wait for a negative edge
        SLTI;
        @(negedge clk); // Wait for a negative edge
        SLTIU;
        @(negedge clk); // Wait for a negative edge
        XORI;
        @(negedge clk); // Wait for a negative edge
        ORI;
        @(negedge clk); // Wait for a negative edge
        ANDI;
        @(negedge clk); // Wait for a negative edge

        // Test I-type shift instructions
        SLLI;
        @(negedge clk); // Wait for a negative edge
        SRLI;
        @(negedge clk); // Wait for a negative edge
        SRAI;
        @(negedge clk); // Wait for a negative edge

        // Test I-type load instructions
        LB;
        @(negedge clk); // Wait for a negative edge
        LH;
        @(negedge clk); // Wait for a negative edge
        LW;
        @(negedge clk); // Wait for a negative edge
        LBU;
        @(negedge clk); // Wait for a negative edge
        LHU;
        @(negedge clk); // Wait for a negative edge

        // Test I-type jump and system instructions
        JALR;
        @(negedge clk); // Wait for a negative edge
        ECALL;
        @(negedge clk); // Wait for a negative edge
        EBREAK;
        @(negedge clk); // Wait for a negative edge
        MRET;
        @(negedge clk); // Wait for a negative edge
        DRET;
        @(negedge clk); // Wait for a negative edge
        WFI;
        @(negedge clk); // Wait for a negative edge

        // Test I-type fence instructions
        FENCE;
        @(negedge clk); // Wait for a negative edge
        FENCEI;
        @(negedge clk); // Wait for a negative edge

        // Test I-type CSR instructions
        CSRRW;
        @(negedge clk); // Wait for a negative edge
        CSRRS;
        @(negedge clk); // Wait for a negative edge
        CSRRC;
        @(negedge clk); // Wait for a negative edge
        CSRRWI;
        @(negedge clk); // Wait for a negative edge
        CSRRSI;
        @(negedge clk); // Wait for a negative edge
        CSRRCI;
        @(negedge clk); // Wait for a negative edge

        $display("All I-type instructions tested successfully.");
    endtask

    task test_S_type;
        SB;
        @(negedge clk);
        SH;
        @(negedge clk);
        SW;
        @(negedge clk);
    endtask

    task test_SB_type;
        // Sequentially test all SB-type instructions
        BEQ;
        @(negedge clk); // Wait for a negative clock edge

        BNE;
        @(negedge clk); // Wait for a negative clock edge

        BLT;
        @(negedge clk); // Wait for a negative clock edge

        BGE;
        @(negedge clk); // Wait for a negative clock edge

        BLTU;
        @(negedge clk); // Wait for a negative clock edge

        BGEU;
        @(negedge clk); // Wait for a negative clock edge

        $display("All SB-type (Branch) instructions tested successfully.");
    endtask

    task test_U_type();
        LUI();
        @(negedge clk);
        AUIPC();
        @(negedge clk);
    endtask

    task test_UJ_type();
        JAL();
        @(negedge clk);
    endtask

    task test_RVC00_type();
        CLW;
        @(negedge clk);
        CSW;
        @(negedge clk);
        CADDI4SPN;
        @(negedge clk);
    endtask

    task test_RVC01_type();
        CNOP;
        @(negedge clk);
        CADDI;
        @(negedge clk);
        CJAL;
        @(negedge clk);
        CLI;
        @(negedge clk);
        CADDI16SP;
        @(negedge clk);
        CLUI;
        @(negedge clk);
        CSRLI;
        @(negedge clk);
        CSRAI;
        @(negedge clk);
        CANDI;
        @(negedge clk);
        CSUB;
        @(negedge clk);
        CXOR;
        @(negedge clk);
        COR;
        @(negedge clk);
        CAND;
        @(negedge clk);
        CJ;
        @(negedge clk);
        CBEQZ;
        @(negedge clk);
        CBNEZ;
        @(negedge clk);
    endtask

    task test_RVC10_type();
        CSLLI;
        @(negedge clk);
        CLWSP;
        @(negedge clk);
        CJR;
        @(negedge clk);
        CMV;
        @(negedge clk);
        CEBREAK;
        @(negedge clk);
        CJALR;
        @(negedge clk);
        CADD;
        @(negedge clk);
        CSWSP;
        @(negedge clk);
    endtask

    initial begin
        // Reset and initialize
        {rst_n, wavedrom_enable} <= '0;
        wavedrom_title <= "";

        // Testing RV32I
        wavedrom_start("1");
        test_R_type();
        test_RA_type();
        test_RM_type();
        test_I_type();
        test_S_type();
        test_SB_type();
        test_U_type();
        test_UJ_type();
        test_RVC00_type();
        test_RVC01_type();
        test_RVC10_type();
        wavedrom_stop();

        // Add more instruction tests similarly...
        Debug(1);
        @(negedge clk);
        Debug(0);
        @(negedge clk);

        NICE(0,4'd0);
        @(negedge clk);
        NICE(0,4'd1);
        @(negedge clk);
        NICE(0,4'd2);
        @(negedge clk);
        NICE(0,4'd3);
        @(negedge clk);
        NICE(1,4'd0);
        @(negedge clk);
        NICE(1,4'd1);
        @(negedge clk);
        NICE(1,4'd2);
        @(negedge clk);
        NICE(1,4'd3);
        @(negedge clk);

        // Finish simulation
        $finish;
    end
endmodule