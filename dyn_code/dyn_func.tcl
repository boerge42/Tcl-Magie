#!/usr/bin/tclsh
#
#    dyn_func.tcl
# ================
# Uwe Berger; 2015
#
#

# *****************************************
proc square {op} {
	return [expr $op * $op]
}

# *****************************************
proc cube {op} {
	return [expr $op * $op * $op]
}

# *****************************************
proc output {lb ub step func} {
	puts $func
	for {set i $lb} {$i <= $ub} {incr i $step} {
		puts "$i --> [$func $i]"
	}
	puts ""
}

# *****************************************
# *****************************************
# *****************************************
output 2 11 2 square
output 2 11 2 cube
