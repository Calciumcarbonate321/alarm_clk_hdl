module tb_alarm_clk_rtl;

    reg clk;
    reg reset;
    reg alarm_button;
    reg time_button;
    reg [3:0] key;
    reg fast_watch;

    wire [7:0] display_ms_hr;
    wire [7:0] display_ls_hr;
    wire [7:0] display_ms_min;
    wire [7:0] display_ls_min;
    wire sound_alarm;

    // Instantiate the alarm_clk_rtl module
    alarm_clk_rtl uut (
        .clk(clk),
        .reset(reset),
        .alarm_button(alarm_button),
        .time_button(time_button),
        .key(key),
        .fast_watch(fast_watch),
        .display_ms_hr(display_ms_hr),
        .display_ls_hr(display_ls_hr),
        .display_ms_min(display_ms_min),
        .display_ls_min(display_ls_min),
        .sound_alarm(sound_alarm)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units period clock
    end

    // Test procedure
    initial begin
        // Initialize signals
        reset = 1;
        alarm_button = 0;
        time_button = 0;
        fast_watch = 0;
        key = 4'b0000;  // NOKEY value (0)

        // Release reset
        #10 reset = 0;

        // Simulate normal operation
        // Example sequence:
        #10 key = 4'b0001;  // Press key 1
        #10 key = 4'b1010;  // Release key

        // Set alarm time example
        #10 alarm_button = 1;
        #10 alarm_button = 0;
        #10 key = 4'b0001;  // Press key 1
        #10 key = 4'b1010;  // Release key

        // Set current time example
        #10 time_button = 1;
        #10 time_button = 0;
        #10 key = 4'b0010;  // Press key 2
        #10 key = 4'b1010;  // Release key

        // Finish simulation
        #10000 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t: reset = %b, alarm_button = %b, time_button = %b, key = %b, fast_watch = %b, sound_alarm = %b, display_ms_hr = %h, display_ls_hr = %h, display_ms_min = %h, display_ls_min = %h",
                 $time, reset, alarm_button, time_button, key, fast_watch, sound_alarm, display_ms_hr, display_ls_hr, display_ms_min, display_ls_min);
    end

endmodule
