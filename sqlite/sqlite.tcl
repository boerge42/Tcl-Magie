#!/usr/bin/tcl
#
#    sqlite.tcl
# ================
# Uwe Berger; 2015
#
#
#

package require sqlite3

set db_name test_db.sqlite
set rows 16

# Datenbank oeffnen (oder anlegen)
sqlite3 db $db_name

# eine Tabelle anlegen (wenn noch nicht existent)
db eval "create table if not exists tab (zahl int, txt text)"

# Tabelle mit ein paar Zeilen befuellen
for {set i 0} {$i<$rows} {incr i} {
	db eval "insert into tab values ($i, 'Text No. $i')"
}
			 
# Werte aus Tabelle auslesen
puts "Select-Ergebnis als Liste:"
puts [db eval "select * from tab"] 
puts ""

puts "Select-Ergebnis als Array:"
db eval "select * from tab" values {
	parray values
} 
puts ""

puts "Select-Ergebnis als Array (ohne Array-Name):"
db eval "select * from tab" {
	puts "$zahl, $txt"
} 
puts ""


puts "...nochmal, aber mit einer eigenen Tcl-Funktion hex():"
db function hex {format 0x%02x}
db eval "select zahl, hex(zahl) as hexzahl, txt from tab" {
	puts "$zahl, $hexzahl, $txt"
} 
puts ""

# Datenbank schliessen
db close
