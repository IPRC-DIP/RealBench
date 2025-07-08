`include "e203_defines.v"
module stimulus_gen (
    input clk,
    input tb_match,
    
    output logic rst_n,
    output logic test_mode,
    output logic core_cgstop,
    output logic core_ifu_active,
    output logic core_exu_active,
    output logic core_lsu_active,
    output logic core_biu_active,
    output logic itcm_active,
    output logic dtcm_active,
    output logic core_wfi,
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

    task generate_random_inputs;
        begin
            test_mode = $urandom_range(0, 1);
            core_cgstop = $urandom_range(0, 1);
            core_ifu_active = $urandom_range(0, 1);
            core_exu_active = $urandom_range(0, 1);
            core_lsu_active = $urandom_range(0, 1);
            core_biu_active = $urandom_range(0, 1);
            `ifdef E203_HAS_ITCM
            itcm_active = $urandom_range(0, 1);
            `endif
            `ifdef E203_HAS_DTCM
            dtcm_active = $urandom_range(0, 1);
            `endif
        end
    endtask
    task case1;
        begin
            test_mode       = 0;
            core_cgstop     = 0;
            core_ifu_active = 0;
            core_exu_active = 0;
            core_lsu_active = 0;
            core_biu_active = 0;
            `ifdef E203_HAS_ITCM
            itcm_active     = 0;
            `endif
            `ifdef E203_HAS_DTCM
            dtcm_active     = 0;
            `endif
        end
    endtask
    task case2;
        begin
            test_mode       = 1;
            core_cgstop     = 1;
            core_ifu_active = 1;
            core_exu_active = 1;
            core_lsu_active = 1;
            core_biu_active = 1;
            `ifdef E203_HAS_ITCM
            itcm_active     = 1;
            `endif
            `ifdef E203_HAS_DTCM
            dtcm_active     = 1;
            `endif
        end
    endtask

    task reset_test(input async=0);
        bit arfail, srfail, datafail;
   
        @(posedge clk);
        @(posedge clk) rst_n <= 1;
        repeat(3) @(posedge clk);
   
        @(negedge clk) begin datafail = !tb_match; rst_n <= 1; end
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
        
        // 随机测试
        for (int i = 0; i < 100; i++) begin
            wavedrom_start("Random Test");
            generate_random_inputs();
            repeat(2) @(posedge clk);
            wavedrom_stop();
        end
        // 测试任务1
        wavedrom_start("Task1");
        case1();
        repeat(2) @(posedge clk);
        wavedrom_stop();

        // 测试任务2
        wavedrom_start("Task2");
        case2();
        repeat(2) @(posedge clk);
        wavedrom_stop();
        // 结束
        $finish;
    end
endmodule