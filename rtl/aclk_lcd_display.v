module aclk_lcd_display(
				current_time_ms_hr,
				current_time_ls_hr,
				current_time_ms_min,
				current_time_ls_min,
				alarm_time_ms_hr,
				alarm_time_ls_hr,
				alarm_time_ms_min,
				alarm_time_ls_min,
				key_ms_hr,
				key_ls_hr,
				key_ms_min,
				key_ls_min,
				show_new_time,
				show_a,
				sound_alarm,
				display_ms_hr,
				display_ls_hr,
				display_ms_min,
				display_ls_min
					);
					
	input [3:0] current_time_ms_hr,
				current_time_ls_hr,
				current_time_ms_min,
				current_time_ls_min,
				alarm_time_ms_hr,
				alarm_time_ls_hr,
				alarm_time_ms_min,
				alarm_time_ls_min,
				key_ms_hr,
				key_ls_hr,
				key_ms_min,
				key_ls_min;
	input show_new_time, show_a;
	
	output [7:0] display_ms_hr,
				display_ls_hr,
				display_ms_min,
				display_ls_min;
	output sound_alarm;
	
	wire sound_a1, sound_a2, sound_a3, sound_a4;
	assign sound_alarm = sound_a1 & sound_a2 & sound_a3 & sound_a4;
	
	aclk_lcd_driver MS_HR (alarm_time_ms_hr, current_time_ms_hr, key_ms_hr, show_a, show_new_time, display_ms_hr, sound_a1);
	aclk_lcd_driver LS_HR (alarm_time_ls_hr, current_time_ls_hr, key_ls_hr, show_a, show_new_time, display_ls_hr, sound_a2);
	aclk_lcd_driver MS_MIN (alarm_time_ms_min, current_time_ms_min, key_ms_min, show_a, show_new_time, display_ms_min, sound_a3);
	aclk_lcd_driver LS_MIN (alarm_time_ls_min, current_time_ls_min, key_ls_min, show_a, show_new_time, display_ls_min, sound_a4);
	
endmodule



	