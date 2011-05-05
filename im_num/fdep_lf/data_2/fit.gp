#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints

f(x) = a + b*(x/1e6)**2 + c*(x/1e6)**4

file="res_tf090"
tf=3.79473319220205556E-007

fit f(x) file using 1:3 via a,b,c
plot f(x), file using 1:3

print "RES: ", tf,a,b,c
pause -1
