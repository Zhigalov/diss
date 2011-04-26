#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set nokey

#set terminal "fig" metric
#set output "out.fig"

lf1=208808
lf2=128940
lf3=264140

H1=285
H2=279
HR=0.003
pi=3.1415926
gh1=906000*2*pi
gh2=923000*2*pi
bb1(l)=(l*2*pi/gh1)**2
bb2(l)=(l*2*pi/gh2)**2
fosc1(h,l) = gh1/pi * sqrt(h/H1 * bb1(l)/sqrt(15.0)/(1+8.0/3.0*bb1(l)))
fosc2(h,l) = gh2/pi * sqrt(h/H2 * bb2(l)/sqrt(15.0)/(1+8.0/3.0*bb2(l)))


f1(x)=a1*x
f2(x)=a2*x
f3(x)=a3*x

fit f1(x) "res_fh195a" using ($1*6.27):($2**2) via a1
fit f2(x) "res_fh195b" using ($1*6.27):($3**2) via a2
fit f3(x) "res_fh248a" via a3

plot [0:][0:]\
  f1(x),f2(x),f3(x),\
  fosc1(x, lf1),\
  fosc1(x, lf2),\
  fosc2(x, lf3),\
 "res_fh195a" using ($1*6.27):($2**2) with points pt 7 ps 2,\
 "res_fh195b" using ($1*6.27):($3**2) with points pt 7 ps 2,\
 "res_fh248a" with points pt 7 ps 2

pause -1
