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

f1(x)=fosc(HR, l1*sqrt(1-x))
f2=fosc(HR, l1)

#pause -1

f0=292.84

A(mm)=mm*(1-mm)
B(mm,f1,f2,k) = - 4*pi**2 * (f1**2 + f2**2)*mm*(1-mm) - k
C(mm,f1,f2,k) = 16*pi**4 * (f1**2 * f2**2)*mm*(1-mm) + 4*pi**2 * k*(f2**2*(1-mm) + f1**2*mm)

fm(mm,f1,f2,k)=sqrt((-B(mm,f1,f2,k)\
  - sqrt(B(mm,f1,f2,k)**2 - 4*A(mm)*C(mm,f1,f2,k)))/2.0/A(mm)) / 2/pi

fp(mm,f1,f2,k)=sqrt(-B(mm,f1,f2,k)/2.0\
  + sqrt(B(mm,f1,f2,k)**2/4. - C(mm,f1,f2,k))) / 2/pi

ff1(x)= fm(x, f1(0.8), f2, k)

k=15800

fit [:0.99] ff1(x) "RESd08" using 1:3 via k

plot [0:1][0.4:]\
 "RESd00" using 1:($3/f2) with linespoints ps 2 pt 7,\
 "RESd02" using 1:($3/f2) with linespoints ps 2 pt 7,\
 "RESd04" using 1:($3/f2) with linespoints ps 2 pt 7,\
 "RESd06" using 1:($3/f2) with linespoints ps 2 pt 7,\
 "RESd08" using 1:($3/f2) with linespoints ps 2 pt 7,\
-1,\
-1,\
-1,\
 fm(x, f1(0.0), f2, k)/f2,\
 fm(x, f1(0.2), f2, k)/f2,\
 fm(x, f1(0.4), f2, k)/f2,\
 fm(x, f1(0.6), f2, k)/f2,\
 fm(x, f1(0.8), f2, k)/f2

print f1(0.5),  sqrt(-C(1, f1(0.5), f2, k)/B(1, f1(0.5), f2, k))

pause -1