module aclk_keyreg(clock, shift, reset, key, key_ms_hr, key_ls_hr, key_ms_min, key_ls_min);
	input clock, shift, reset;
	input [3:0] key;
	output reg [3:0] key_ms_hr, key_ls_hr, key_ms_min, key_ls_min;
	
	always @(posedge clock or posedge reset)
		begin 
			if (reset)
				begin
					key_ms_hr <= 0;
					key_ls_hr <= 0;
					key_ms_min <= 0;
					key_ls_min <= 0;
				end
			else if (shift == 1)
				begin
					key_ms_hr <= key_ls_hr;
					key_ls_hr <= key_ms_min;
					key_ms_min <= key_ls_min;
					key_ls_min <= key;
				end
		end	
endmodule
			

