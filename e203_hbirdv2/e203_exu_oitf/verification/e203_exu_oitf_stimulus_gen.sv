module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    // 输出待测模块的输入
	output logic dis_ena,
	output logic ret_ena,
	output logic disp_i_rs1en,
	output logic disp_i_rs2en,
	output logic disp_i_rs3en,
	output logic disp_i_rdwen,
	output logic disp_i_rs1fpu,
	output logic disp_i_rs2fpu,
	output logic disp_i_rs3fpu,
	output logic disp_i_rdfpu,
	output logic [5-1:0] disp_i_rs1idx,
	output logic [5-1:0] disp_i_rs2idx,
	output logic [5-1:0] disp_i_rs3idx,
	output logic [5-1:0] disp_i_rdidx,
	output logic [32-1:0] disp_i_pc,
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
        dis_ena = '0;
        ret_ena = '0;
        disp_i_rs1en = '0;
        disp_i_rs2en = '0;
        disp_i_rs3en = '0;
        disp_i_rdwen = '0;
        disp_i_rs1fpu = '0;
        disp_i_rs2fpu = '0;
        disp_i_rs3fpu = '0;
        disp_i_rdfpu = '0;
        disp_i_rs1idx = '0;
        disp_i_rs2idx = '0;
        disp_i_rs3idx = '0;
        disp_i_rdidx = '0;
        disp_i_pc = '0;
    endtask

    // test_plan
    // ---------------------------------reset----------------------------------
    // async reset ok
    // sync reset ok
    // ---------------------------------io-------------------------------------
    // dis_ready
    // dis_ptr
    // ret_ptr
    // ret_rdidx
    // ret_rdwen
    // ret_rdfpu
    // ret_pc
    // oitfrd_match_disprs1
    // oitfrd_match_disprs2
    // oitfrd_match_disprs3
    // oitfrd_match_disprd
    // oitf_empty

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

    task reset_between_task();
        // 复位
        @(negedge clk);begin base_all_low(); rst_n = 1; end
        @(negedge clk);rst_n = 0;
        @(negedge clk);rst_n = 1;
    endtask

    task disp_longpipe(input [4:0] rdidx,input [31:0] pc,input rdwen,input rdfpu);
        @(negedge clk);
        base_all_low();
        dis_ena = 1;
        disp_i_rdidx = rdidx;
        disp_i_pc = $urandom;
        disp_i_rdwen = rdwen;
        disp_i_rdfpu = rdfpu;
    endtask

    task retire_longpipe();
        @(negedge clk);
        base_all_low();
        ret_ena = 1;
    endtask

    task disp_oitf_match(input rs1en,input rs2en,input rs3en,input rdwen,input rs1fpu,input rs2fpu,input rs3fpu,input rdfpu,input rs1idx,input rs2idx,input rs3idx,input rdidx);
        @(negedge clk);
        base_all_low();
        disp_i_rs1en = rs1en;
        disp_i_rs2en = rs2en;
        disp_i_rs3en = rs3en;
        disp_i_rdwen = rdwen;
        disp_i_rs1fpu = rs1fpu;
        disp_i_rs2fpu = rs2fpu;
        disp_i_rs3fpu = rs3fpu;
        disp_i_rdfpu = rdfpu;
        disp_i_rs1idx = rs1idx;
        disp_i_rs2idx = rs2idx;
        disp_i_rs3idx = rs3idx;
        disp_i_rdidx = rdidx;
    endtask

    initial begin

        // 测试任务0-复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(1);  // 异步复位测试
        @(negedge clk);
        
        reset_between_task();
        
        // 测试任务1-长流水线指令存入，推出
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_longpipe(5'b00010,$urandom,0,0);
        retire_longpipe();
        retire_longpipe();

        reset_between_task();

        // 测试任务2-oitf主要功能-依赖检查
        // 依次检查各个条件:rdwen,disp1_en,disp2_en,disp3_en,rdfpu,rdidx
        // rdwen
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();
        disp_longpipe(5'b00001,$urandom,0,1);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();

        // disp_i_rs1en,disp_i_rs2en,disp_i_rs3en,disp_rdwen
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(0,0,0,0, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();

        // disp_i_rs1fpu,disp_i_rs2fpu,disp_i_rs3fpu,disp_i_rdfpu
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(1,1,1,1, 0,0,0,0, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();

        // disp_i_rs1idx,disp_i_rs2idx,disp_i_rs3idx,disp_i_rdidx
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00010,5'b00010,5'b00010,5'b00010)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();

        // 测试任务3-两条长流水线指令同时检查依赖
        disp_longpipe(5'b00001,$urandom,1,1);
        disp_longpipe(5'b00011,$urandom,1,0);
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00011,5'b00011,5'b00011,5'b00011)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        disp_oitf_match(1,1,1,1, 0,0,0,0, 5'b00011,5'b00011,5'b00011,5'b00011)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        disp_oitf_match(1,1,1,1, 0,0,0,0, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        disp_oitf_match(1,1,1,1, 1,1,1,1, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();
        retire_longpipe();
        
        // 测试任务4-disp-retire同时进行，确保先推出先进入的指令
        disp_longpipe(5'b00001,$urandom,1,0);
        // disp_longpipe(5'b00001,$urandom,1,1);
        @(negedge clk);
        base_all_low();
        dis_ena = 1;
        disp_i_rdidx = 5'b00010;
        disp_i_pc = $urandom;
        disp_i_rdwen = 1;
        disp_i_rdfpu = 0;
        ret_ena = 1;
        disp_oitf_match(1,1,1,1, 0,0,0,0, 5'b00001,5'b00001,5'b00001,5'b00001)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        disp_oitf_match(1,1,1,1, 0,0,0,0, 5'b00011,5'b00011,5'b00011,5'b00011)    ;// 这种输入理论上不存在，但是为了快速验证逻辑，采用
        retire_longpipe();
        retire_longpipe();

        // 结束
        $finish;
    end
endmodule