#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey

#set terminal "fig" metric size 8 5
#set output "out.fig"

plot [-0.01:0.16] [-0.6:0.6] "../data/exp2003/170703d.hpd/8b" using ($1-0.03):2\
   with linespoints pt 7 ps 0.5

pause -1

#set output "out1.fig"

plot [0.03:0.05] [] "../data/exp2003/170703d.hpd/8b" using ($1-0.03):2\
   with linespoints pt 7 ps 0.5

pause -1

