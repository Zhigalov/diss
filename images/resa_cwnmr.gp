#!/usr/bin/gnuplot

# 040504 aerogel f=1728 kHz P=24.8 bar


set terminal "x11"
set terminal "fig"
set output "out1.fig"

set style data lines
unset key

k=10/0.014
xx(x,y)=x*cos(f)-y*sin(f)
yy(x,y)=x*sin(f)+y*cos(f)
f=3.1415/180 * (-8)

#plot "11" using (xx($3,$2)):(yy($3,$2)) with linespoints
#pause -1

plot [-200:1200] [-0.2:] "11" using (-268*$1+660):(yy($3,$2)*1e5 + 5.04) with lines
pause -1
