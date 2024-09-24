module tb_aclk_controller;
    reg clk;
    reg rst;
    reg one_second;
    reg alarm_button;
    reg time_button;
    reg [3:0] key;

    wire reset_count;
    wire load_new_c;
    wire show_new_time;
    wire show_a;
    wire load_new_a;
    wire shift;

    aclk_controller uut (
        .clk(clk),
        .rst(rst),
        .one_second(one_second),
        .alarm_button(alarm_button),
        .time_button(time_button),
        .key(key),
        .reset_count(reset_count),
        .load_new_c(load_new_c),
        .show_new_time(show_new_time),
        .show_a(show_a),
        .load_new_a(load_new_a),
        .shift(shift)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        one_second = 0;
        alarm_button = 0;
        time_button = 0;
        key = 4'b1010;

        #10 rst = 0;

        #10 key = 4'b0000;
        #10 key = 4'b1010;

        #10 one_second = 1;
        #10 one_second = 0;
        
        #10 key = 4'b0001;
        #10 key = 4'b1010;
        #10 one_second = 1;
        #10 one_second = 0;

        #10 time_button = 1;
        #10 time_button = 0;
        
        #10 alarm_button = 1;
        #10 alarm_button = 0;

        #10 alarm_button = 1;
        #10 alarm_button = 0;

        #10 time_button = 1;
        #10 time_button = 0;

        #100 $finish;
    end

    initial begin
        $monitor("At time %t, rst = %b, one_second = %b, alarm_button = %b, time_button = %b, key = %b, reset_count = %b, load_new_c = %b, show_new_time = %b, show_a = %b, load_new_a = %b, shift = %b",
                 $time, rst, one_second, alarm_button, time_button, key, reset_count, load_new_c, show_new_time, show_a, load_new_a, shift);
    end
endmodule
