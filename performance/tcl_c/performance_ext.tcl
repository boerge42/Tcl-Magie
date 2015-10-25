#!/usr/bin/tcl
#
#  performance_ext.tcl
#  ===================
#   Uwe Berger; 2015
#
#  ...ein kleiner Performance-Test mit factorial als C-Extention
#
#
load ./libfac.so

set fact 20
set count 1000


# ****************************************
# ****************************************
# ****************************************

puts [factorial $fact]

set microsec [time {for {set i 0} {$i < $count} {incr i} {set x [factorial $fact]}}]
puts "Laufzeit ($count x $fact\!: [expr [lindex $microsec 0]/1000.0]ms)"
