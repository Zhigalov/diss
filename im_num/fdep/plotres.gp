#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints



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



fit [0.155:] ff(x) "RES3" using 1:2 via A,B,C,x0,x1
plot [-0.155:4.2] [0.80:1.01]\
   "RES1" using (($1-0.18)/0.18):($2/fosc(0.001,89803)) with points ps 2 pt 7,\
   "RES3" using (($1-0.18)/0.18):($2/fosc(0.003,89803)) with points ps 2 pt 7,\
   "RES6" using (($1-0.18)/0.18):($2/fosc(0.006,89803)) with points ps 2 pt 7,\
   "RES3T08" using (($1-0.18)/0.18):($2/fosc(0.003,137714)) with points ps 2 pt 7,\
   "RES3T07" using (($1-0.18)/0.18):($2/fosc(0.003,176885)) with points ps 2 pt 7,\
   ff((x+1)*0.18)/fosc(0.003,89803), 1
print fosc(0.003,89803)
pause -1

gg(x)=D/(x-x2)
x2=x1

fit [0.155:] gg(x) "RES3" using (($1-0.18)/0.18):3 via D,x2
plot [-0.42:4.2]\
  "RES1" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES6" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3T08" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3T07" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
 1/gg(x)
pause -1
