module tb_aclk_counter;

    reg clk;
    reg reset;
    reg one_minute;
    reg load_new_c;
    reg [3:0] new_current_time_ms_hr;
    reg [3:0] new_current_time_ls_hr;
    reg [3:0] new_current_time_ms_min;
    reg [3:0] new_current_time_ls_min;

    wire [3:0] current_time_ms_hr;
    wire [3:0] current_time_ls_hr;
    wire [3:0] current_time_ms_min;
    wire [3:0] current_time_ls_min;

    aclk_counter uut (
        .clk(clk),
        .reset(reset),
        .one_minute(one_minute),
        .load_new_c(load_new_c),
        .new_current_time_ms_hr(new_current_time_ms_hr),
        .new_current_time_ls_hr(new_current_time_ls_hr),
        .new_current_time_ms_min(new_current_time_ms_min),
        .new_current_time_ls_min(new_current_time_ls_min),
        .current_time_ms_hr(current_time_ms_hr),
        .current_time_ls_hr(current_time_ls_hr),
        .current_time_ms_min(current_time_ms_min),
        .current_time_ls_min(current_time_ls_min)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        one_minute = 0;
        load_new_c = 0;
        new_current_time_ms_hr = 4'd0;
        new_current_time_ls_hr = 4'd0;
        new_current_time_ms_min = 4'd0;
        new_current_time_ls_min = 4'd0;

        #10 reset = 0;

        #10 load_new_c = 1;
        new_current_time_ms_hr = 4'd1;
        new_current_time_ls_hr = 4'd2;
        new_current_time_ms_min = 4'd3;
        new_current_time_ls_min = 4'd4;
        #10 load_new_c = 0;

        #50 one_minute = 1;
        #10 one_minute = 0;

        #500000 one_minute = 1;
        #10 one_minute = 0;

        #500000 $finish;
    end

    initial begin
        $monitor("At time %t, reset = %b, one_minute = %b, load_new_c = %b, current_time = %d%d:%d%d",
                 $time, reset, one_minute, load_new_c, current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min);
    end

endmodule
