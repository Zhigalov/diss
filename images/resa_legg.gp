#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set style line 1 pt 7 ps 3
set nokey

#set terminal "fig" metric
#set output "out.fig"

b1=1
b2=1

o=922400.0
gh=1.5/7.8 * 1/0.008
ll(x)=o*o*sqrt(15.0)*x*x/(4*gh*o - 8.0/3.0 *x*x)


f(x)=a*(1-x)

fit f(x) "resa_legg25cw.dat" using 1:($2**2) via a

plot [:1] [0:]\
 "resa_legg25.dat" using ($1/.805):2 with points pt 7 ps 2,\
 "resa_legg25cw.dat" using 1:($2**2) with points pt 7 ps 2

# "resa_legg19.dat" using ($1):(ll($2)),\
# "fl2",\

pause -1