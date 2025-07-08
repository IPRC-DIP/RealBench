module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic agu_i_valid,
output logic [31:0] agu_i_rs1,
output logic [31:0] agu_i_rs2,
output logic [31:0] agu_i_imm,
output logic [20:0] agu_i_info,
output logic agu_i_itag,
output logic flush_req,
output logic flush_pulse,
output logic oitf_empty,
output logic agu_o_ready,
output logic agu_icb_cmd_ready,
output logic agu_icb_rsp_valid,
output logic agu_icb_rsp_err,
output logic agu_icb_rsp_excl_ok,
output logic [31:0] agu_icb_rsp_rdata,
output logic [31:0] agu_req_alu_res,
output logic [31:0] agu_sbf_0_r,
output logic [31:0] agu_sbf_1_r,
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
		agu_i_valid = 0;
		agu_i_rs1 = 0;
		agu_i_rs2 = 0;
		agu_i_imm = 0;
		agu_i_info = 0;
		agu_i_itag = 0;
		flush_req = 0;
		flush_pulse = 0;
		oitf_empty = 0;
		agu_o_ready = 0;
		agu_icb_cmd_ready = 0;
		agu_icb_rsp_valid = 0;
		agu_icb_rsp_err = 0;
		agu_icb_rsp_excl_ok = 0;
		agu_icb_rsp_rdata = 0;
		agu_req_alu_res = 0;
		agu_sbf_0_r = 0;
		agu_sbf_1_r = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		agu_i_valid = ~0;
		agu_i_rs1 = ~0;
		agu_i_rs2 = ~0;
		agu_i_imm = ~0;
		agu_i_info = ~0;
		agu_i_itag = ~0;
		flush_req = ~0;
		flush_pulse = ~0;
		oitf_empty = ~0;
		agu_o_ready = ~0;
		agu_icb_cmd_ready = ~0;
		agu_icb_rsp_valid = ~0;
		agu_icb_rsp_err = ~0;
		agu_icb_rsp_excl_ok = ~0;
		agu_icb_rsp_rdata = ~0;
		agu_req_alu_res = ~0;
		agu_sbf_0_r = ~0;
		agu_sbf_1_r = ~0;
	end
	endtask

	task Random_Test();
	begin
		agu_i_valid = $urandom;
		agu_i_rs1 = $urandom;
		agu_i_rs2 = $urandom;
		agu_i_imm = $urandom;
		agu_i_info = $urandom;
		agu_i_itag = $urandom;
		flush_req = $urandom;
		flush_pulse = $urandom;
		oitf_empty = $urandom;
		agu_o_ready = $urandom;
		agu_icb_cmd_ready = $urandom;
		agu_icb_rsp_valid = $urandom;
		agu_icb_rsp_err = $urandom;
		agu_icb_rsp_excl_ok = $urandom;
		agu_icb_rsp_rdata = $urandom;
		agu_req_alu_res = $urandom;
		agu_sbf_0_r = $urandom;
		agu_sbf_1_r = $urandom;
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