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

w1(x)=fosc(HR, l1*sqrt(1-x))
w2=fosc(HR, l1)

#pause -1

f0=292.84

A(mm)=mm*(1-mm)
B(mm,w1,w2,k) = - (w1**2 + w2**2)*mm*(1-mm) - k
C(mm,w1,w2,k) = (w1**2 * w2**2)*mm*(1-mm) + k*(w2**2*(1-mm) + w1**2*mm)

wm(mm,w1,w2,k)=sqrt((-B(mm,w1,w2,k)\
  - sqrt(B(mm,w1,w2,k)**2 - 4*A(mm)*C(mm,w1,w2,k)))/2.0/A(mm))

wp(mm,w1,w2,k)=sqrt(-B(mm,w1,w2,k)/2.0\
  + sqrt(B(mm,w1,w2,k)**2/4. - C(mm,w1,w2,k)))

f1(x)= wm(x, w1(0.8), w2, k)

k=15800

#fit f1(x) "RESd08" using 1:3 via k

plot [0:1][0.4:]\
 "RESd00" using 1:($3/w2) with linespoints ps 2 pt 7,\
 "RESd02" using 1:($3/w2) with linespoints ps 2 pt 7,\
 "RESd04" using 1:($3/w2) with linespoints ps 2 pt 7,\
 "RESd05" using 1:($3/w2) with linespoints ps 2 pt 7,\
 "RESd06" using 1:($3/w2) with linespoints ps 2 pt 7,\
 "RESd07" using 1:($3/w2) with linespoints ps 2 pt 7,\
 "RESd08" using 1:($3/w2) with linespoints ps 2 pt 7,\
-1,\
 wm(x, w1(0.0), w2, k)/w2,\
 wm(x, w1(0.2), w2, k)/w2,\
 wm(x, w1(0.4), w2, k)/w2,\
 wm(x, w1(0.5), w2, k)/w2,\
 wm(x, w1(0.6), w2, k)/w2,\
 wm(x, w1(0.7), w2, k)/w2,\
 wm(x, w1(0.8), w2, k)/w2

print w1(0.5),  sqrt(-C(1, w1(0.5), w2, k)/B(1, w1(0.5), w2, k))

pause -1
www

plot [0:1]\
 "RESw08" using (w1($1)/w2):($2/w2) with points ps 2 pt 7,\
 "RESw07" using (w1($1)/w2):($2/w2) with points ps 2 pt 7,\
 "RESw06" using (w1($1)/w2):($2/w2) with points ps 2 pt 7,\
 "RESw05" using (w1($1)/w2):($2/w2) with points ps 2 pt 7,\
  wm(0.8, x*w2, w2 ,k)/w2,\
  wm(0.7, x*w2, w2 ,k)/w2,\
  wm(0.6, x*w2, w2 ,k)/w2,\
  wm(0.5, x*w2, w2 ,k)/w2

pause -1
