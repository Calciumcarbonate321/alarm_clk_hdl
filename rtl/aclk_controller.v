module aclk_controller(clk, rst, one_second, alarm_button, time_button, key, reset_count, load_new_c, show_new_time, show_a, load_new_a, shift);
	
	input clk, rst, one_second, alarm_button, time_button;
	input [3:0] key;
	
	output reset_count, load_new_c, show_new_time, show_a, load_new_a, shift;	
	
	reg [2:0] state, next_state;
	wire time_out;
	reg [3:0] count0, count1;
	
	parameter SHOW_TIME = 3'b000;
	parameter KEY_ENTRY = 3'b001;
	parameter KEY_STORED = 3'b010;
	parameter SHOW_ALARM = 3'b011;
	parameter SET_ALARM_TIME = 3'b100;
	parameter SET_CURRENT_TIME = 3'b101;
	parameter KEY_WAITED = 3'b110;
	parameter NOKEY = 10;
	
	//key entry 10s timer
	always @ (posedge clk or posedge rst)
		begin 
			if (rst)
				count0 <= 4'd0;
			else if (state != KEY_ENTRY)
				count0<= 4'd0;
			else if (count0 == 9)
				count0 <= 4'd0;
			else if (one_second)
				count0 <= count0 + 1'b1;
		end
	
	//key waited 10s timer
	always @ (posedge clk or posedge rst)
		begin 
			if (rst)
				count1 <= 4'd0;
			else if (state != KEY_WAITED)
				count1 <= 4'd0;
			else if (count1 == 9)
				count1 <= 4'd0;
			else if (one_second)
				count1 <= count1 + 1'b1;
		end
		
	assign time_out = ((count0 == 9) || (count1 == 9)) ? 0 : 1;
	
	//current state sequential logic
	always @ (posedge clk or posedge rst)
		begin 
			if (rst)
				state <= SHOW_TIME;
			else 
				state <= next_state;
		end
	
	//next state decoder
	
	always @ (state or key or alarm_button or time_button or time_out)
		begin
			case (state)
				SHOW_TIME: begin
					if (alarm_button) next_state <= SHOW_ALARM;
					else if (key != NOKEY) next_state <= KEY_STORED;
					else next_state <= SHOW_TIME;
				end
				KEY_STORED: next_state <= KEY_WAITED;
				KEY_WAITED: begin
					if (key == NOKEY) next_state <= KEY_ENTRY;
					else if (time_out == 0) next_state <= SHOW_TIME;
					else next_state <=  KEY_WAITED;
				end
				KEY_ENTRY: begin	
					if (alarm_button) next_state <= SET_ALARM_TIME;
					else if (time_button) next_state <= SET_CURRENT_TIME;
					else if (time_out == 0) next_state <= SHOW_TIME;
					else if (key != NOKEY) next_state <= KEY_STORED;
					else next_state <= KEY_ENTRY;
				end
				SHOW_ALARM: begin
					if (!alarm_button) next_state <= SHOW_TIME;
					else next_state <= SHOW_ALARM;
				end
				SET_ALARM_TIME: next_state <= SHOW_TIME;
				SET_CURRENT_TIME: next_state <=  SHOW_TIME;
				default: next_state <= SHOW_TIME;
			endcase
		end
		
	assign show_new_time = (state == KEY_ENTRY || state == KEY_STORED || state == KEY_WAITED) ? 1: 0;
	assign show_a = (state == SHOW_ALARM) ? 1: 0;
	assign load_new_a = (state == SET_ALARM_TIME) ? 1: 0;
	assign load_new_c = (state == SET_CURRENT_TIME) ? 1: 0;
	assign reset_count = (state == SET_CURRENT_TIME) ? 1: 0;
	assign shift = (state == KEY_STORED) ? 1: 0;
	
endmodule
	
		
		
						
	
	