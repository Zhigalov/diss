#!/usr/bin/gnuplot

set terminal "x11"
set style data lines
set nokey

#set terminal "fig" metric size 5 5

set style line 1 lc 1
set style line 2 lc 0
set style line 3 lc 3

set xyplane 0
#set view 52,80
set view 42,110
set isosamples 11,2


cell_len=0.18
ggr = 0.1 * 20378

t2f(x) = (x/1000*0.2-0.18-cell_len/2)*ggr

f1=-500
f2=220

set title "Mx"
#set output "mx.fig"
splot [0:1] [f1:f2] [0:1]\
1 lc 0,\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):4 ls 1 lw 1.5,\
0 lc 0
pause -1

set title "My"
#set output "my.fig"
splot [0:1] [f1:f2] [-0.1:1]\
1 lc 0,\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):5 ls 1 lw 1.5,\
0 lc 0
pause -1

set title "Mz"
#set output "mz.fig"
splot [0:1] [f1:f2] [-0.3:1]\
1 lc 0,\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):6 ls 1 lw 1.5,\
0 lc 0
pause -1


set title "Nx"
#set output "nx.fig"
splot [0:1] [f1:f2] [-0.1:1]\
1 lc 0,\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):7 ls 1 lw 1.5,\
0 lc 0
pause -1

set title "Ny"
#set output "ny.fig"
splot [0:1] [f1:f2] [-0.1:1]\
1 lc 0,\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):8 ls 1 lw 1.5,\
0 lc 0
pause -1

set title "Nz"
#set output "nz.fig"
splot [0:1] [f1:f2] [-0.1:1]\
1 lc 0,\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):9 ls 1 lw 1.5,\
0 lc 0
pause -1


set title "T"
#set output "t.fig"
splot [0:1] [f1:f2] []\
  "mj_flt.dat" using ($1/0.18):(t2f($2)):(cos($10)) ls 1 lw 1.5,\
-1/4. lc 0
pause -1



