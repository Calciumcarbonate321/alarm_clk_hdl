module tb_aclk_lcd_driver;

    reg [3:0] alarm_time;
    reg [3:0] current_time;
    reg [3:0] key;
    reg show_alarm;
    reg show_new_time;
    
    wire [7:0] display_time;
    wire sound_alarm;

    aclk_lcd_driver uut (
        .alarm_time(alarm_time),
        .current_time(current_time),
        .key(key),
        .show_alarm(show_alarm),
        .show_new_time(show_new_time),
        .display_time(display_time),
        .sound_alarm(sound_alarm)
    );

    initial begin
        show_new_time = 0;
        show_alarm = 0;
        current_time = 4'd0;
        alarm_time = 4'd0;
        key = 4'd0;

        #10;
        show_new_time = 1;
        show_alarm = 0;
        key = 4'd5;
        #100;

        show_new_time = 0;
        show_alarm = 1;
        alarm_time = 4'd9;
        #100;

        #10;
        current_time = 4'd9;
        alarm_time = 4'd9;
        #100;

        #100 $finish;
    end

    initial begin
        $monitor("At time %t: show_new_time = %b, show_alarm = %b, sound_alarm = %b, display_time = %h",
                 $time, show_new_time, show_alarm, sound_alarm, display_time);
    end

endmodule
