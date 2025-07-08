`include "e203_defines.v"
module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    output logic csr_i_valid,
    output logic [31:0] csr_i_rs1,
    output logic [25:0] csr_i_info,
    output logic csr_i_rdwen,
    output logic csr_access_ilgl,
    output logic [31:0] read_csr_dat,
    output logic csr_o_ready,
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

	task base_all_low();
	// Add Task1 here
		csr_i_valid = 0;
		csr_i_rs1 = 0;
		csr_i_info = 0;
		csr_i_rdwen = 0;
		csr_access_ilgl = 0;
		read_csr_dat = 0;
		csr_o_ready = 0;
        `ifdef E203_HAS_CSR_NICE
        nice_xs_off = 0;
        nice_csr_ready = 0;
        nice_csr_rdata = 0;
        `endif
	endtask

	task base_all_high();
	// Add Task2 here
		csr_i_valid = ~0;
		csr_i_rs1 = ~0;
		csr_i_info = ~0;
		csr_i_rdwen = ~0;
		csr_access_ilgl = ~0;
		read_csr_dat = ~0;
		csr_o_ready = ~0;
        `ifdef E203_HAS_CSR_NICE
        nice_xs_off = ~'0;
        nice_csr_ready = ~'0;
        nice_csr_rdata = ~'0;
        `endif
	endtask

	task base_all_random();
		csr_i_valid = $urandom;
		csr_i_rs1 = $urandom;
		csr_i_info = $urandom;
		csr_i_rdwen = $urandom;
		csr_access_ilgl = $urandom;
		read_csr_dat = $urandom;
		csr_o_ready = $urandom;
        `ifdef E203_HAS_CSR_NICE
        nice_xs_off = $random;
        nice_csr_ready = $random;
        nice_csr_rdata = $random;
        `endif
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

    task set_validready(input i_valid,input o_ready
        `ifdef E203_HAS_CSR_NICE
        ,input csr_ready
        `endif
        );
        csr_i_valid = i_valid;
        csr_o_ready = o_ready;
        `ifdef E203_HAS_CSR_NICE
        nice_csr_ready = csr_ready;
        `endif
    endtask

    task set_random_input();
        csr_i_rs1 = $random;
		csr_i_rdwen = $random;
		csr_access_ilgl = $random;
		read_csr_dat = $random;
        `ifdef E203_HAS_CSR_NICE
        nice_xs_off = $random;
        nice_csr_rdata = $random;
        `endif
    endtask

    task test_csr_rd_en();              // csr_rd_en
        @(negedge clk);                     // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 1;
        csr_i_info[`E203_DECINFO_CSR_CSRRW ] = ~'0;

        @(negedge clk);                     // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 0;
        csr_i_info[`E203_DECINFO_CSR_CSRRS ] = ~'0;

        @(negedge clk);                     // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 0;
        csr_i_info[`E203_DECINFO_CSR_CSRRC ] = ~'0;

        @(negedge clk);                     // false csr_i_valid = 0
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(0,1,1);
        `else
            set_validready(0,1);
        `endif
        set_random_input();
        csr_i_info[`E203_DECINFO_CSR_CSRRS ] = ~'0;

        @(negedge clk);                     // false csr_i_rdwen = 0
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 0;
        csr_i_info[`E203_DECINFO_CSR_CSRRW ] = ~'0;
    endtask

    task test_wr_en();
        @(negedge clk);                     // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_info[`E203_DECINFO_CSR_CSRRW ] = ~'0;

        @(negedge clk);                     // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_info[`E203_DECINFO_CSR_CSRRS ] = ~'0;
        csr_i_info[`E203_DECINFO_CSR_RS1IS0] = '0;

        @(negedge clk);                     // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 0;
        csr_i_info[`E203_DECINFO_CSR_CSRRC ] = ~'0;
        csr_i_info[`E203_DECINFO_CSR_RS1IS0] = '0;

        @(negedge clk);                     // false csr_i_valid = 0
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(0,1,1);
        `else
            set_validready(0,1);
        `endif
        set_random_input();
        csr_i_info[`E203_DECINFO_CSR_CSRRW ] = ~'0;

        @(negedge clk);                     // false rs1is0 = 1
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 0;
        
        csr_i_info[`E203_DECINFO_CSR_CSRRS ] = ~'0;
        csr_i_info[`E203_DECINFO_CSR_RS1IS0 ] = ~'0;

        @(negedge clk);                     // false rs1is0 = 1
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
        set_random_input();
        csr_i_rdwen = 0;
        
        csr_i_info[`E203_DECINFO_CSR_CSRRC ] = ~'0;
        csr_i_info[`E203_DECINFO_CSR_RS1IS0 ] = ~'0;
    endtask

    task test_csr_ena();
        @(negedge clk);             // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            csr_idx[11:8] = 4'hE;
            nice_xs_off = 1;
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif

        @(negedge clk);             // true
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            csr_idx[11:8] = 4'hA;
            nice_xs_off = 0;
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif

        @(negedge clk);             // false csr_o_valid(csr_i_valid)
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            csr_idx[11:8] = 4'hA;
            nice_xs_off = 0;
            set_validready(0,1,1);
        `else
            set_validready(0,1);
        `endif

        @(negedge clk);             // false csr_o_ready
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            csr_idx[11:8] = 4'hA;
            nice_xs_off = 0;
            set_validready(1,0,1);
        `else
            set_validready(1,0);
        `endif

        @(negedge clk);             // false sel_nice = 1
        base_all_low();
        `ifdef E203_HAS_CSR_NICE
            csr_idx[11:8] = 4'hE;
            nice_xs_off = 0;
            set_validready(1,1,1);
        `else
            set_validready(1,1);
        `endif
    endtask

    task test_wbck_csr_dat();
        @(negedge clk);
        base_all_low();
        csr_i_info[`E203_DECINFO_CSR_CSRRW ] = 1;
        csr_i_info[`E203_DECINFO_CSR_RS1IMM ] = 1;
        csr_i_info[`E203_DECINFO_CSR_ZIMMM ] = $random;
        csr_i_rs1 = ~csr_i_info[`E203_DECINFO_CSR_ZIMMM ];

        @(negedge clk);
        base_all_low();
        csr_i_info[`E203_DECINFO_CSR_CSRRW ] = 1;
        csr_i_info[`E203_DECINFO_CSR_RS1IMM ] = 0;
        csr_i_info[`E203_DECINFO_CSR_ZIMMM ] = $random;
        csr_i_rs1 = ~csr_i_info[`E203_DECINFO_CSR_ZIMMM ];

        @(negedge clk);
        base_all_low();
        csr_i_info[`E203_DECINFO_CSR_CSRRS ] = 1;
        csr_i_info[`E203_DECINFO_CSR_RS1IMM ] = 0;
        csr_i_info[`E203_DECINFO_CSR_ZIMMM ] = $random;
        csr_i_rs1 = ~csr_i_info[`E203_DECINFO_CSR_ZIMMM ];
        read_csr_dat = $random;

        @(negedge clk);
        base_all_low();
        csr_i_info[`E203_DECINFO_CSR_CSRRC ] = 1;
        csr_i_info[`E203_DECINFO_CSR_RS1IMM ] = 0;
        csr_i_info[`E203_DECINFO_CSR_ZIMMM ] = $random;
        csr_i_rs1 = ~csr_i_info[`E203_DECINFO_CSR_ZIMMM ];
        read_csr_dat = $random;
    endtask

    `ifdef E203_HAS_CSR_NICE        // 
    task test_nice();               // TODO:实际上还没有配置nice_CSR，如果后续使用NICE_CSR，待完善
        // csr_sel_nice 
        @(negedge clk);
        base_all_low();
        csr_idx[11:8] == 4'hE;

        // csr_o_valid
        @(negedge clk);
        base_all_low();
        csr_idx[11:8] == 4'hE;
        nice_xs_off = 0;
        nice_csr_ready = 1;
        csr_i_valid = 1;

        // nice_csr_valid
        @(negedge clk);
        base_all_low();
        csr_idx[11:8] == 4'hE;
        nice_xs_off = 0;
        nice_csr_ready = 1;
        csr_i_valid = 1;
        csr_o_ready = 1;

        // csr_i_ready
    endtask
    `endif

    initial begin
        // 初始化
        base_all_low();
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(1);  // 异步复位测试
        @(negedge clk);
        
        // 测试任务1
        wavedrom_start("Task1");
		test_csr_rd_en();
        test_wr_en();
        test_csr_ena();
        test_wbck_csr_dat();
        `ifdef E203_HAS_CSR_NICE
        test_nice();
        `endif
        @(negedge clk);

        // 结束
        $finish;
    end
endmodule