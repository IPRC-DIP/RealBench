module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
output logic commit_mret,
output logic commit_trap,
output logic excp_active,
output logic [31:0] itcm_region_indic,
output logic [31:0] dtcm_region_indic,
output logic lsu_o_ready,
output logic agu_icb_cmd_valid,
output logic [31:0] agu_icb_cmd_addr,
output logic agu_icb_cmd_read,
output logic [31:0] agu_icb_cmd_wdata,
output logic [3:0] agu_icb_cmd_wmask,
output logic agu_icb_cmd_lock,
output logic agu_icb_cmd_excl,
output logic [1:0] agu_icb_cmd_size,
output logic agu_icb_cmd_back2agu,
output logic agu_icb_cmd_usign,
output logic agu_icb_cmd_itag,
output logic agu_icb_rsp_ready,
output logic itcm_icb_cmd_ready,
output logic itcm_icb_rsp_valid,
output logic itcm_icb_rsp_err,
output logic itcm_icb_rsp_excl_ok,
output logic [31:0] itcm_icb_rsp_rdata,
output logic dtcm_icb_cmd_ready,
output logic dtcm_icb_rsp_valid,
output logic dtcm_icb_rsp_err,
output logic dtcm_icb_rsp_excl_ok,
output logic [31:0] dtcm_icb_rsp_rdata,
output logic biu_icb_cmd_ready,
output logic biu_icb_rsp_valid,
output logic biu_icb_rsp_err,
output logic biu_icb_rsp_excl_ok,
output logic [31:0] biu_icb_rsp_rdata,
output logic nice_mem_holdup,
output logic nice_icb_cmd_valid,
output logic [31:0] nice_icb_cmd_addr,
output logic nice_icb_cmd_read,
output logic [31:0] nice_icb_cmd_wdata,
output logic [3:0] nice_icb_cmd_wmask,
output logic nice_icb_cmd_lock,
output logic nice_icb_cmd_excl,
output logic [1:0] nice_icb_cmd_size,
output logic nice_icb_rsp_ready,
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
		commit_mret = 0;
		commit_trap = 0;
		excp_active = 0;
		itcm_region_indic = 0;
		dtcm_region_indic = 0;
		lsu_o_ready = 0;
		agu_icb_cmd_valid = 0;
		agu_icb_cmd_addr = 0;
		agu_icb_cmd_read = 0;
		agu_icb_cmd_wdata = 0;
		agu_icb_cmd_wmask = 0;
		agu_icb_cmd_lock = 0;
		agu_icb_cmd_excl = 0;
		agu_icb_cmd_size = 0;
		agu_icb_cmd_back2agu = 0;
		agu_icb_cmd_usign = 0;
		agu_icb_cmd_itag = 0;
		agu_icb_rsp_ready = 0;
		itcm_icb_cmd_ready = 0;
		itcm_icb_rsp_valid = 0;
		itcm_icb_rsp_err = 0;
		itcm_icb_rsp_excl_ok = 0;
		itcm_icb_rsp_rdata = 0;
		dtcm_icb_cmd_ready = 0;
		dtcm_icb_rsp_valid = 0;
		dtcm_icb_rsp_err = 0;
		dtcm_icb_rsp_excl_ok = 0;
		dtcm_icb_rsp_rdata = 0;
		biu_icb_cmd_ready = 0;
		biu_icb_rsp_valid = 0;
		biu_icb_rsp_err = 0;
		biu_icb_rsp_excl_ok = 0;
		biu_icb_rsp_rdata = 0;
		nice_mem_holdup = 0;
		nice_icb_cmd_valid = 0;
		nice_icb_cmd_addr = 0;
		nice_icb_cmd_read = 0;
		nice_icb_cmd_wdata = 0;
		nice_icb_cmd_wmask = 0;
		nice_icb_cmd_lock = 0;
		nice_icb_cmd_excl = 0;
		nice_icb_cmd_size = 0;
		nice_icb_rsp_ready = 0;
	end
	endtask

	task Task2();
	begin
	// Add Task2 here
		commit_mret = ~0;
		commit_trap = ~0;
		excp_active = ~0;
		itcm_region_indic = ~0;
		dtcm_region_indic = ~0;
		lsu_o_ready = ~0;
		agu_icb_cmd_valid = ~0;
		agu_icb_cmd_addr = ~0;
		agu_icb_cmd_read = ~0;
		agu_icb_cmd_wdata = ~0;
		agu_icb_cmd_wmask = ~0;
		agu_icb_cmd_lock = ~0;
		agu_icb_cmd_excl = ~0;
		agu_icb_cmd_size = ~0;
		agu_icb_cmd_back2agu = ~0;
		agu_icb_cmd_usign = ~0;
		agu_icb_cmd_itag = ~0;
		agu_icb_rsp_ready = ~0;
		itcm_icb_cmd_ready = ~0;
		itcm_icb_rsp_valid = ~0;
		itcm_icb_rsp_err = ~0;
		itcm_icb_rsp_excl_ok = ~0;
		itcm_icb_rsp_rdata = ~0;
		dtcm_icb_cmd_ready = ~0;
		dtcm_icb_rsp_valid = ~0;
		dtcm_icb_rsp_err = ~0;
		dtcm_icb_rsp_excl_ok = ~0;
		dtcm_icb_rsp_rdata = ~0;
		biu_icb_cmd_ready = ~0;
		biu_icb_rsp_valid = ~0;
		biu_icb_rsp_err = ~0;
		biu_icb_rsp_excl_ok = ~0;
		biu_icb_rsp_rdata = ~0;
		nice_mem_holdup = ~0;
		nice_icb_cmd_valid = ~0;
		nice_icb_cmd_addr = ~0;
		nice_icb_cmd_read = ~0;
		nice_icb_cmd_wdata = ~0;
		nice_icb_cmd_wmask = ~0;
		nice_icb_cmd_lock = ~0;
		nice_icb_cmd_excl = ~0;
		nice_icb_cmd_size = ~0;
		nice_icb_rsp_ready = ~0;
	end
	endtask

	task Random_Test();
	begin
		commit_mret = $urandom;
		commit_trap = $urandom;
		excp_active = $urandom;
		itcm_region_indic = $urandom;
		dtcm_region_indic = $urandom;
		lsu_o_ready = $urandom;
		agu_icb_cmd_valid = $urandom;
		agu_icb_cmd_addr = $urandom;
		agu_icb_cmd_read = $urandom;
		agu_icb_cmd_wdata = $urandom;
		agu_icb_cmd_wmask = $urandom;
		agu_icb_cmd_lock = $urandom;
		agu_icb_cmd_excl = $urandom;
		agu_icb_cmd_size = $urandom;
		agu_icb_cmd_back2agu = $urandom;
		agu_icb_cmd_usign = $urandom;
		agu_icb_cmd_itag = $urandom;
		agu_icb_rsp_ready = $urandom;
		itcm_icb_cmd_ready = $urandom;
		itcm_icb_rsp_valid = $urandom;
		itcm_icb_rsp_err = $urandom;
		itcm_icb_rsp_excl_ok = $urandom;
		itcm_icb_rsp_rdata = $urandom;
		dtcm_icb_cmd_ready = $urandom;
		dtcm_icb_rsp_valid = $urandom;
		dtcm_icb_rsp_err = $urandom;
		dtcm_icb_rsp_excl_ok = $urandom;
		dtcm_icb_rsp_rdata = $urandom;
		biu_icb_cmd_ready = $urandom;
		biu_icb_rsp_valid = $urandom;
		biu_icb_rsp_err = $urandom;
		biu_icb_rsp_excl_ok = $urandom;
		biu_icb_rsp_rdata = $urandom;
		nice_mem_holdup = $urandom;
		nice_icb_cmd_valid = $urandom;
		nice_icb_cmd_addr = $urandom;
		nice_icb_cmd_read = $urandom;
		nice_icb_cmd_wdata = $urandom;
		nice_icb_cmd_wmask = $urandom;
		nice_icb_cmd_lock = $urandom;
		nice_icb_cmd_excl = $urandom;
		nice_icb_cmd_size = $urandom;
		nice_icb_rsp_ready = $urandom;
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