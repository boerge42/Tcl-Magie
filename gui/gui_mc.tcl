#!/usr/bin/wish
#
#    gui_mc.tcl
# ================
# Uwe Berger; 2015
#
# 
#
#
#

set device /dev/ttyUSB0
set mode   9600,n,8,1
set txt_rx ""
set is_blink 0
set blink_time 1000


# *******************************************
proc gui_init {} {
	global is_blink blink_time
	wm title . "GUI-Arduino" 
	wm resizable . 0 0
	label .l_cmd -text "Command:"
	entry .cmd -width 15 -textvariable txt_tx
	button .b_send -text "Send..." -command {tx $com "$txt_tx\r"}
	label .l_rx -text "last Rx:"
	label .rx -text ""
	label .l_sled -text "Status LED:"
	label .sled -text ""
	label .l_shall -text "Status Hall:"
	label .shall -text ""
	button .b_blink -text "Blink..." -command {blink_on_off $is_blink}
	spinbox .sb_blink -from 100 -to 2000 -increment 100 -textvariable blink_time  -state disabled
	button .b_exit -text "Exit" -command {exit}
	grid .l_cmd 	-column 0 -row 0 -sticky w -padx 5
	grid .cmd 		-column 0 -row 1 -sticky w -padx 5
	grid .b_send	-column 1 -row 1 -sticky w -padx 5
	grid .l_rx 		-column 0 -row 2 -sticky w -padx 5
	grid .rx 		-column 0 -row 3 -sticky w -padx 5
	grid .l_sled 	-column 2 -row 0 -sticky w -padx 5
	grid .sled 		-column 2 -row 1 -sticky new -padx 5
	grid .l_shall 	-column 2 -row 2 -sticky w -padx 5
	grid .shall 	-column 2 -row 3 -sticky new -padx 5
	grid .b_blink	-column 0 -row 4 -padx 5 -pady 5 -sticky news
	grid .sb_blink	-column 1 -row 4 -padx 5 -pady 5 -sticky news
	grid .b_exit	-column 0 -row 5 -padx 5 -pady 5 -sticky news -columnspan 4
}

# *******************************************
proc LED {s} {
	if {[string equal $s "on"]} {
		.sled configure -text "ON" -bg yellow -fg black
	}
	if {[string equal $s "off"]} {
		.sled configure -text "OFF"  -bg black -fg white
	}
}

# *******************************************
proc HALL {s} {
	if {[string equal $s "on"]} {
		.shall configure -text "CLOSE" -bg red -fg white
	}
	if {[string equal $s "off"]} {
		.shall configure -text "OFF" -bg green -fg white
	}
}

# *******************************************
proc rx {com} {
	global txt_rx
	set c [read $com 1]
	if {($c != "\n")} {
		set txt_rx "$txt_rx$c"
	} else {
		set txt_rx [string trim $txt_rx]
		.rx configure -text $txt_rx
		catch {eval $txt_rx}
		set txt_rx ""
	}
}

# *******************************************
proc tx {com txt} {
	foreach c [split $txt ""] {
		puts -nonewline $com $c
	}
}

# *******************************************
proc blink_on_off {on} {
	global is_blink
	if {$on} {
		set is_blink 0
		.b_blink configure -text "Blink..."
		.sb_blink configure -state disabled
		.b_send configure -state normal
		.cmd configure -state normal
	} else {
		set is_blink 1			
		.b_blink configure -text "Stop blinking..."
		.sb_blink configure -state normal
		.b_send configure -state disable
		.cmd configure -state disable
	}
}

# *******************************************
proc blink {com} {
	global is_blink blink_time
	if {$is_blink} {
		tx $com "toggle\r"
	}
	after $blink_time blink $com
}

# *******************************************
# *******************************************
# *******************************************

# serielle Schnittstelle oeffnen/initialisieren
set com [open $device RDWR]
fconfigure $com -mode $mode -translation binary -buffering none -blocking 0

# Definition Ereignis --> Zeichen empfangen
fileevent $com readable {rx $com}

gui_init

after 1500
blink $com
tx $com "status\r"
