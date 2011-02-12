#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey


k=10/0.014
xx(x,y)=x*cos(f)-y*sin(f)
yy(x,y)=x*sin(f)+y*cos(f)
f=3.1415/180 * (-13)

plot "nmr_hpd.dat" using (xx($3,$2)):(yy($3,$2)) with linespoints

pause -1

set terminal "fig" metric
set output "out.fig"

plot "nmr_hpd.dat" using (-268*$1+1091):((xx($3,$2)+0.001145)*k)\
   with linespoints pt 7 ps 0.5,\
     "" using (-268*$1+1091):((yy($3,$2)+0.000505)*k)\
   with linespoints pt 7 ps 0.5

pause -1

