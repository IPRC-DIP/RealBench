module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
	output logic nonflush_cmt_ena,
	output logic csr_ena,
	output logic csr_wr_en,
	output logic csr_rd_en,
	output logic [11:0] csr_idx,
	output logic [31:0] wbck_csr_dat,
	output logic core_mhartid,
	output logic ext_irq_r,
	output logic sft_irq_r,
	output logic tmr_irq_r,
	output logic [31:0] dcsr_r,
	output logic [31:0] dpc_r,
	output logic [31:0] dscratch_r,
	output logic dbg_mode,
	output logic dbg_stopcycle,
	output logic [31:0] cmt_badaddr,
	output logic cmt_badaddr_ena,
	output logic [31:0] cmt_epc,
	output logic cmt_epc_ena,
	output logic [31:0] cmt_cause,
	output logic cmt_cause_ena,
	output logic cmt_status_ena,
	output logic cmt_instret_ena,
	output logic cmt_mret_ena,
	output logic clk_aon,
	output logic csr_access_ilgl,
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
		nonflush_cmt_ena = 0;
		csr_ena = 0;
		csr_wr_en = 0;
		csr_rd_en = 0;
		csr_idx = 0;
		wbck_csr_dat = 0;
		core_mhartid = 0;
		ext_irq_r = 0;
		sft_irq_r = 0;
		tmr_irq_r = 0;
		dcsr_r = 0;
		dpc_r = 0;
		dscratch_r = 0;
		dbg_mode = 0;
		dbg_stopcycle = 0;
		cmt_badaddr = 0;
		cmt_badaddr_ena = 0;
		cmt_epc = 0;
		cmt_epc_ena = 0;
		cmt_cause = 0;
		cmt_cause_ena = 0;
		cmt_status_ena = 0;
		cmt_instret_ena = 0;
		cmt_mret_ena = 0;
		clk_aon = clk;
	endtask

	task base_all_high();
		nonflush_cmt_ena = ~0;
		csr_ena = ~0;
		csr_wr_en = ~0;
		csr_rd_en = ~0;
		csr_idx = ~0;
		wbck_csr_dat = ~0;
		core_mhartid = ~0;
		ext_irq_r = ~0;
		sft_irq_r = ~0;
		tmr_irq_r = ~0;
		dcsr_r = ~0;
		dpc_r = ~0;
		dscratch_r = ~0;
		dbg_mode = ~0;
		dbg_stopcycle = ~0;
		cmt_badaddr = ~0;
		cmt_badaddr_ena = ~0;
		cmt_epc = ~0;
		cmt_epc_ena = ~0;
		cmt_cause = ~0;
		cmt_cause_ena = ~0;
		cmt_status_ena = ~0;
		cmt_instret_ena = ~0;
		cmt_mret_ena = ~0;
		clk_aon = clk;
	endtask

	task base_all_random();
		nonflush_cmt_ena = $urandom;
		csr_ena = $urandom;
		csr_wr_en = $urandom;
		csr_rd_en = $urandom;
		csr_idx = $urandom;
		wbck_csr_dat = $urandom;
		core_mhartid = $urandom;
		ext_irq_r = $urandom;
		sft_irq_r = $urandom;
		tmr_irq_r = $urandom;
		dcsr_r = $urandom;
		dpc_r = $urandom;
		dscratch_r = $urandom;
		dbg_mode = $urandom;
		dbg_stopcycle = $urandom;
		cmt_badaddr = $urandom;
		cmt_badaddr_ena = $urandom;
		cmt_epc = $urandom;
		cmt_epc_ena = $urandom;
		cmt_cause = $urandom;
		cmt_cause_ena = $urandom;
		cmt_status_ena = $urandom;
		cmt_instret_ena = $urandom;
		cmt_mret_ena = $urandom;
		clk_aon = clk;
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

	task part_wbck_csr_wen(input r);
		if(r==1)begin
			csr_wr_en = 1;
			csr_ena = 1;
			csr_access_ilgl = 0;
		end
		else begin
			case ($random & 2'b11)
				2'b00:begin
					csr_wr_en = 0;
					csr_ena = 1;
				end 
				2'b01:begin
					csr_wr_en = 1;
					csr_ena = 0;
				end 
				2'b10:begin
					csr_wr_en = 0;
					csr_ena = 0;
				end 
			endcase
		end
	endtask

	task part_read_csr_ena(input r);
		if (r == 1) begin
			csr_rd_en = 1;
			csr_ena = 1;
		end else begin
			case ($random & 2'b11)
				2'b00: begin
					csr_rd_en = 0;
					csr_ena = 1;
				end
				2'b01: begin
					csr_rd_en = 1;
					csr_ena = 0;
				end
				2'b10: begin
					csr_rd_en = 0;
					csr_ena = 0;
				end
			endcase
		end
	endtask

	task test_write();
	// MPIE 0x300
		@(negedge clk);		// MPIE	write_mstatus 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[7] = 1;
		@(negedge clk);		// MPIE	write_mstatus 0
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[7] = 0;

		@(negedge clk);		// MIE	write_mstatus 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[3] = 1;
		@(negedge clk);		// MPIE	cmt_status_ena 1
		base_all_low();
		cmt_status_ena = 1;
		@(negedge clk);		// MIE	write_mstatus 0
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[3] = 0;
		@(negedge clk);		// MPIE	cmt_status_ena 0
		base_all_low();
		cmt_status_ena = 1;

		@(negedge clk);		// MPIE cmt_mret_ena
		base_all_low();
		cmt_mret_ena = 1;

	// MIE 0x300
		@(negedge clk);		// MIE write_mstatus 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[3] = 1;
		@(negedge clk);		// MIE write_mstatus 0
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[3] = 0;

		@(negedge clk);		// MIE cmt_status_ena
		base_all_low();
		cmt_status_ena = 1;

		@(negedge clk);		// MPIE	write_mstatus 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[7] = 1;
		@(negedge clk);		// MIE cmt_mret_ena 1
		base_all_low();
		cmt_mret_ena = 1;
		@(negedge clk);		// MPIE	write_mstatus 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h300;
		wbck_csr_dat[7] = 0;
		@(negedge clk);		// MIE cmt_mret_ena 1
		base_all_low();
		cmt_mret_ena = 1;

	// MIE 0x304
		@(negedge clk);		// MIE write 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h304;
		wbck_csr_dat[11] = 1;
		wbck_csr_dat[7] = 1;
		wbck_csr_dat[3] = 1;
		@(negedge clk);		// MIE write 0
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h304;
		wbck_csr_dat[11] = 0;
		wbck_csr_dat[7] = 0;
		wbck_csr_dat[3] = 0;
		
	// MIP 0x344
		@(negedge clk);		// MIP write 1
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h344;
		wbck_csr_dat[11] = 1;
		wbck_csr_dat[7] = 1;
		wbck_csr_dat[3] = 1;

		@(negedge clk);		// MIP write 0
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h344;
		wbck_csr_dat[11] = 0;
		wbck_csr_dat[7] = 0;
		wbck_csr_dat[3] = 0;

	// mtvec 0x305
		@(negedge clk);		// mtvec 
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h305;
		wbck_csr_dat = $random;

	// mscratch 
		@(negedge clk);		// mscratch
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h340;
		wbck_csr_dat = $random;

	// mcycle 0xb00
		@(negedge clk);		// mcycle
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hB00;
		wbck_csr_dat = $random;

	// mcycleh 0xb02
		@(negedge clk);		// mcycleh
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hB02;
		wbck_csr_dat = $random;

	// minstret 0xb80
		@(negedge clk);		// minstret
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hB80;
		wbck_csr_dat = $random;

	// minstreth 0xb82
		@(negedge clk);		// minstreth
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hB82;
		wbck_csr_dat = $random;

	// counterstop 0xbff
		@(negedge clk);		
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hBFF;
		wbck_csr_dat = $random;

	// mcgstop 0xbfe
		@(negedge clk);		
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hBFE;
		wbck_csr_dat[1:0] = 2'b11;

	// itcmnohold 0xbfd
		@(negedge clk);	
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hBFD;
		wbck_csr_dat[0] = 1;

	// mdvnob2b	0xbf0
		@(negedge clk);		
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hBF0;
		wbck_csr_dat[0] = 1;

	// 测试counter stop作用
		@(negedge clk);		
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hBFF;
		wbck_csr_dat[2:0] = 3'b000;
		cmt_instret_ena = 1;
		@(negedge clk);		
		base_all_low();
		cmt_instret_ena = 1;
		repeat(10)@(negedge clk);
		@(negedge clk);		
		base_all_low();
		cmt_instret_ena = 1;
		part_wbck_csr_wen(1);
		csr_idx = 12'hBFF;
		wbck_csr_dat[2:0] = 3'b111;

	// 测试dbg_stopcycle 
		@(negedge clk);		
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'hBFF;
		wbck_csr_dat[2:0] = 3'b000;
		cmt_instret_ena = 1;
		@(negedge clk);		
		base_all_low();
		cmt_instret_ena = 1;
		repeat(10)@(negedge clk);
		@(negedge clk);		
		base_all_low();
		cmt_instret_ena = 1;
		dbg_stopcycle = 1;
		dbg_mode = 1;

	// mepc
		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h341;
		wbck_csr_dat = $random;

		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(0);
		cmt_epc_ena = 1;
		cmt_epc = $random;

	//mcause
		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h342;
		wbck_csr_dat[31] = 1'b1;
		wbck_csr_dat[3:0] = 4'b1111;

		@(negedge clk);
		base_all_low();
		cmt_cause_ena = 1;
		cmt_cause[31] = 0;
		cmt_cause[3:0] = $random;

	// mbadaddr
		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h343;
		wbck_csr_dat = $random;

		@(negedge clk);
		base_all_low();
		cmt_badaddr_ena = 1;
		cmt_badaddr = $random;
		
	// dcsr
		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h7b0;
		dbg_mode = 1;

		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h7b1;
		dbg_mode = 1;

		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h7b2;
		dbg_mode = 1;

		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h7b0;
		dbg_mode = 0;

		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h7b1;
		dbg_mode = 0;

		@(negedge clk);
		base_all_low();
		part_wbck_csr_wen(1);
		csr_idx = 12'h7b2;
		dbg_mode = 0;
	endtask
		
	task test_read();
        @(negedge clk);
        base_all_low();             // 重置所有控制信号
        part_read_csr_ena(1);       // 启用 CSR 读取信号

        // Read ustatus (0x000)
        csr_idx = 12'h000;
        @(negedge clk);

        // Read mstatus (0x300)
        csr_idx = 12'h300;
        @(negedge clk);

        // Read misa (0x301)
        csr_idx = 12'h301;
        @(negedge clk);

        // Read mie (0x304)
        csr_idx = 12'h304;
        @(negedge clk);

        // Read mtvec (0x305)
        csr_idx = 12'h305;
        @(negedge clk);

        // Read mscratch (0x340)
        csr_idx = 12'h340;
        @(negedge clk);

        // Read mepc (0x341)
        csr_idx = 12'h341;
        @(negedge clk);

        // Read mcause (0x342)
        csr_idx = 12'h342;
        @(negedge clk);

        // Read mtval (0x343)
        csr_idx = 12'h343;
        @(negedge clk);

        // Read mip (0x344)
        csr_idx = 12'h344;
        @(negedge clk);

        // Read mcycle (0xB00)
        csr_idx = 12'hB00;
        @(negedge clk);

        // Read mcycleh (0xB80)
        csr_idx = 12'hB80;
        @(negedge clk);

        // Read minstret (0xB02)
        csr_idx = 12'hB02;
        @(negedge clk);

        // Read minstreth (0xB82)
        csr_idx = 12'hB82;
        @(negedge clk);

        // Read mvendorid (0xF11)
        csr_idx = 12'hF11;
        @(negedge clk);

        // Read marchid (0xF12)
        csr_idx = 12'hF12;
        @(negedge clk);

        // Read mimpid (0xF13)
        csr_idx = 12'hF13;
        @(negedge clk);

        // Read mhartid (0xF14)
        csr_idx = 12'hF14;
        @(negedge clk);

        // Read mtime (N/A, external CSR-like register)
        csr_idx = 12'hC00;  // Assuming 0xC00 for mtime, adjust as needed
        @(negedge clk);

        // Read mtimecmp (N/A, external CSR-like register)
        csr_idx = 12'hC01;  // Assuming 0xC01 for mtimecmp, adjust as needed
        @(negedge clk);

        // Read msip (N/A, external CSR-like register)
        csr_idx = 12'hC02;  // Assuming 0xC02 for msip, adjust as needed
        @(negedge clk);

        // Disable CSR read signal after all tests
        part_read_csr_ena(0);
	endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
		reset_test(0);
		@(negedge clk);
		reset_test(1);
		@(negedge clk);
		
		test_write();
		test_read();

        // 结束
        $finish;
    end
endmodule