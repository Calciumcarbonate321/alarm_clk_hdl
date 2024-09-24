module tb_aclk_lcd_display;

    reg [3:0] current_time_ms_hr;
    reg [3:0] current_time_ls_hr;
    reg [3:0] current_time_ms_min;
    reg [3:0] current_time_ls_min;
    reg [3:0] alarm_time_ms_hr;
    reg [3:0] alarm_time_ls_hr;
    reg [3:0] alarm_time_ms_min;
    reg [3:0] alarm_time_ls_min;
    reg [3:0] key_ms_hr;
    reg [3:0] key_ls_hr;
    reg [3:0] key_ms_min;
    reg [3:0] key_ls_min;
    reg show_new_time;
    reg show_a;
    reg clk;
    
    wire [7:0] display_ms_hr;
    wire [7:0] display_ls_hr;
    wire [7:0] display_ms_min;
    wire [7:0] display_ls_min;
    wire sound_alarm;

    // Instantiate the aclk_lcd_display module
    aclk_lcd_display uut (
        .current_time_ms_hr(current_time_ms_hr),
        .current_time_ls_hr(current_time_ls_hr),
        .current_time_ms_min(current_time_ms_min),
        .current_time_ls_min(current_time_ls_min),
        .alarm_time_ms_hr(alarm_time_ms_hr),
        .alarm_time_ls_hr(alarm_time_ls_hr),
        .alarm_time_ms_min(alarm_time_ms_min),
        .alarm_time_ls_min(alarm_time_ls_min),
        .key_ms_hr(key_ms_hr),
        .key_ls_hr(key_ls_hr),
        .key_ms_min(key_ms_min),
        .key_ls_min(key_ls_min),
        .show_new_time(show_new_time),
        .show_a(show_a),
        .sound_alarm(sound_alarm),
        .display_ms_hr(display_ms_hr),
        .display_ls_hr(display_ls_hr),
        .display_ms_min(display_ms_min),
        .display_ls_min(display_ls_min)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units period clock
    end

    // Test procedure
    initial begin
        // Initialize signals
        show_new_time = 0;
        show_a = 0;
        current_time_ms_hr = 4'd0;
        current_time_ls_hr = 4'd0;
        current_time_ms_min = 4'd0;
        current_time_ls_min = 4'd0;
        alarm_time_ms_hr = 4'd0;
        alarm_time_ls_hr = 4'd0;
        alarm_time_ms_min = 4'd0;
        alarm_time_ls_min = 4'd0;
        key_ms_hr = 4'd0;
        key_ls_hr = 4'd0;
        key_ms_min = 4'd0;
        key_ls_min = 4'd0;

        // Simulate operation
        // Show current time
        #10;
        show_new_time = 1;
        show_a = 0;
        current_time_ms_hr = 4'd1;
        current_time_ls_hr = 4'd2;
        current_time_ms_min = 4'd3;
        current_time_ls_min = 4'd4;
        #100;

        // Show alarm time
        show_new_time = 0;
        show_a = 1;
        alarm_time_ms_hr = 4'd5;
        alarm_time_ls_hr = 4'd6;
        alarm_time_ms_min = 4'd7;
        alarm_time_ls_min = 4'd8;
        #100;

        // Finish simulation
        #100 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t: show_new_time = %b, show_a = %b, sound_alarm = %b, display_ms_hr = %h, display_ls_hr = %h, display_ms_min = %h, display_ls_min = %h",
                 $time, show_new_time, show_a, sound_alarm, display_ms_hr, display_ls_hr, display_ms_min, display_ls_min);
    end

endmodule
