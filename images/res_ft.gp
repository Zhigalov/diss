#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey


#set terminal "fig" metric
#set output "out.fig"

o=923000.0
gh=0.8/6.15 * 1/0.008

ll(x)=o*o*sqrt(15.0)*x*x/(4*gh*o - 8.0/3.0 *x*x)
#ll(x)=o*o*sqrt(15.0)*x*x/(4*gh*o)

plot [0.65:1]\
 "res_ft_t" using 1:($2**2) with lines,\
 "res_ft" using 1:(ll($3)) with points pt 7 ps 2

pause -1
