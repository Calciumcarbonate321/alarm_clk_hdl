module alarm_clk_rtl(clk, reset, alarm_button, time_button, key, fast_watch, sound_alarm, display_ms_hr, display_ls_hr, display_ms_min, display_ls_min);

	input clk, reset, alarm_button, time_button, fast_watch;
	input [3:0] key;
	
	output [7:0] display_ms_hr, display_ls_hr, display_ms_min, display_ls_min;
	output sound_alarm;
	
	wire one_second, one_minute, load_new_c, load_new_a, show_current_time, show_a, shift, reset_count;
	wire [3:0] key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min,
			   current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min,
			   alarm_time_ms_hr, alarm_time_ls_hr, alarm_time_ms_min, alarm_time_ls_min;
	
	aclk_timegen timegen (clk, reset, reset_count, fast_watch, one_minute, one_second);
	aclk_counter counter (clk, reset, one_minute, load_new_c, key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min, current_time_ms_hr, current_time_ls_hr, current_time_ms_min, current_time_ls_min);
	aclk_areg areg(clk, reset, load_new_a, key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min, alarm_time_ms_hr, alarm_time_ls_hr, alarm_time_ms_min, alarm_time_ls_min);
	aclk_keyreg keyreg(clk, shift, reset, key, key_buffer_ms_hr, key_buffer_ls_hr, key_buffer_ms_min, key_buffer_ls_min);
	aclk_controller controller(clk, reset, one_second, alarm_button, time_button, key, reset_count, load_new_c, show_current_time, show_a, load_new_a, shift);
	aclk_lcd_display lcd_display(
				current_time_ms_hr,
				current_time_ls_hr,
				current_time_ms_min,
				current_time_ls_min,
				alarm_time_ms_hr,
				alarm_time_ls_hr,
				alarm_time_ms_min,
				alarm_time_ls_min,
				key_buffer_ms_hr,
				key_buffer_ls_hr,
				key_buffer_ms_min,
				key_buffer_ls_min,
				show_current_time,
				show_a,
				sound_alarm,
				display_ms_hr,
				display_ls_hr,
				display_ms_min,
				display_ls_min
					);
					
endmodule