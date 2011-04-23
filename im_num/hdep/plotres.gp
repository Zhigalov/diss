#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints

gamma=20378
H=284
pi=3.1415926

bb(l)=(l*2*pi/gamma/H)**2
fosc(h,l) = gamma*H/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))


plot [0:11]\
  "RES08" using 1:($2**2) with points ps 2 pt 7,\
  "RES09" using 1:($2**2) with points ps 2 pt 7,\
  fosc(x/1000,89803)**2,\
  fosc(x/1000,137714)**2
pause -1


f(x)=a*x**2+b*x+c
fit f(x) "RES09" using 1:3 via a,b,c
plot [0:11]\
  "RES08" using 1:3 with points ps 2 pt 7,\
  "RES09" using 1:3 with points ps 2 pt 7,\
  f(x)
pause -1
