#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set style line 1 pt 7 ps 3
set nokey

#set terminal "fig" metric
#set output "out.fig"

plot [-0.0050:0.025]\
 "resa_sig.dat" using ($1-0.005):2 with linespoints pt 7 ps 1

pause -1
