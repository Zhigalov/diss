#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints



flegg=89803
gamma=20378
H=284
HR=0.003
pi=3.1415926

bb=(flegg*2*pi/gamma/H)**2
fosc(h) = gamma*H/pi * sqrt(h/H * bb/sqrt(15.0)/(1+8.0/3.0*bb))

ff(x)=A-B*exp((x-x1)/x0)-C/(x-x1)**2
A= 297.5
B= 3.62
C= 0.00052
x0= 0.318
x1= 0.152



fit [0.155:] ff(x) "RES3" using 1:2 via A,B,C,x0,x1
plot [-0.155:4.2] [0.80:1.01]\
   "RES1" using (($1-0.18)/0.18):($2/fosc(0.001)) with points ps 2 pt 7,\
   "RES3" using (($1-0.18)/0.18):($2/fosc(0.003)) with points ps 2 pt 7,\
   "RES6" using (($1-0.18)/0.18):($2/fosc(0.006)) with points ps 2 pt 7,\
   "RES3" using (($1-0.18)/0.18):($4/fosc(0.003)) with points ps 2 pt 7,\
   ff((x+1)*0.18)/fosc(0.003), 1
print fosc(0.003)
pause -1

gg(x)=D/(x-x2)
x2=x1

fit [0.155:] gg(x) "RES3" using (($1-0.18)/0.18):3 via D,x2
plot [-0.42:4.2]\
  "RES1" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES6" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
 1/gg(x)
pause -1
