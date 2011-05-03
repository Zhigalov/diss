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

#fit [0.155:] ff(x) "RES3" using 1:2 via A,B,C,x0,x1

f1(x) = A1 - B1*exp(k1*x)
f2(x) = A2 - B2*exp(k2*x)
f3(x) = A3 - B3*exp(k3*x)

fit [0.:] f1(x) "RES1" using (($1-0.18)/0.18):($2/fosc(0.00098,89803)) via A1,B1,k1
fit [0.:] f2(x) "RES3" using (($1-0.18)/0.18):($2/fosc(0.003,89803)) via  A2,B2,k2
fit [0.:] f3(x) "RES6" using (($1-0.18)/0.18):($2/fosc(0.006,89803)) via  A3,B3,k3
plot [-0.25:4.2] [0.68:1.03]\
   "RES1" using (($1-0.18)/0.18):($2/fosc(0.00098,89803)) with points ps 2 pt 6 lc 1,\
   "RES3" using (($1-0.18)/0.18):($2/fosc(0.003,89803)) with points ps 2 pt 7 lc 1,\
   "RES6" using (($1-0.18)/0.18):($2/fosc(0.006,89803)) with points ps 2 pt 8 lc 1,\
   "grad02/RES" using (($1-0.18)/0.18 * 2 + 0.5):($2/fosc(0.003,89803)) with points ps 2 pt 3 lc 1,\
   f1(x), f2(x), f3(x),1
#   ff((x+1)*0.18)/fosc(0.003,89803), 1
#print k1, k2, k3
pause -1

gg1(x)=(x-x1)*D1
x1=-0.5
gg2(x)=(x-x2)*D2
x2=-0.5
gg3(x)=(x-x3)*D3
x3=-0.5


set nokey
#set output "th.fig"

fit [0.155:] gg1(x) "RES1" using (($1-0.18)/0.18):(1/$3) via D1,x1
fit [0.155:] gg2(x) "RES3" using (($1-0.18)/0.18):(1/$3) via D2,x2
fit [0.155:] gg3(x) "RES6" using (($1-0.18)/0.18):(1/$3) via D3,x3
plot [-0.5:4.2]\
  "RES1" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 6 lc 1,\
  "RES3" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7 lc 1,\
  "RES6" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 8 lc 1,\
  "grad02/RES" using (($1-0.18)/0.18 * 2 +0.5):(1/$3) with points ps 2 pt 3 lc 1,\
 gg1(x), gg2(x), gg3(x), (x+0.5)*0.159
print x1,D1
print x2,D2
print x3,D3
pause -1
