#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey

#set terminal "fig"
#set output "out.fig"

f1(x)=a1*x*x*x+b1*x*x+c1*x+d1
f2(x)=a2*x*x*x+b2*x*x+c2*x+d2

f3(x)=f2(x)+cc*x+dd

fit [0.6:0.9] f1(x) "wire195" via a1,b1,c1,d1
fit [0.6:0.9] f2(x) "wire248" via a2,b2,c2,d2

fit [0.6:0.9] f3(x) "wire195" via dd,cc


plot [0.6:0.9] [20:]\
  f2(x),f3(x),\
  "wire195" with points pt 7 ps 1,\
  "wire248" with points pt 7 ps 1,\
  "wire195t1" using 1:3 with lines

#  "teor195" using ($1/2.37):2 with lines,\
#  "teor248" using 1:3 with lines\

#  "cal195c" using ( 1+ ($1-1)*(1-0.155*($1-1)) ):3,\

print "f248 = ", a1, "*x^3 + ", b1, "*x^2 + ", c1, "*x + ", d1
print "f195 = ", a1, "*x^3 + ", b1, "*x^2 + ", c1+cc, "*x + ", d1+dd

pause -1
