module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic [31:0] pc_rtvec,
output logic ifu_req_ready,
output logic ifu_rsp_valid,
output logic ifu_rsp_err,
output logic [31:0] ifu_rsp_instr,
output logic ifu_o_ready,
output logic pipe_flush_req,
output logic [31:0] pipe_flush_add_op1,
output logic [31:0] pipe_flush_add_op2,
output logic [31:0] pipe_flush_pc,
output logic ifu_halt_req,
output logic oitf_empty,
output logic [31:0] rf2ifu_x1,
output logic [31:0] rf2ifu_rs1,
output logic dec2ifu_rs1en,
output logic dec2ifu_rden,
output logic [4:0] dec2ifu_rdidx,
output logic dec2ifu_mulhsu,
output logic dec2ifu_div,
output logic dec2ifu_rem,
output logic dec2ifu_divu,
output logic dec2ifu_remu,
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
		pc_rtvec = 0;
		ifu_req_ready = 0;
		ifu_rsp_valid = 0;
		ifu_rsp_err = 0;
		ifu_rsp_instr = 0;
		ifu_o_ready = 0;
		pipe_flush_req = 0;
		pipe_flush_add_op1 = 0;
		pipe_flush_add_op2 = 0;
		pipe_flush_pc = 0;
		ifu_halt_req = 0;
		oitf_empty = 0;
		rf2ifu_x1 = 0;
		rf2ifu_rs1 = 0;
		dec2ifu_rs1en = 0;
		dec2ifu_rden = 0;
		dec2ifu_rdidx = 0;
		dec2ifu_mulhsu = 0;
		dec2ifu_div = 0;
		dec2ifu_rem = 0;
		dec2ifu_divu = 0;
		dec2ifu_remu = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		pc_rtvec = ~0;
		ifu_req_ready = ~0;
		ifu_rsp_valid = ~0;
		ifu_rsp_err = ~0;
		ifu_rsp_instr = ~0;
		ifu_o_ready = ~0;
		pipe_flush_req = ~0;
		pipe_flush_add_op1 = ~0;
		pipe_flush_add_op2 = ~0;
		pipe_flush_pc = ~0;
		ifu_halt_req = ~0;
		oitf_empty = ~0;
		rf2ifu_x1 = ~0;
		rf2ifu_rs1 = ~0;
		dec2ifu_rs1en = ~0;
		dec2ifu_rden = ~0;
		dec2ifu_rdidx = ~0;
		dec2ifu_mulhsu = ~0;
		dec2ifu_div = ~0;
		dec2ifu_rem = ~0;
		dec2ifu_divu = ~0;
		dec2ifu_remu = ~0;
	end
	endtask

	task Random_Test();
	begin
		pc_rtvec = $urandom;
		ifu_req_ready = $urandom;
		ifu_rsp_valid = $urandom;
		ifu_rsp_err = $urandom;
		ifu_rsp_instr = $urandom;
		ifu_o_ready = $urandom;
		pipe_flush_req = $urandom;
		pipe_flush_add_op1 = $urandom;
		pipe_flush_add_op2 = $urandom;
		pipe_flush_pc = $urandom;
		ifu_halt_req = $urandom;
		oitf_empty = $urandom;
		rf2ifu_x1 = $urandom;
		rf2ifu_rs1 = $urandom;
		dec2ifu_rs1en = $urandom;
		dec2ifu_rden = $urandom;
		dec2ifu_rdidx = $urandom;
		dec2ifu_mulhsu = $urandom;
		dec2ifu_div = $urandom;
		dec2ifu_rem = $urandom;
		dec2ifu_divu = $urandom;
		dec2ifu_remu = $urandom;
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
        for(int i = 0; i < 100; i++)begin
            wavedrom_start("Random Test");
		Random_Test();
            repeat(2) @(posedge clk);
            wavedrom_stop();
        end

        // 结束
        $finish;
    end
endmodule