#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints

#set terminal "fig" metric size 15 9
#set output "fh.fig"

ff(x) = a*x-b
a=6.246
b=-1

fit ff(x) "RES" using ($1*1e6):(1/$2) via a,b

plot [0:] [0:] "RES" using 1:(1/$2), ff(x*1e6)
pause -1

plot [0:] "RES" using 1:3
pause -1


