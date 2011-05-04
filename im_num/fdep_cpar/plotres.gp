#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints

#set terminal "fig" metric size 15 9
#set output "fh.fig"

flegg=89803
gamma=20378
H=284
HR=0.003
pi=3.1415926

bb(l)=(l*2*pi/gamma/H)**2
fosc(h,l) = gamma*H/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))

ff(x)=A-B*exp((x-x1)/x0)-C/(x-x1)**2
A= 297.5
B= 3.62
C= 0.00052
x0= 0.318
x1= 0.152

#fit [0:] ff(x) "RES" using 1:3 via A,B,C,x0,x1

plot [] [0.85:1.03]\
   "RES090" using (($1-0.18)*0.1*gamma):($3/fosc(HR,flegg)) with points ps 2 pt 7 lc 1,\
   "RES085" using (($1-0.18)*0.1*gamma):($3/fosc(HR,flegg)) with points ps 2 pt 7 lc 2,\
   "RES080" using (($1-0.18)*0.1*gamma):($3/fosc(HR,flegg)) with points ps 2 pt 7 lc 3,\
   1
pause -1
 #  ff((x-0.18)*0.1*gamma)/fosc(HR,flegg),\

gg(x)=D*x - x0
x0=1
D=0.0004

#set output "th.fig"
set nokey

fit gg(x) "RES080" using (($1-0.09)*0.1*gamma):(1/$4) via x0,D

plot [0:] [0:]\
  "RES090" using (($1-0.09)*0.1*gamma):(1/$4) with points ps 2 pt 7 lc 1,\
  "RES085" using (($1-0.09)*0.1*gamma):(1/$4) with points ps 2 pt 7 lc 2,\
  "RES080" using (($1-0.09)*0.1*gamma):(1/$4) with points ps 2 pt 7 lc 3,\
 gg(x)
pause -1
