transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/alarm_clk_rtl.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_timegen.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_lcd_driver.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_lcd_display.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_keyreg.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_counter.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_controller.v}
vlog -vlog01compat -work work +incdir+D:/maven_silicon_alarm_clock/rtl {D:/maven_silicon_alarm_clock/rtl/aclk_areg.v}

