module aclk_timegen(clk, reset, reset_count, fast_watch, one_minute, one_second);
	input clk, reset, reset_count, fast_watch;
	output one_minute, one_second;
	
	reg [13:0] counter;
	reg one_second; 
	reg one_minute_reg;
	reg one_minute;
	
	
	//one minute 
	always @ (posedge clk or posedge reset)
		begin 
			if (reset)
				begin
					counter <= 14'b0;
					one_minute_reg <= 0;
				end
			else if (reset_count)
				begin
					counter <= 14'b0;
					one_minute_reg <= 1'b0;
				end
			else if (counter[13:0] == 14'd15359)
				begin	
				counter <= 14'b0;
				one_minute_reg <= 1'b1;
				end
			else 
				begin
					counter <= counter +  1'b1;
					one_minute_reg <= 1'b0;
				end
		end
	
	//one second
	always @ (posedge clk or posedge reset)
		begin 
			if (reset)
				begin
					one_second <= 0;
				end
			else if (reset_count)
				begin
					one_second <= 1'b0;
				end
			else if (counter[7:0] == 8'd255)
				begin	
				one_second <= 1'b1;
				end
			else 
				begin
					one_second <= 1'b0;
				end
		end
	
	//fast watch
	always @ (*)
		begin
			if (fast_watch)
				one_minute = one_second;
			else one_minute = one_minute_reg;
			
		end
		
endmodule