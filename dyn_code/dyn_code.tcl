#!/usr/bin/tclsh
#
#    dyn_var.tcl
# ================
# Uwe Berger; 2015
#
#

set count 20

# Variablen erzeugen und mit Werten belegen
for {set i 0} {$i<$count} {incr i} {
	set v$i [expr $i * 42]
}

# Variablenname und -inhalt ausgeben
for {set i 0} {$i<$count} {incr i} {
	puts "v$i=[set v$i]"
}
