for {set i 0} {$i < 64} {incr i} {
	set f "Multiplier"
	append f $i
	set_property top $f [current_fileset]
	# synth_design -top $f -name -synth_1
	# reset_run synth_1
	# close_design
	launch_runs synth_1
	wait_on_run synth_1
	launch_runs impl_1 -jobs 8
	wait_on_run impl_1
	open_run impl_1
	set r "./Multiplier/log/utilization_report_"
	append r $i ".txt"
	report_utilization -file $r -name utilization_1
	close_design
	reset_run synth_1
}
