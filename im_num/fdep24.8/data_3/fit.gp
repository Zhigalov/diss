#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints
set nokey

f1(x) = a*x

fit f1(x) "res" using (1e-6/$1):2 via a
plot [0:] [0:] f1(x), "res" using (1e-6/$1):2 with points pt 7 ps 2
print a
pause -1


f2(x) = - a*x - b*x**2

fit f2(x) "res" using (1e-6/$1):3 via a,b
plot [0:] [:0] f2(x), "res" using (1e-6/$1):3 with points pt 7 ps 2
print a,b
pause -1


f3(x) = a*x**2 + b*x**4

fit f3(x) "res" using (1e-6/$1):4 via a,b
plot [0:] [0:] f3(x), "res" using (1e-6/$1):4 with points pt 7 ps 2
print a
pause -1


