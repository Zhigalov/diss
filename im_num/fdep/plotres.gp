#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints
set nokey

#set terminal "fig" metric size 15 9
#set output "fh.fig"

flegg=89803
gamma=20378
H=284
HR=0.003
pi=3.1415926
grad=0.1

bb(l)=(l*2*pi/gamma/H)**2
fosc(h,l) = gamma*H/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))

# correct F2 value (for d ~ h)
AA(l)=1+bb(l)
BB(l,d,h)=-1/sqrt(15.)*(3./8. * (sqrt(15.)*d-h/H) + bb(l)*(sqrt(15.)*d+3.*h/H))
CC(l,d,h)=bb(l)/10.0 * h/H * (sqrt(15.)*d-h/H)
ffm(l,d,h) = sqrt((-BB(l,d,h)-sqrt(BB(l,d,h)**2 - 4.0*AA(l)*CC(l,d,h)))/2.0/AA(l))*gamma*H/2/pi

#ff(x)=A-B*exp((x-x1)/x0)-C/(x-x1)**2
#A= 297.5
#B= 3.62
#C= 0.00052
#x0= 0.318
#x1= 0.152
#fit [0.155:] ff(x) "RES3" using 1:2 via A,B,C,x0,x1

sh1=(1500/1000.0*0.2-0.30-0.09)*grad*gamma
sh2=(2400/1000.0*0.2-0.30-0.09)*grad*gamma
set object 1 rect from sh1,-1 to sh2,2 fc rgb "blue" fillstyle solid 0.2 lw 0


f1(x) = A1 - B1*exp(k1*x)
f2(x) = A2 - B2*exp(k2*x)
f3(x) = A3 - B3*exp(k3*x)
B1=0.005
B2=0.005
B3=0.005
k1=0.0001
k2=0.0001
k3=0.0001

fit [200:] f1(x) "RES1" using (($1-0.09)*gamma*grad):($2/fosc(0.00098,89803)) via A1,B1,k1
fit [200:] f2(x) "RES3" using (($1-0.09)*gamma*grad):($2/fosc(0.003,89803)) via  A2,B2,k2
fit [200:] f3(x) "RES6" using (($1-0.09)*gamma*grad):($2/fosc(0.006,89803)) via  A3,B3,k3

plot [0:2000] [250:300]\
   "RES3" using (($1-0.09)*gamma*grad):2 with points ps 2 pt 7 lc 2,\
   f1(x), f2(x)*fosc(0.003,89803), f3(x),fosc(0.003,89803)

#plot [0:2000] [0.68:1.03]\
#   "RES1" using (($1-0.09)*gamma*grad):($2/fosc(0.00098,89803)) with points ps 2 pt 7 lc 1,\
#   "RES3" using (($1-0.09)*gamma*grad):($2/fosc(0.003,89803)) with points ps 2 pt 7 lc 2,\
#   "RES6" using (($1-0.09)*gamma*grad):($2/fosc(0.006,89803)) with points ps 2 pt 7 lc 3,\
#   f1(x), f2(x), f3(x),1
pause -1

#   "grad02/RES" using (($1-0.09)*gamma*grad * 2 + 0.5):($2/fosc(0.003,89803)) with points ps 2 pt 3 lc 1,\

gg1(x)=(x-x1)*D1
x1=-0.5
gg2(x)=(x-x2)*D2
x2=-0.5
gg3(x)=(x-x3)*D3
x3=-0.5


set nokey
#set output "th.fig"

#fit [200:] gg1(x) "RES1" using (($1-0.09)*gamma*grad):(1/$3) via D1,x1
#fit [200:] gg2(x) "RES3" using (($1-0.09)*gamma*grad):(1/$3) via D2,x2
#fit [200:] gg3(x) "RES6" using (($1-0.09)*gamma*grad):(1/$3) via D3,x3

plot []\
  "RES1" using (($1-0.09)*gamma*grad):(1/$3) with points ps 2 pt 6 lc 1,\
  "RES3" using (($1-0.09)*gamma*grad):(1/$3) with points ps 2 pt 7 lc 1,\
  "RES6" using (($1-0.09)*gamma*grad):(1/$3) with points ps 2 pt 8 lc 1,\
  "grad02/RES" using (($1-0.09)*gamma*grad * 2 +0.5):(1/$3) with points ps 2 pt 3 lc 1,\
 gg1(x), gg2(x), gg3(x), (x+0.5)*0.159

print x1,D1
print x2,D2
print x3,D3
pause -1
