// stimulus_gen.sv
module stimulus_gen (
    input clk,
    output logic [7:0] a  // sbox input
);
    initial begin
        a = 8'hxx;  // 初始化为未知值
        
        // 第一轮：在时钟上升沿测试所有输入值
        for(int i=0; i<256; i++) begin
            @(posedge clk);
            a = i[7:0];
        end
        
        // 第二轮：在时钟下降沿测试所有输入值
        for(int i=0; i<256; i++) begin
            @(negedge clk);
            a = i[7:0];
        end
        
        // 第三轮：反向顺序测试所有输入值
        for(int i=255; i>=0; i--) begin
            @(posedge clk);
            a = i[7:0];
        end
        
        
        // 完成所有测试后结束仿真
        @(posedge clk);
        $finish;
    end
endmodule