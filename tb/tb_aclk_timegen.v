module tb_aclk_timegen;

    reg clk;
    reg reset;
    reg reset_count;
    reg fast_watch;
    wire one_minute;
    wire one_second;

    aclk_timegen uut (
        .clk(clk),
        .reset(reset),
        .reset_count(reset_count),
        .fast_watch(fast_watch),
        .one_minute(one_minute),
        .one_second(one_second)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 0;
        reset_count = 0;
        fast_watch = 1;
        #10 reset = 0;
        #100000;
        reset_count = 1;
        #10 reset_count = 0;
        #100000;
        fast_watch = 1;
        #100000;
        fast_watch = 0;
        
    end

    initial begin
        $monitor("At time %t, reset = %b, reset_count = %b, fast_watch = %b, one_minute = %b, one_second = %b",
                 $time, reset, reset_count, fast_watch, one_minute, one_second);
    end

endmodule
	