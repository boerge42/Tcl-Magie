#
#      du.tcl
# ================
# Uwe Berger; 2015
#
# Ermittlung von:
#    * Anzahl Verzeichnisse
#    * Anzahl Dateien
#    * Groesse aller Dateien
# ab einem, in der Kommandozeile anzugebenden
# Verzeichnis
#

# ************************************************
proc du {dir} {
	
	set fsize  0
	set fcount 0
	set dcount 0
	
	set files [glob -nocomplain -directory $dir *]
	foreach f $files {
		if {[file isdirectory $f]} {
			set result [du $f]
			set fsize  [expr $fsize  + [lindex $result 0]]
			set fcount [expr $fcount + [lindex $result 1]]
			set dcount [expr $dcount + [lindex $result 2]]
			incr dcount
		} else {
			set fsize [expr $fsize + [file size $f]]
			incr fcount
		}
	}
	return [list $fsize $fcount $dcount]
}

# ************************************************
# ************************************************
# ************************************************

# Kommandozeile untersuchen
if {$argc != 1} {
	puts "Fehler: es muss genau ein(!) Verzeichnis angeben!"
	exit
} 
if {![file isdirectory $argv]} {
	puts "Fehler: $argv ist kein Verzeichnis!"
	exit
}

# Verzeichnis-/Dateianzahl und Dateigroesse insg. berechnen
set result [du $argv]

# Ausgabe der Ergebnisse
puts "Verzeichnis.......: $argv"
puts "Unterverzeichnisse: [lindex $result 2]"
puts "Dateien insg......: [lindex $result 1]"
puts "Dateigroesse insg.: [lindex $result 0] Byte"
