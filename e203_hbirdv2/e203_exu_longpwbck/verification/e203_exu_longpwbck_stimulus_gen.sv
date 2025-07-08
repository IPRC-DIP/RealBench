module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    // 输出待测模块的输入
	output logic lsu_wbck_i_valid,
	output logic [32-1:0] lsu_wbck_i_wdat,
	output logic lsu_wbck_i_itag,
	output logic lsu_wbck_i_err,
	output logic lsu_cmt_i_buserr,
	output logic [32-1:0] lsu_cmt_i_badaddr,
	output logic lsu_cmt_i_ld,
	output logic lsu_cmt_i_st,
	output logic longp_wbck_o_ready,
	output logic longp_excp_o_ready,
	output logic oitf_empty,
	output logic oitf_ret_ptr,
	output logic [5-1:0] oitf_ret_rdidx,
	output logic [32-1:0] oitf_ret_pc,
	output logic oitf_ret_rdwen,
	output logic oitf_ret_rdfpu,
	output logic nice_longp_wbck_i_valid,
	output logic [32-1:0] nice_longp_wbck_i_wdat,
	output logic nice_longp_wbck_i_itag,
	output logic nice_longp_wbck_i_err,
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
        bit arfail, srfail, datafail;
   
        @(posedge clk);
        @(posedge clk) rst_n <= 0;
        repeat(3) @(posedge clk);
   
        @(negedge clk) begin datafail = !tb_match; rst_n <= 1; end
        @(posedge clk) arfail = !tb_match;
        @(posedge clk) begin
            srfail = !tb_match;
            rst_n <= 0;
        end
        if (srfail)
            $display("Hint: Your reset doesn't seem to be working.");
        else if (arfail && (async || !datafail))
            $display("Hint: Your reset should be %0s, but doesn't appear to be.", 
                    async ? "asynchronous" : "synchronous");
    endtask

    initial begin
        // 初始化
        int seed = 12345;
        {
            rst_n,
            lsu_wbck_i_valid,
            lsu_wbck_i_wdat,
            lsu_wbck_i_itag,
            lsu_wbck_i_err,
            lsu_cmt_i_buserr,
            lsu_cmt_i_badaddr,
            lsu_cmt_i_ld,
            lsu_cmt_i_st,
            longp_wbck_o_ready,
            longp_excp_o_ready,
            oitf_empty,
            oitf_ret_ptr,
            oitf_ret_rdidx,
            oitf_ret_pc,
            oitf_ret_rdwen,
            oitf_ret_rdfpu,
            nice_longp_wbck_i_valid,
            nice_longp_wbck_i_wdat,
            nice_longp_wbck_i_itag,
            nice_longp_wbck_i_err,
            wavedrom_enable
        } <= '0;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        repeat(2) @(posedge clk);
        reset_test(0);  // 异步复位测试
        repeat(2) @(posedge clk);
        
        // 测试任务1 输出就绪，输入不就绪，oitf非空 -> 不写回
        wavedrom_start("Task1");
        repeat(1000)begin
            @(posedge clk);
            lsu_wbck_i_valid = 1'b0; // lsu 
            lsu_wbck_i_wdat = $random(seed);
            lsu_wbck_i_itag = $random(seed) & 1'b1; 
            {lsu_wbck_i_err,lsu_cmt_i_buserr} = 2'b00;
            lsu_cmt_i_badaddr = $random(seed);
            {lsu_cmt_i_ld,lsu_cmt_i_st} = ($random(seed) & 1'b1)?2'b10:2'b01;
            {longp_wbck_o_ready,longp_excp_o_ready} = 2'b11; // wbck,excp
            oitf_empty = 1'b0; // oitf
            oitf_ret_ptr = $random(seed) & 1'b1;
            oitf_ret_rdidx = $random(seed) & 5'h1F;
            oitf_ret_pc = $random(seed);
            oitf_ret_rdwen = $random(seed) & 1'b1;
            oitf_ret_rdfpu = $random(seed) & 1'b1;
            nice_longp_wbck_i_valid = 1'b0; // nice
            nice_longp_wbck_i_wdat = $random(seed);
            nice_longp_wbck_i_itag = $random(seed) & 1'b1;
            nice_longp_wbck_i_err = $random(seed) & 1'b1;
        end
        // 测试任务2 输出不就绪，输入就绪，oitf非空 -> 不写回
        wavedrom_start("Task2");
        repeat(1000)begin
            @(posedge clk);
            lsu_wbck_i_valid = $random(seed) & 1'b1; // lsu 
            lsu_wbck_i_wdat = $random(seed);
            lsu_wbck_i_itag = $random(seed) & 1'b1; 
            {lsu_wbck_i_err,lsu_cmt_i_buserr} = 2'b00;
            lsu_cmt_i_badaddr = $random(seed);
            {lsu_cmt_i_ld,lsu_cmt_i_st} = ($random(seed) & 1'b1)?2'b10:2'b01;
            {longp_wbck_o_ready,longp_excp_o_ready} = 2'b00; // wbck,excp
            oitf_empty = 1'b0; // oitf
            // oitf_ret_ptr = $random(seed) & 1'b1;
            oitf_ret_rdidx = $random(seed) & 5'h1F;
            oitf_ret_pc = $random(seed);
            oitf_ret_rdwen = $random(seed) & 1'b1;
            oitf_ret_rdfpu = $random(seed) & 1'b1;
            nice_longp_wbck_i_valid = ~lsu_wbck_i_valid; // nice nice与lsu必有一写回
            nice_longp_wbck_i_wdat = $random(seed);
            nice_longp_wbck_i_itag = ~lsu_wbck_i_itag;
            nice_longp_wbck_i_err = $random(seed) & 1'b1;
            if (lsu_wbck_i_valid) begin
                oitf_ret_ptr = lsu_wbck_i_itag;
            end
            else begin
                oitf_ret_ptr = nice_longp_wbck_i_itag;
            end
        end
        // 测试任务3 输出就绪，写回输入就绪，oitf空 -> 不写回
        wavedrom_start("Task3");
        repeat(1000)begin
            @(posedge clk);
            lsu_wbck_i_valid = $random(seed) & 1'b1; // lsu 
            lsu_wbck_i_wdat = $random(seed);
            lsu_wbck_i_itag = $random(seed) & 1'b1; 
            {lsu_wbck_i_err,lsu_cmt_i_buserr} = 2'b00;
            lsu_cmt_i_badaddr = $random(seed);
            {lsu_cmt_i_ld,lsu_cmt_i_st} = ($random(seed) & 1'b1)?2'b10:2'b01;
            {longp_wbck_o_ready,longp_excp_o_ready} = 2'b00; // wbck,excp
            oitf_empty = 1'b1; // oitf
            oitf_ret_rdidx = $random(seed) & 5'h1F;
            oitf_ret_pc = $random(seed);
            oitf_ret_rdwen = $random(seed) & 1'b1;
            oitf_ret_rdfpu = $random(seed) & 1'b1;
            nice_longp_wbck_i_valid = ~lsu_wbck_i_valid; // nice nice与lsu必有一写回
            nice_longp_wbck_i_wdat = $random(seed);
            nice_longp_wbck_i_itag = ~lsu_wbck_i_itag;
            nice_longp_wbck_i_err = $random(seed) & 1'b1;
            if (lsu_wbck_i_valid) begin
                oitf_ret_ptr = lsu_wbck_i_itag;
            end
            else begin
                oitf_ret_ptr = nice_longp_wbck_i_itag;
            end
        end

        // 测试任务4 输出就绪，输入就绪，oitf非空 -> 写回
        wavedrom_start("Task4");
        repeat(1000)begin
            @(posedge clk);
            lsu_wbck_i_valid = $random(seed) & 1'b1; // lsu 
            lsu_wbck_i_wdat = $random(seed);
            lsu_wbck_i_itag = $random(seed) & 1'b1; 
            {lsu_wbck_i_err,lsu_cmt_i_buserr} = 2'b00;
            lsu_cmt_i_badaddr = $random(seed);
            {lsu_cmt_i_ld,lsu_cmt_i_st} = ($random(seed) & 1'b1)?2'b10:2'b01;
            {longp_wbck_o_ready,longp_excp_o_ready} = 2'b00; // wbck,excp
            oitf_empty = 1'b0; // oitf
            // oitf_ret_ptr = $random(seed) & 1'b1;
            oitf_ret_rdidx = $random(seed) & 5'h1F;
            oitf_ret_pc = $random(seed);
            oitf_ret_rdwen = $random(seed) & 1'b1;
            oitf_ret_rdfpu = $random(seed) & 1'b1;
            nice_longp_wbck_i_valid = ~lsu_wbck_i_valid; // nice nice与lsu必有一写回
            nice_longp_wbck_i_wdat = $random(seed);
            nice_longp_wbck_i_itag = ~lsu_wbck_i_itag;
            nice_longp_wbck_i_err = $random(seed) & 1'b1;
            if (lsu_wbck_i_valid) begin
                oitf_ret_ptr = lsu_wbck_i_itag;
            end
            else begin
                oitf_ret_ptr = nice_longp_wbck_i_itag;
            end
        end
        @(posedge clk);
        lsu_wbck_i_valid = 1'b0;
        nice_longp_wbck_i_valid = 1'b0;
        wavedrom_stop();

        // 测试任务5-异常
        wavedrom_start("Task4");
        repeat(5000)begin
            @(posedge clk);
            lsu_wbck_i_valid = $random(seed) & 1'b1;    // lsu
            lsu_wbck_i_wdat = $random(seed);
            lsu_wbck_i_itag = $random(seed) & 1'b1; 
            {lsu_wbck_i_err,lsu_cmt_i_buserr} = $random(seed) & 2'b11;
            lsu_cmt_i_badaddr = $random(seed);
            {lsu_cmt_i_ld,lsu_cmt_i_st} = ($random(seed) & 1'b1)?2'b10:2'b01;
            {longp_wbck_o_ready,longp_excp_o_ready} = $random(seed) & 2'b11;
            oitf_empty = $random(seed) & 1'b1;
            oitf_ret_ptr = $random(seed) & 1'b1;
            oitf_ret_rdidx = $random(seed) & 5'h1F;
            oitf_ret_pc = $random(seed);
            oitf_ret_rdwen = $random(seed) & 1'b1;
            oitf_ret_rdfpu = $random(seed) & 1'b1;
            nice_longp_wbck_i_valid = $random(seed) & 1'b1;     // nice
            nice_longp_wbck_i_wdat = $random(seed);
            nice_longp_wbck_i_itag = $random(seed) & 1'b1;
            nice_longp_wbck_i_err = $random(seed) & 1'b1;
        end
        @(posedge clk);
        lsu_wbck_i_valid = 1'b0;
        nice_longp_wbck_i_valid = 1'b0;
        rst_n = 1'b1;

        // 随机测试
        wavedrom_start("Random Test");
        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule