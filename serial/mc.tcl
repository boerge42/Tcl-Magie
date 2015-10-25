#!/usr/bin/tcl
#
#     mc.tcl
# ================
# Uwe Berger; 2015
#
# 
#
#
#

set device /dev/ttyUSB0
set mode   9600,n,8,1

# *******************************************
proc rx {com} {
	puts -nonewline [read $com]
}

# *******************************************
proc tx {com txt} {
	foreach c [split $txt ""] {
		puts -nonewline $com $c
	}
}

# *******************************************
proc blink {com} {
	tx $com "toggle\r"
	after 1000 blink $com
	
}

# *******************************************
# *******************************************
# *******************************************

# serielle Schnittstelle oeffnen/initialisieren
set com [open $device RDWR]
fconfigure $com -mode $mode -translation binary -buffering none -blocking 0

# Definition Ereignis --> Zeichen empfangen
fileevent $com readable {rx $com}


blink $com


vwait forever
