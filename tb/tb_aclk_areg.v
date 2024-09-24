module tb_aclk_areg;

    reg clk;
    reg reset;
    reg load_new_a;
    reg [3:0] new_alarm_ms_hr;
    reg [3:0] new_alarm_ls_hr;
    reg [3:0] new_alarm_ms_min;
    reg [3:0] new_alarm_ls_min;
    wire [3:0] alarm_time_ms_hr;
    wire [3:0] alarm_time_ls_hr;
    wire [3:0] alarm_time_ms_min;
    wire [3:0] alarm_time_ls_min;

    aclk_areg uut (
        .clk(clk),
        .reset(reset),
        .load_new_a(load_new_a),
        .new_alarm_ms_hr(new_alarm_ms_hr),
        .new_alarm_ls_hr(new_alarm_ls_hr),
        .new_alarm_ms_min(new_alarm_ms_min),
        .new_alarm_ls_min(new_alarm_ls_min),
        .alarm_time_ms_hr(alarm_time_ms_hr),
        .alarm_time_ls_hr(alarm_time_ls_hr),
        .alarm_time_ms_min(alarm_time_ms_min),
        .alarm_time_ls_min(alarm_time_ls_min)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        load_new_a = 0;
        new_alarm_ms_hr = 4'd0;
        new_alarm_ls_hr = 4'd0;
        new_alarm_ms_min = 4'd0;
        new_alarm_ls_min = 4'd0;
        #10 reset = 0;

        #10 load_new_a = 1;
        new_alarm_ms_hr = 4'd1;
        new_alarm_ls_hr = 4'd2;
        new_alarm_ms_min = 4'd3;
        new_alarm_ls_min = 4'd4;
        #10 load_new_a = 0;

        #50 load_new_a = 1;
        new_alarm_ms_hr = 4'd2;
        new_alarm_ls_hr = 4'd3;
        new_alarm_ms_min = 4'd4;
        new_alarm_ls_min = 4'd5;
        #10 load_new_a = 0;

        #50 $finish;
    end

    initial begin
        $monitor("At time %t, reset = %b, load_new_a = %b, alarm_time = %d%d:%d%d",
                 $time, reset, load_new_a, alarm_time_ms_hr, alarm_time_ls_hr, alarm_time_ms_min, alarm_time_ls_min);
    end

endmodule
