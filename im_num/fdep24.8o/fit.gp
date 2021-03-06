#!/usr/bin/gnuplot

set terminal "x11"
set samples 500

func(x)=A+B*exp(-x/t)*sin(2*3.1415926*f*x+p)
func1(x)=A+B*exp(-x/t)

file="f900.dat"
x0=5781.2
x1=x0
dx=10

A=0.005
B=0.006
t=1
f=0.537
p=0.01

#fit [x1-x0:dx] func(x) file using ($1-x0):4 via f,t,p
fit [x1-x0:dx] func(x) file using ($1-x0):4 via A,B,t,f,p
plot [x1-x0:dx] func(x), func1(x), file using ($1-x0):4, A

print file, f*1000, t
pause -1
