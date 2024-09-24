module tb_aclk_keyreg;
    reg clock;
    reg shift;
    reg reset;
    reg [3:0] key;
    wire [3:0] key_ms_hr;
    wire [3:0] key_ls_hr;
    wire [3:0] key_ms_min;
    wire [3:0] key_ls_min;

    aclk_keyreg uut (
        .clock(clock),
        .shift(shift),
        .reset(reset),
        .key(key),
        .key_ms_hr(key_ms_hr),
        .key_ls_hr(key_ls_hr),
        .key_ms_min(key_ms_min),
        .key_ls_min(key_ls_min)
    );

    initial begin
        clock = 0;
        forever #5 clock = ~clock;  
    end

    initial begin
        reset = 1;
        shift = 0;
        key = 4'b0000;

        #10 reset = 0;

        #10 shift = 1; key = 4'b0001;  
        #10 shift = 0;
        #10 shift = 1; key = 4'b0010;  
        #10 shift = 0;
        #10 shift = 1; key = 4'b0011;  
        #10 shift = 0;
        #10 shift = 1; key = 4'b0100;  
        #10 shift = 0;

        #10 reset = 1;
        #10 reset = 0;

        #10 shift = 1; key = 4'b0101;  // Shift in 5
        #10 shift = 0;
        #10 shift = 1; key = 4'b0110;  // Shift in 6
        #10 shift = 0;
        #10 shift = 1; key = 4'b0111;  // Shift in 7
        #10 shift = 0;
        #10 shift = 1; key = 4'b1000;  // Shift in 8
        #10 shift = 0;

        #20 $finish;
    end

    initial begin
        $monitor("At time %t, reset = %b, shift = %b, key = %b, key_ms_hr = %b, key_ls_hr = %b, key_ms_min = %b, key_ls_min = %b",
                 $time, reset, shift, key, key_ms_hr, key_ls_hr, key_ms_min, key_ls_min);
    end
endmodule
