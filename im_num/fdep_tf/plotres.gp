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

plot [] [0.65:1.03]\
   "RES090" using (($1-0.18)*0.1*gamma):($2/fosc(HR,flegg)) with points ps 2 pt 7 lc 1,\
   "RES085" using (($1-0.18)*0.1*gamma):($2/fosc(HR,flegg)) with points ps 2 pt 7 lc 2,\
   "RES080" using (($1-0.18)*0.1*gamma):($2/fosc(HR,flegg)) with points ps 2 pt 7 lc 3,\
   "RES075" using (($1-0.18)*0.1*gamma):($2/fosc(HR,flegg)) with points ps 2 pt 7 lc 4,\
   "RES070" using (($1-0.18)*0.1*gamma):($2/fosc(HR,flegg)) with points ps 2 pt 7 lc 5,\
   "RES065" using (($1-0.18)*0.1*gamma):($2/fosc(HR,flegg)) with points ps 2 pt 7 lc 5,\
   1
pause -1
 #  ff((x-0.18)*0.1*gamma)/fosc(HR,flegg),\

gg1(x)=D1*x - x1
gg2(x)=D2*x - x2
gg3(x)=D3*x - x3
gg4(x)=D4*x - x4
gg5(x)=D5*x - x5
gg6(x)=D6*x - x6

#set output "th.fig"
set nokey

fit gg1(x) "RES090" using (($1-0.09)*0.1*gamma):(1000/$3) via x1,D1
fit gg2(x) "RES085" using (($1-0.09)*0.1*gamma):(1000/$3) via x2,D2
fit gg3(x) "RES080" using (($1-0.09)*0.1*gamma):(1000/$3) via x3,D3
fit gg4(x) "RES075" using (($1-0.09)*0.1*gamma):(1000/$3) via x4,D4
fit gg5(x) "RES070" using (($1-0.09)*0.1*gamma):(1000/$3) via x5,D5
fit gg6(x) "RES065" using (($1-0.09)*0.1*gamma):(1000/$3) via x6,D6

plot [0:] [0:]\
  "RES090" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 1,\
  "RES085" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 2,\
  "RES080" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 3,\
  "RES075" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 4,\
  "RES070" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 5,\
  "RES065" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 6,\
gg1(x), gg2(x), gg3(x), gg4(x), gg5(x), gg6(x)

print D1, x1/D1
print D2, x2/D2
print D3, x3/D3
print D4, x4/D4
print D5, x5/D5
print D6, x6/D6
pause -1


