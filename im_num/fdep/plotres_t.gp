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

ff1(x)=A1-B1*exp((x-x1)/y1)-C1/(x-x1)**2
A1= 297.5
B1= 3.62
C1= 0.00052
x1= 0.151
y1= 0.318

ff2(x)=A2-B2*exp((x-x2)/y2)-C2/(x-x2)**2
A2= 448.0
B2= 4.91
C2= 0.001
x2= 0.151
y2= 0.318

ff3(x)=A3-B3*exp((x-x3)/y3)-C3/(x-x3)**2
A3= 557.3
B3= 4.65
C3= 0.00052
x3= 0.151
y3= 0.318

ff4(x)=A4-B4*exp((x-x4)/y4)-C4/(x-x4)**2
A4= 633.0
B4= 1.11
C4= 0.00052
x4= 0.151
y4= 0.318

ll1=89803
ll2=137714
ll3=176885
ll4=208808
ll5=66502

fit [0.155:] ff1(x) "RES3" using 1:2 via A1,B1,C1,x1,y1
fit [0.155:] ff2(x) "RES3T08" using 1:2 via A2,B2,C2,x2,y2
fit [0.155:] ff3(x) "RES3T07" using 1:2 via A3,B3,C3,x3,y3
fit [0.155:] ff4(x) "RES3T06" using 1:2 via A4,B4,C4,x4,y4
plot [-0.155:4.2] [0.80:1.01]\
   ff1((x+1)*0.18)/fosc(0.003,ll1),\
   ff2((x+1)*0.18)/fosc(0.003,ll2),\
   ff3((x+1)*0.18)/fosc(0.003,ll3),\
   ff4((x+1)*0.18)/fosc(0.003,ll4),\
   "RES3"     using (($1-0.18)/0.18):($2/fosc(0.003,ll1)) with points ps 2 pt 7 lc 1,\
   "RES3T08"  using (($1-0.18)/0.18):($2/fosc(0.003,ll2)) with points ps 2 pt 7 lc 2,\
   "RES3T07"  using (($1-0.18)/0.18):($2/fosc(0.003,ll3)) with points ps 2 pt 7 lc 3,\
   "RES3T06"  using (($1-0.18)/0.18):($2/fosc(0.003,ll4)) with points ps 2 pt 7 lc 4,\
   "RES3T094" using (($1-0.18)/0.18):($2/fosc(0.003,ll5)) with points ps 2 pt 6 lc 1,\
   1

print A1,B1,C1,x1,y1
print A2,B2,C2,x2,y2
print A3,B3,C3,x3,y3
print A4,B4,C4,x4,y4

pause -1

set nokey

gg1(x)=D1*(x - E1)
gg2(x)=D2*(x - E2)
gg3(x)=D3*(x - E3)
gg4(x)=D4*(x - E4)

E1=-0.5
E2=-0.5
E3=-0.5
E4=-0.5

fit [0.155:] gg1(x) "RES3" using (($1-0.18)/0.18):(1/$3) via D1
fit [0.155:] gg2(x) "RES3T08" using (($1-0.18)/0.18):(1/$3) via D2
fit [0.155:] gg3(x) "RES3T07" using (($1-0.18)/0.18):(1/$3) via D3
fit [0.155:] gg4(x) "RES3T06" using (($1-0.18)/0.18):(1/$3) via D4
plot [-0.5:4.2]\
  "RES3" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3T08" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3T07" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3T06" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 7,\
  "RES3T094" using (($1-0.18)/0.18):(1/$3) with points ps 2 pt 6,\
 gg1(x), gg2(x),  gg3(x), gg4(x)

print A1,B1,C1,x1,y1
print A2,B2,C2,x2,y2
print A3,B3,C3,x3,y3
print A4,B4,C4,x4,y4
print D1,E1
print D2,E2
print D3,E3
print D4,E4

pause -1
