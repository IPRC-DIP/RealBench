module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    // 输出待测模块的输入
    output mdv_nob2b,
    output muldiv_i_valid,
    output [`E203_XLEN-1:0] muldiv_i_rs1,
    output [`E203_XLEN-1:0] muldiv_i_rs2,
    output [`E203_XLEN-1:0] muldiv_i_imm,
    output [`E203_DECINFO_MULDIV_WIDTH-1:0] muldiv_i_info,
    output [`E203_ITAG_WIDTH-1:0] muldiv_i_itag,
    output flush_pulse,
    output muldiv_o_ready,
    output [`E203_MULDIV_ADDER_WIDTH - 1: 0]muldiv_req_alu_res,
    output [33-1:0] muldiv_sbf_0_r,
    output [33-1:0] muldiv_sbf_1_r,
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
    
    task base_all_low();
        mdv_nob2b = 1;
        muldiv_i_valid = '0;
        muldiv_i_rs1 = '0;
        muldiv_i_rs2 = '0;
        muldiv_i_imm = '0;
        muldiv_i_info = '0;
        muldiv_i_itag = '0;
        flush_pulse = '0;
        muldiv_o_ready = '0;
        muldiv_req_alu_res = '0;
        muldiv_sbf_0_r = '0;
        muldiv_sbf_1_r = '0;
    endtask


    task test_mul();        // 不太严谨的验证，实际应该按照正确逻辑返回，不过如果计算过程相同，就算alu_res是随机的，结果也应该正确
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_MUL] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(17)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask


    task test_div();
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_DIV] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(33)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask

    task test_mulh();
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_MULH] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(17)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask

    task test_divu();
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_DIVU] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(17)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask

    task test_rem();
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_REM] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(33)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask

    task test_remu();
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_REMU] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(33)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask

    task test_flush();
        @(negedge clk);
        base_all_low();
        muldiv_i_valid = 1;
        muldiv_i_rs1 = $random;
        muldiv_i_rs2 = $random;
        muldiv_i_imm = $random;
        muldiv_i_itag = $random;
        muldiv_i_info = '0;
        muldiv_i_info[`E203_DECINFO_MULDIV_MUL] = 1;
        muldiv_o_ready = 1;
        muldiv_req_alu_res = $random;
        muldiv_sbf_0_r = $random;
        muldiv_sbf_1_r = $random;
        flush_pulse = 0;
        repeat(6)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
        @(negedge clk);
        flush_pulse = 1;
        repeat(10)@(negedge clk)begin
            muldiv_req_alu_res = $random;
            muldiv_sbf_0_r = $random;
            muldiv_sbf_1_r = $random;
        end
    endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(0);  // 异步复位测试
        @(negedge clk);
        
        //mul
        test_mul();
        test_mulh();
        test_div();
        test_divu();
        test_rem();
        test_remu();
        test_flush();

        // 随机测试
        for(int i = 0; i < 1000; i++)begin
            wavedrom_start("Random Test");
            repeat(2) @(negedge clk);
            wavedrom_stop();
        end

        // 结束
        $finish;
    end
endmodule