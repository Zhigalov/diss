#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey

#set terminal "fig"
#set output "out.fig"

set logscale x 10
plot [:10]\
  "wire195t1" using 1:3 with lines,\
  "cal195" using 1:2 with points pt 7 ps 1


pause -1
