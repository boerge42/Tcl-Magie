#!/usr/bin/tclsh
#
#   list_sort.tcl
# ================
# Uwe Berger; 2015
#
#

set l1 {Uwe Frank Klaus Harry Heinz Anton}

set l2 {{Uwe Berger 42} {Frank Hofmann 23} {Klaus Angler 18}\
        {Harry Unsorge 77} {Heinz Becker 33} {Anton Hasenfuss 2}}


# *****************************************
proc l_out {l} {
	foreach e $l {puts $e}
	puts ""
}

# *****************************************
# *****************************************
# *****************************************
puts "Einfache Liste:"
l_out [lsort $l1]

puts "doppelte Liste nach 2. Element:"
l_out [lsort -index 1 $l2]

puts "doppelte Liste nach 3. Element (...!):"
l_out [lsort -index 2 $l2]

puts "doppelte Liste nach 3. Element (...!):"
l_out [lsort -integer -index 2 $l2]


