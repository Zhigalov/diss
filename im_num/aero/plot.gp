#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set nokey


l1=89803

H=284
HR=0.003
pi=3.1415926
gammaH=923000*2*pi
bb(l)=(l*2*pi/gammaH)**2
fosc(h,l) = gammaH/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))

print fosc(HR, l1)
#pause -1

f0=292.84


f(x)=a*x+b

fit f(x) "RESw08" using (fosc(HR, l1*sqrt(1-$1))):2 via a,b
plot [0:] [0:]\
 "RESw08" using (fosc(HR, l1*sqrt(1-$1))):2 with points ps 2 pt 7
pause -1
