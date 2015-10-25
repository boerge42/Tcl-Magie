#
#   server1.tcl
# ================
# Uwe Berger; 2015
#
# einfacher Server mit sicherem Interpreter;
# ...ein User-Kommondo (addiere)
# 

# *********************************************
proc accept {chan addr port} {
	global si
	set cmd [gets $chan]
	puts "server rx: $cmd"
	if {[catch {puts $chan "result: [$si eval $cmd]"}]} {
		puts $chan "no!: $cmd"}
	close $chan
}
 
# *********************************************
proc addiere {a b} {
	return [expr $a + $b]
}

# *********************************************
# *********************************************
# *********************************************

# sicheren Interpreter mit zulaessigen
# Kommandos definieren...
set si [interp create -safe]
$si alias expr expr
$si alias addiere addiere

# Server-Socket definieren
socket -server accept 12345

# "ewig" an dieser Stelle warten
vwait forever
