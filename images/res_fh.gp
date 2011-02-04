#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey

set terminal "fig" metric
set output "out.fig"

f1(x)=a1*x
f2(x)=a2*x
f3(x)=a3*x

fit f1(x) "res_fh195a" using ($1*6.27):($2**2) via a1
fit f2(x) "res_fh195b" using ($1*6.27):($3**2) via a2
fit f3(x) "res_fh255a" via a3

plot [0:][0:]\
  f1(x),f2(x),f3(x),\
 "res_fh195a" using ($1*6.27):($2**2) with points pt 7 ps 2,\
 "res_fh195b" using ($1*6.27):($3**2) with points pt 7 ps 2,\
 "res_fh255a" with points pt 7 ps 2

pause -1
