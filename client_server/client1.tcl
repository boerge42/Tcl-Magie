#
# Client
#

set h localhost
set p 12345

while {1} {

	puts -nonewline "> "
	flush stdout
	gets stdin cmd
	set chan [socket $h $p]
	puts $chan $cmd
	flush $chan
	puts [gets $chan]
	close $chan
	after 1000
}
