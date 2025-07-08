module stimulus_gen (
    input clk,
    input tb_match,
    output logic rst_n,
    output logic nice_i_xs_off,
    output logic nice_i_valid,
    output logic [31:0] nice_i_instr,
    output logic [31:0] nice_i_rs1,
    output logic [31:0] nice_i_rs2,
    output logic nice_i_itag,
    output logic nice_o_ready,
    output logic nice_o_itag_ready,
    output logic nice_rsp_multicyc_valid,
    output logic nice_req_ready,
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
	begin
	// Add Task1 here
		nice_i_xs_off = 0;
		nice_i_valid = 0;
		nice_i_instr = 0;
		nice_i_rs1 = 0;
		nice_i_rs2 = 0;
		nice_i_itag = 0;
		nice_o_ready = 0;
		nice_o_itag_ready = 0;
		nice_rsp_multicyc_valid = 0;
		nice_req_ready = 0;
	end
	endtask

	task base_all_high();
	begin
	// Add Task2 here
		nice_i_xs_off = ~0;
		nice_i_valid = ~0;
		nice_i_instr = ~0;
		nice_i_rs1 = ~0;
		nice_i_rs2 = ~0;
		nice_i_itag = ~0;
		nice_o_ready = ~0;
		nice_o_itag_ready = ~0;
		nice_rsp_multicyc_valid = ~0;
		nice_req_ready = ~0;
	end
	endtask

	task base_all_random();
	begin
		nice_i_xs_off = $urandom;
		nice_i_valid = $urandom;
		nice_i_instr = $urandom;
		nice_i_rs1 = $urandom;
		nice_i_rs2 = $urandom;
		nice_i_itag = $urandom;
		nice_o_ready = $urandom;
		nice_o_itag_ready = $urandom;
		nice_rsp_multicyc_valid = $urandom;
		nice_req_ready = $urandom;
	end
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

    // test_plan
    // ---------------------------reset-----------------------------
    // async reset  ok
    // sync reset   ok
    // -----------------------------io------------------------------
    // nice_i_ready         ok combination logic
    // nice_o_longpipe      ok c
    // nice_o_valid         ok c
    // nice_o_itag_valid    no sequential logic
    // nice_o_itag          no sequential logic
    // nice_rsp_multicyc_ready  no s
    // nice_req_valid       ok c
    // nice_req_instr       ok c
    // nice_req_rs1         ok c
    // nice_req_rs2         ok c
    // ---------------------------core logic------------------------
    // fifo                 

    task c_nice_i_ready(input r);
        if(r==1) begin
            c_nice_req_ready_pos(1);
            nice_o_ready = 1;
        end
        else begin
            case ($urandom & 2'b11)
                2'b10:begin
                    c_nice_req_ready_pos(1);
                    nice_o_ready = 0;
                end 
                2'b01:begin
                    c_nice_req_ready_pos(0);
                    nice_o_ready = 1;
                end
                default: begin
                    c_nice_req_ready_pos(0);
                    nice_o_ready = 0; 
                end
            endcase
        end
    endtask

    task c_nice_req_ready_pos(input r);
        if(r==0)begin
            nice_i_xs_off = 0;
            nice_req_ready = 0;
        end
        else begin
            case ($urandom & 1'b1)
                1'b1: nice_i_xs_off = 1; 
                default: begin
                    nice_i_xs_off = 1;
                    nice_req_ready = 1;
                end
            endcase
        end
    endtask

    task c_nice_o_longpipe(input r);
        nice_i_xs_off = ~r;
    endtask

    task c_nice_o_valid(input r);
        if(r==1)begin
            nice_i_valid = 1;
            c_nice_req_ready_pos(1);
        end
        else begin
            case ($urandom & 2'b11)
                2'b10:begin
                    nice_i_valid = 1;
                    c_nice_req_ready_pos(0);
                end 
                2'b01:begin
                    nice_i_valid = 0;
                    c_nice_req_ready_pos(1);
                end
                default:begin
                    nice_i_valid = 0;
                    c_nice_req_ready_pos(0);
                end 
            endcase
        end
    endtask

    task c_nice_req_valid(input bit r);
        if (r == 1) begin
            nice_i_xs_off = 0;
            c_nice_req_valid_pos(1);
        end else begin
            case ($urandom & 2'b11)
                2'b10: begin
                    nice_i_xs_off = 1;
                    c_nice_req_valid_pos(0);
                end
                2'b01: begin
                    nice_i_xs_off = 0;
                    c_nice_req_valid_pos(0);
                end
                default: begin
                    nice_i_xs_off = 1;
                    c_nice_req_valid_pos(1);
                end
            endcase
        end
    endtask

    task c_nice_req_valid_pos(input bit r);
        if (r == 1) begin
            nice_i_valid = 1;
            nice_o_ready = 1;
        end else begin
            case ($urandom & 2'b11)
                2'b10: begin
                    nice_i_valid = 1;
                    nice_o_ready = 0;
                end
                2'b01: begin
                    nice_i_valid = 0;
                    nice_o_ready = 1;
                end
                default: begin
                    nice_i_valid = 0;
                    nice_o_ready = 0;
                end
            endcase
        end
    endtask

    task c_random_nice_req_instr();
        nice_i_instr = $urandom;
    endtask

    task c_random_nice_req_rs1();
        nice_i_rs1 = $urandom;
    endtask

    task c_random_nice_req_rs2();
        nice_i_rs2 = $urandom;
    endtask

    initial begin
        // 初始化
        {rst_n,wavedrom_enable} <= '1;
        wavedrom_title <= "";
        
        // 复位测试
        reset_test(0);  // 同步复位测试
        @(negedge clk);
        reset_test(1);  // 异步复位测试
        @(negedge clk);
        
        // 测试任务1 组合逻辑
        wavedrom_start("1");
        repeat(50)begin@(negedge clk);c_nice_i_ready(1);@(negedge clk);c_nice_i_ready(0);end
        repeat(50)begin@(negedge clk);c_nice_o_longpipe(1);@(negedge clk);c_nice_o_longpipe(0);end
        repeat(50)begin@(negedge clk);c_nice_o_valid(1);@(negedge clk);c_nice_o_valid(0);end
        repeat(50)begin@(negedge clk);c_nice_req_valid(1);@(negedge clk);c_nice_req_valid(0);end
        repeat(50)begin@(negedge clk);c_random_nice_req_instr();end
        repeat(50)begin@(negedge clk);c_random_nice_req_rs1();end
        repeat(50)begin@(negedge clk);c_random_nice_req_rs2();end
        wavedrom_stop();

        // 复位
        @(negedge clk);base_all_low();
        @(negedge clk);rst_n = 0;
        @(negedge clk);rst_n = 1;

        // 测试任务2 时序逻辑
        wavedrom_start("2");
        // 子任务1 空队列读 
        @(negedge clk); 
        nice_rsp_multicyc_valid = 1;    // 尝试读，但是此时fifo_vld应该是0,也就不会产生nice_rsp_multicyc_ready信号，也就不会产生itag_fifo_ren信号
        nice_o_itag_ready = 1;
        
        // 复位
        @(negedge clk);base_all_low();
        @(negedge clk);rst_n = 0;
        @(negedge clk);rst_n = 1;

        // 子任务2 连续派发
        @(negedge clk);
        c_nice_o_longpipe(1);   
        c_nice_req_valid(1);
        nice_req_ready = 1;     //  itag_fifo_wen = 1
        nice_i_itag = 1;
        @(negedge clk);
        c_nice_o_longpipe(1);   
        c_nice_req_valid(1);
        nice_req_ready = 1;     //  itag_fifo_wen = 1
        nice_i_itag = 1;
        @(negedge clk);
        c_nice_o_longpipe(1);   
        c_nice_req_valid(1);
        nice_req_ready = 1;     //  itag_fifo_wen = 1
        nice_i_itag = 1;
        @(negedge clk);
        c_nice_o_longpipe(1);   
        c_nice_req_valid(1);
        nice_req_ready = 1;     //  itag_fifo_wen = 1
        nice_i_itag = 1;

        @(negedge clk);base_all_low(); // 清空信号

        // 子任务3 满队列写
        @(negedge clk);
        c_nice_o_longpipe(1);   
        c_nice_req_valid(1);
        nice_req_ready = 1;     //  itag_fifo_wen = 1
        nice_i_itag = 0;

        @(negedge clk);base_all_low(); // 清空信号

        // 子任务4 读取
        repeat(3)begin
            @(negedge clk);
            nice_rsp_multicyc_valid = 1;
            nice_o_itag_ready = 1;
        end

        // 子任务5 同时读写
        @(negedge clk);
        // 写
        c_nice_o_longpipe(1);   
        c_nice_req_valid(1);
        nice_req_ready = 1;     //  itag_fifo_wen = 1
        nice_i_itag = 1;
        // 读
        nice_rsp_multicyc_valid = 1;
        nice_o_itag_ready = 1;

        repeat(3)@(negedge clk);

        wavedrom_stop();

        // 结束
        $finish;
    end
endmodule