file mkdir log/utilization/
file mkdir log/timing/
for {set i 0} {$i < 43} {incr i} {
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
	set ru "./log/utilization/utilization_report_"
	append ru $i ".txt"
	report_utilization -file $ru -name utilization_1
	set rt "./log/timing/timing_report_"
	append rt $i ".txt"
	report_timing_summary -name timing_1 -file $rt
	close_design
	reset_run synth_1
}

set_property top "Multiplier_ref" [current_fileset]
launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1 -jobs 8
wait_on_run impl_1
open_run impl_1
set ru "./log/utilization/utilization_report_"
append ru "ref" ".txt"
report_utilization -file $ru -name utilization_1
set rt "./log/timing/timing_report_"
append rt "ref" ".txt"
report_timing_summary -name timing_1 -file $rt
close_design
reset_run synth_1