module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    output logic amo_wait,
    output logic wfi_halt_ifu_ack,
    output logic wfi_halt_exu_ack,
    output logic dbg_irq_r,
    output logic lcl_irq_r,
    output logic ext_irq_r,
    output logic sft_irq_r,
    output logic tmr_irq_r,
    output logic evt_r,
    output logic status_mie_r,
    output logic mtie_r,
    output logic msie_r,
    output logic meie_r,
    output logic alu_cmt_i_valid,
    output logic [31:0] alu_cmt_i_pc,
    output logic [31:0] alu_cmt_i_instr,
    output logic alu_cmt_i_pc_vld,
    output logic [31:0] alu_cmt_i_imm,
    output logic alu_cmt_i_rv32,
    output logic alu_cmt_i_bjp,
    output logic alu_cmt_i_wfi,
    output logic alu_cmt_i_fencei,
    output logic alu_cmt_i_mret,
    output logic alu_cmt_i_dret,
    output logic alu_cmt_i_ecall,
    output logic alu_cmt_i_ebreak,
    output logic alu_cmt_i_ifu_misalgn,
    output logic alu_cmt_i_ifu_buserr,
    output logic alu_cmt_i_ifu_ilegl,
    output logic alu_cmt_i_bjp_prdt,
    output logic alu_cmt_i_bjp_rslv,
    output logic alu_cmt_i_misalgn,
    output logic alu_cmt_i_ld,
    output logic alu_cmt_i_stamo,
    output logic alu_cmt_i_buserr,
    output logic [31:0] alu_cmt_i_badaddr,
    output logic [31:0] csr_epc_r,
    output logic [31:0] csr_dpc_r,
    output logic [31:0] csr_mtvec_r,
    output logic dbg_mode,
    output logic dbg_halt_r,
    output logic dbg_step_r,
    output logic dbg_ebreakm_r,
    output logic oitf_empty,
    output logic u_mode,
    output logic s_mode,
    output logic h_mode,
    output logic m_mode,
    output logic longp_excp_i_valid,
    output logic longp_excp_i_ld,
    output logic longp_excp_i_st,
    output logic longp_excp_i_buserr,
    output logic [31:0] longp_excp_i_badaddr,
    output logic longp_excp_i_insterr,
    output logic [31:0] longp_excp_i_pc,
    output logic pipe_flush_ack,
    output logic [511:0] wavedrom_title,
    output logic wavedrom_enable
);

    task wavedrom_start(input[511:0] title = "");
        wavedrom_title <= title;
        wavedrom_enable <= 1;
    endtask

    task wavedrom_stop;
        wavedrom_enable <= 0;
    endtask

    task base_all_random();
            // 随机化基本输入信号
            amo_wait = $random;
            wfi_halt_ifu_ack = $random;
            wfi_halt_exu_ack = $random;
            dbg_irq_r = $random;
            lcl_irq_r = $random;
            ext_irq_r = $random;
            sft_irq_r = $random;
            tmr_irq_r = $random;
            evt_r = $random;
            status_mie_r = $random;
            mtie_r = $random;
            msie_r = $random;
            meie_r = $random;

            // 随机化 ALU 提交信号
            alu_cmt_i_valid = $random;
            alu_cmt_i_pc = $random;
            alu_cmt_i_instr = $random;
            alu_cmt_i_pc_vld = $random;
            alu_cmt_i_imm = $random;
            alu_cmt_i_rv32 = $random;
            alu_cmt_i_bjp = $random;
            alu_cmt_i_wfi = $random;
            alu_cmt_i_fencei = $random;
            alu_cmt_i_mret = $random;
            alu_cmt_i_dret = $random;
            alu_cmt_i_ecall = $random;
            alu_cmt_i_ebreak = $random;
            alu_cmt_i_ifu_misalgn = $random;
            alu_cmt_i_ifu_buserr = $random;
            alu_cmt_i_ifu_ilegl = $random;
            alu_cmt_i_bjp_prdt = $random;
            alu_cmt_i_bjp_rslv = $random;
            alu_cmt_i_misalgn = $random;
            alu_cmt_i_ld = $random;
            alu_cmt_i_stamo = $random;
            alu_cmt_i_buserr = $random;
            alu_cmt_i_badaddr = $random;

            // 随机化 CSR 寄存器
            csr_epc_r = $random;
            csr_dpc_r = $random;
            csr_mtvec_r = $random;

            // 随机化调试相关信号
            dbg_mode = $random;
            dbg_halt_r = $random;
            dbg_step_r = $random;
            dbg_ebreakm_r = $random;

            // 随机化 OITF 和模式信号
            oitf_empty = $random;
            u_mode = $random;
            s_mode = $random;
            h_mode = $random;
            m_mode = $random;

            // 随机化长流水异常信号
            longp_excp_i_valid = $random;
            longp_excp_i_ld = $random;
            longp_excp_i_st = $random;
            longp_excp_i_buserr = $random;
            longp_excp_i_badaddr = $random;
            longp_excp_i_insterr = $random;
            longp_excp_i_pc = $random;

            // 随机化流水线刷新确认信号
            pipe_flush_ack = $random;
    endtask

    task base_all_low();
            amo_wait = '0;
            wfi_halt_ifu_ack = '0;
            wfi_halt_exu_ack = '0;
            dbg_irq_r = '0;
            lcl_irq_r = '0;
            ext_irq_r = '0;
            sft_irq_r = '0;
            tmr_irq_r = '0;
            evt_r = '0;
            status_mie_r = '0;
            mtie_r = '0;
            msie_r = '0;
            meie_r = '0;

            // 随机化 ALU 提交信号
            alu_cmt_i_valid = '0;
            alu_cmt_i_pc = '0;
            alu_cmt_i_instr = '0;
            alu_cmt_i_pc_vld = '0;
            alu_cmt_i_imm = '0;
            alu_cmt_i_rv32 = '0;
            alu_cmt_i_bjp = '0;
            alu_cmt_i_wfi = '0;
            alu_cmt_i_fencei = '0;
            alu_cmt_i_mret = '0;
            alu_cmt_i_dret = '0;
            alu_cmt_i_ecall = '0;
            alu_cmt_i_ebreak = '0;
            alu_cmt_i_ifu_misalgn = '0;
            alu_cmt_i_ifu_buserr = '0;
            alu_cmt_i_ifu_ilegl = '0;
            alu_cmt_i_bjp_prdt = '0;
            alu_cmt_i_bjp_rslv = '0;
            alu_cmt_i_misalgn = '0;
            alu_cmt_i_ld = '0;
            alu_cmt_i_stamo = '0;
            alu_cmt_i_buserr = '0;
            alu_cmt_i_badaddr = '0;

            // 随机化 CSR 寄存器
            csr_epc_r = $random;
            csr_dpc_r = $random;
            csr_mtvec_r = $random;

            // 随机化调试相关信号
            dbg_mode = '0;
            dbg_halt_r = '0;
            dbg_step_r = '0;
            dbg_ebreakm_r = '0;

            // 随机化 OITF 和模式信号
            oitf_empty = '0;
            u_mode = '0;
            s_mode = '0;
            h_mode = '0;
            m_mode = '0;

            // 随机化长流水异常信号
            longp_excp_i_valid = '0;
            longp_excp_i_ld = '0;
            longp_excp_i_st = '0;
            longp_excp_i_buserr = '0;
            longp_excp_i_badaddr = '0;
            longp_excp_i_insterr = '0;
            longp_excp_i_pc = '0;

            // 随机化流水线刷新确认信号
            pipe_flush_ack = '0;
    endtask

    task reset_test(input async=0);
        bit arfail, srfail;

        // 复位信号拉高
        rst_n = 1;
        if (async == 1)begin
            // 异步复位测试
            @(negedge clk);
            rst_n = 0;
            #1;
            arfail = !tb_match;
            rst_n = 1;
            if (arfail)
                $display("Error: Asynchronous reset failed. Ensure your design resets immediately when rst_n is asserted.");
            else
                $display("Info: Asynchronous reset succeed.");
        end
        else begin
            // 同步复位测试
            @(negedge clk); rst_n = 0;
            @(negedge clk); srfail = !tb_match;
            @(negedge clk); rst_n = 1;
            if (srfail)
                $display("Error: Synchronous reset failed. Check if your design resets on the clock edge.");
            else 
                $display("Info: Synchronous reset succeed.");
        end
    endtask

    
    task test_exception_handling();
        begin
            @(negedge clk);
            base_all_random();
            alu_cmt_i_valid = 1'b1;
            alu_cmt_i_misalgn = 1'b1;  // 测试对齐异常
            alu_cmt_i_pc = $random; // 设置异常发生的PC地址
            alu_cmt_i_badaddr = $random; // 设置异常的地址
            alu_cmt_i_instr = $random; // 示例指令
        end
    endtask

    task test_branch_prediction();
        begin
            @(negedge clk);
            base_all_random();
            alu_cmt_i_valid = 1'b1;
            alu_cmt_i_bjp = 1'b1; // 分支指令
            alu_cmt_i_bjp_prdt = 1'b1; // 预测为跳转
            alu_cmt_i_bjp_rslv = 1'b0; // 实际未跳转
        end
    endtask

    task test_wfi_handling();
    begin
        @(negedge clk);
        base_all_random();
        alu_cmt_i_valid = 1'b1;
        alu_cmt_i_wfi = 1'b1; // WFI 指令
        wfi_halt_ifu_ack = 1'b1;
        wfi_halt_exu_ack = 1'b1;

    end
    endtask

    task test_pipeline_flush();
        begin
            @(negedge clk);
            base_all_random();
            alu_cmt_i_valid = 1'b1;
            alu_cmt_i_ecall = 1'b1; // 测试 ECALL 异常
            pipe_flush_ack = 1;
            @(negedge clk);
            
        end
    endtask

    task test_instruction_commit();
        begin
            base_all_random();
            alu_cmt_i_valid = 1'b1;
            alu_cmt_i_bjp = 1'b0;   // 非分支指令
            @(negedge clk);
        end
    endtask

    task test_debug_and_interrupt_handling();
        begin
            @(negedge clk);
            base_all_random();
            dbg_mode = 1'b1; // 进入调试模式
            dbg_irq_r = 1'b1; // 调试中断请求
            ext_irq_r = 1'b1; // 外部中断请求
            status_mie_r = 1'b1; // 全局中断使能
            @(negedge clk);
        end
    endtask

    task test_random1();
        @(negedge clk);
        base_all_low();
        alu_cmt_i_valid = 1;
        alu_cmt_i_pc = $random;
        alu_cmt_i_instr = $random;
        alu_cmt_i_pc_vld = $random;
        alu_cmt_i_imm = $random;
        alu_cmt_i_rv32 = $random;
        pipe_flush_ack = 1'b1;
        case ($random % 13)
            32'd0: begin alu_cmt_i_bjp = 1; alu_cmt_i_bjp_prdt = 1; alu_cmt_i_bjp_rslv = 1;end
            32'd1: alu_cmt_i_wfi = 1;
            32'd2: alu_cmt_i_fencei = 1;
            32'd3: alu_cmt_i_mret = 1;
            32'd4: alu_cmt_i_dret = 1;
            32'd5: alu_cmt_i_ecall = 1;
            32'd6: alu_cmt_i_ebreak = 1;
            32'd7: alu_cmt_i_ifu_misalgn = 1;
            32'd8: alu_cmt_i_ifu_buserr = 1;
            32'd9: alu_cmt_i_ifu_ilegl = 1;
            32'd10: begin alu_cmt_i_bjp = 1; alu_cmt_i_bjp_prdt = 0; alu_cmt_i_bjp_rslv = 1;end
            32'd11: begin
                alu_cmt_i_badaddr = $random;
                alu_cmt_i_misalgn = 1;
                alu_cmt_i_ld = $random;
                alu_cmt_i_stamo = ~alu_cmt_i_ld;
            end
            32'd12:begin
                alu_cmt_i_badaddr = $random;
                alu_cmt_i_buserr = 1;
                alu_cmt_i_ld = $random;
                alu_cmt_i_stamo = ~alu_cmt_i_ld;
            end
        endcase
    endtask

    task test_random2();
        @(negedge clk);
        base_all_low();
        longp_excp_i_valid = 1;
        longp_excp_i_pc = $random;
        pipe_flush_ack = 1'b1;
        case ($random % 3)
            32'd0:begin
                longp_excp_i_ld = $random;
                longp_excp_i_st = ~longp_excp_i_ld;
                longp_excp_i_buserr = 1;
            end 
            32'd1:begin
                longp_excp_i_ld = $random;
                longp_excp_i_st = ~longp_excp_i_ld;
                longp_excp_i_badaddr = 1;
            end
            32'd2:begin
                longp_excp_i_ld = $random;
                longp_excp_i_st = ~longp_excp_i_ld;
                longp_excp_i_insterr = 1;
            end
        endcase
    endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(negedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(negedge clk);
        
        // 测试任务1
        test_branch_prediction();
        test_debug_and_interrupt_handling();
        test_exception_handling();
        test_instruction_commit();
        test_pipeline_flush();
        test_wfi_handling();
        for(int i = 0; i < 2000; i++)begin
            test_random1();
        end
        for(int i = 0; i < 2000; i++)begin
            test_random2();
        end
        // 结束
        $finish;
    end
endmodule