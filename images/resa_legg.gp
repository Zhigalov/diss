#!/usr/bin/gnuplot

set terminal "x11"
set style data points
set style line 1 pt 7 ps 3
set nokey

#set terminal "fig" metric
#set output "out.fig"

b1=1
b2=1

o=922400.0
gh=1.5/7.8 * 1/0.008
ll(x)=o*o*sqrt(15.0)*x*x/(4*gh*o - 8.0/3.0 *x*x)


f1(x)=a1*(1-x)
f2(x)=a2*(1-x)

fit f1(x) "resa_legg25cw.dat" using 1:($2**2) via a1
fit f2(x) "lf248.dat" using ($1/2.35536):($2**2) via a2



#plot [:1] [0:]\
# "resa_legg25.dat" using ($1/.805):2 with points pt 7 ps 2,\
# "resa_legg25cw.dat" using 1:($2**2) with points pt 7 ps 2,\
# "lf248.dat" using ($1/2.35536):(0.314*$2**2) with lines

plot [:1] [0:]\
 "resa_legg25.dat" using 1:(sqrt($2)) with points pt 7 ps 2,\
 "resa_legg25cw.dat" using ($1*0.805):2 with points pt 7 ps 2,\
  "lf248.dat" using ($1/2.35536):2 with lines,\
  "lf248.dat" using ($1/2.35536*0.805):($2*sqrt(0.315)) with lines

print 1/sqrt(a1/a2)

# "resa_legg19.dat" using ($1):(ll($2)),\
# "fl2",\

pause -1