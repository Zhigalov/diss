#!/usr/bin/gnuplot

set terminal "x11"
set samples 500

func(x)=A+B1*exp(-x/t1)*sin(2*3.1415926*f1*x+p1)+B2*exp(-x/t2)*sin(2*3.1415926*f2*x+p2)
func1(x)=A+B1*exp(-x/t1)+B2*exp(-x/t2)

file="f160h6.dat"
x0= 5031
x1=x0

A=0.005
B1=0.006
B2=0.006
t1=15
t2=15
f1=0.353
f2=0.434
p1=0.01
p2=0.01

#fit [x1-x0:40] func(x) file using ($1-x0):4 via f1,t1,p1,f2,t2,p2
fit [x1-x0:40] func(x) file using ($1-x0):4 via A,B1,B2,t1,t2,p1,p2
fit [x1-x0:40] func(x) file using ($1-x0):4 via A,B1,B2,f1,f2,t1,t2,p1,p2
plot [x1-x0:40] func(x), func1(x), file using ($1-x0):4, A

print file, f1*1000, f2*1000, t1, t2
pause -1
