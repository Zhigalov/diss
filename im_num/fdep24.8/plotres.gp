#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints

#set terminal "fig" metric size 15 9
#set output "fh.fig"

flegg=247437
gamma=20378
H=284
HR=0.00157
pi=3.1415926

bb(l)=(l*2*pi/gamma/H)**2
fosc(h,l) = gamma*H/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))

ff(x)=A-B*exp((x-x1)/x0)-C/(x-x1)**2
A= 297.5
B= 3.62
C= 0.00052
x0= 0.318
x1= 0.152

fit [0:] ff(x) "RES" using 1:2 via A,B,C,x0,x1

plot [-0.25:4.2] [0.85:1.03]\
   "RES" using (($1-0.18)/0.18):($2/fosc(HR,flegg)) with points ps 2 pt 6 lc 1,\
   ff((x-0.18)/0.18)/fosc(HR,flegg),\
   1
pause -1

gg(x)=D/(x+0.5)
x2=x1

#set output "th.fig"
set nokey

fit [0.155:] gg(x) "RES" using (($1-0.18)/0.18):3 via D
plot [-0.5:4.2]\
  "RES" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 6 lc 1,\
 1/gg(x)
pause -1
