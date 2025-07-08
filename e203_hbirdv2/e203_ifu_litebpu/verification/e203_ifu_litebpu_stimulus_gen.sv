module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic [31:0] pc,
output logic dec_jal,
output logic dec_jalr,
output logic dec_bxx,
output logic [31:0] dec_bjp_imm,
output logic [4:0] dec_jalr_rs1idx,
output logic oitf_empty,
output logic ir_empty,
output logic ir_rs1en,
output logic jalr_rs1idx_cam_irrdidx,
output logic dec_i_valid,
output logic ir_valid_clr,
output logic [31:0] rf2bpu_x1,
output logic [31:0] rf2bpu_rs1,
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

	task Task1();
	begin
	// Add Task1 here
		pc = 0;
		dec_jal = 0;
		dec_jalr = 0;
		dec_bxx = 0;
		dec_bjp_imm = 0;
		dec_jalr_rs1idx = 0;
		oitf_empty = 0;
		ir_empty = 0;
		ir_rs1en = 0;
		jalr_rs1idx_cam_irrdidx = 0;
		dec_i_valid = 0;
		ir_valid_clr = 0;
		rf2bpu_x1 = 0;
		rf2bpu_rs1 = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		pc = ~0;
		dec_jal = ~0;
		dec_jalr = ~0;
		dec_bxx = ~0;
		dec_bjp_imm = ~0;
		dec_jalr_rs1idx = ~0;
		oitf_empty = ~0;
		ir_empty = ~0;
		ir_rs1en = ~0;
		jalr_rs1idx_cam_irrdidx = ~0;
		dec_i_valid = ~0;
		ir_valid_clr = ~0;
		rf2bpu_x1 = ~0;
		rf2bpu_rs1 = ~0;
	end
	endtask

	task Random_Test();
	begin
		pc = $urandom;
		dec_jal = $urandom;
		dec_jalr = $urandom;
		dec_bxx = $urandom;
		dec_bjp_imm = $urandom;
		dec_jalr_rs1idx = $urandom;
		oitf_empty = $urandom;
		ir_empty = $urandom;
		ir_rs1en = $urandom;
		jalr_rs1idx_cam_irrdidx = $urandom;
		dec_i_valid = $urandom;
		ir_valid_clr = $urandom;
		rf2bpu_x1 = $urandom;
		rf2bpu_rs1 = $urandom;
	end
	endtask

    task reset_test(input async=0);
        bit arfail, srfail, datafail;
   
        @(posedge clk);
        @(posedge clk) rst_n <= 1;
        repeat(3) @(posedge clk);
   
        @(negedge clk) begin datafail = !tb_match; rst_n <= 0; end
        @(posedge clk) arfail = !tb_match;
        @(posedge clk) begin
            srfail = !tb_match;
            rst_n <= 1;
        end
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(posedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(posedge clk);
        
        // 测试任务1
        wavedrom_start("Task1");
		Task1();
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 测试任务2
        wavedrom_start("Task2");
		Task2();
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 随机测试
        for(int i = 0; i < 1000; i++)begin
            wavedrom_start("Random Test");
		Random_Test();
            repeat(3) @(posedge clk);
            wavedrom_stop();
        end

        // 结束
        $finish;
    end
endmodule