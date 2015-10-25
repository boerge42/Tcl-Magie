#
#   server1.tcl
# ================
# Uwe Berger; 2015
#
# einfacher server ohne jegliche Absicherung;
# ...ein User-Kommondo (addiere)
# 

# *********************************************
proc accept {chan addr port} {
     set cmd [gets $chan]
     puts "server rx: $cmd"
     if {[catch {puts $chan "result: [eval $cmd]"}]} {
        puts $chan "error: $cmd"}
     close $chan
}
 
# *********************************************
proc addiere {a b} {
     return [expr $a + $b]
}

# *********************************************
# *********************************************
# *********************************************

# Server-Socket definieren
socket -server accept 12345

# "ewig" an dieser Stelle warten
vwait forever
