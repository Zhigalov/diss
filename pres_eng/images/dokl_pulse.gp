#!/usr/bin/gnuplot

set nokey
set terminal x11

#set terminal fig metric size 15 7
#set output "out.fig"

d2r=3.1415926/180.0

plot [0:180] (cos(d2r*x)>-1/4.0)?0: - 4/15.*(1 + 4*cos(d2r*x))

pause -1