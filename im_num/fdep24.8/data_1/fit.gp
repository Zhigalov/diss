#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints

file="res_l085tf090"
gr=0.10000000000000001
hr=3.00000000000000006E-003
tf=3.79473319220205556E-007
lf=132643.24273798766
H0=284.00000000000000

gamma=20378
pi=3.1415926

bb=(lf*2*pi/gamma/H0)**2
fosc = gamma*H0/pi * sqrt(hr/H0 * bb/sqrt(15.0)/(1+8.0/3.0*bb))

f(x) = 1 - b/(x-x1)**2 - c*exp(x - d/(x-x2))
x1=0.1
x2=0.1
a=776
b=0.001
c=0.001
#fit  f(x) file using 1:($2/fosc) via b,c,x1,x2,d
#plot file using 1:($2/fosc), f(x)
#pause -1

#plot [0:] [:1] file using (($1-0.09)*gr*gamma):($2/fosc)
#pause -1

gg(x) = A*(x-B)

fit [200:] gg(x) file using (($1-0.09)*gr*gamma):(1000.0/$3) via A,B

plot [0:] [0:] file using (($1-0.09)*gr*gamma):(1000.0/$3), gg(x)
pause -1
print "RES: ", lf, tf, A, B
