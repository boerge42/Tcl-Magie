#!/usr/bin/tcl
#
#     wc.tcl
# ================
# Uwe Berger; 2015
# 
# Funktionen:
#    * Anzahl Zeichen
#    * Anzahl Zeilen
#    * Anzahl Worte
#    * Anzahl unterschiedliche Worte
#

# ********************************************
proc different_words {word_list} {
	set word_list [lsort $word_list]
	set old_word ""
	set wcount 0
	foreach w $word_list {
		if {![string equal $old_word $w]} {
			set old_word $w
			incr wcount
		}
	}	
	return $wcount	
}

# ********************************************
# ********************************************
# ********************************************

# zu untersuchende Datei ermitteln (Uebergabeparameter oder Script selbst)
if {($argc == 1) && ([file exists $argv])} {
	set fname $argv
} else {
	set fname [info script]	
}
puts "untersuchte Datei............: $fname"

# Testdatei einlesen...
set fd [open $fname r] 
set data [read $fd [file size $fname]]
close $fd

puts "[split $data ""]"

# Anzahl Zeichen
puts "Anzahl Zeichen...............: [llength [split $data ""]]"

# Anzahl Zeilen
puts "Anzahl Zeilen................: [llength [split $data \n]]"

# Anzahl Worte
set words [regexp -all -inline {\S+} $data]
puts "Anzahl Worte.................: [llength $words]"

# Anzahl unterschiedliche Worte
puts "Anzahl unterschiedliche Worte: [different_words $words]"
