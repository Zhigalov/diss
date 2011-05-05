#!/usr/bin/gnuplot

set terminal "x11"
set style data lines
set nokey

#set terminal "fig" metric size 15 8
#set output "n.fig"

set style line 1 lc 1
set style line 2 lc 0
set style line 3 lc 3

set title "Nx" 

cell_len=0.18
ggr = 0.1 * 20378

sh1=(1500/1000.0*0.2-0.30-0.09)*ggr
sh2=(2400/1000.0*0.2-0.30-0.09)*ggr
set object 1 rect from sh1,-1 to sh2,2 fc rgb "blue" fillstyle solid 0.2 lw 0

plot [-500:1000] [-0.3:1.1]\
0 ls 2,\
1 ls 2,\
  "mj0.0000.dat" using (($1/1000*0.2-0.30-0.09)*ggr):6 ls 1 lw 1.5,\
  "mj0.0360.dat" using (($1/1000*0.2-0.30-0.09)*ggr):6 ls 1,\
  "mj0.0721.dat" using (($1/1000*0.2-0.30-0.09)*ggr):6 ls 1,\
  "mj0.1081.dat" using (($1/1000*0.2-0.30-0.09)*ggr):6 ls 1,\
  "mj0.1441.dat" using (($1/1000*0.2-0.30-0.09)*ggr):6 ls 1,\
  "mj0.1800.dat" using (($1/1000*0.2-0.30-0.09)*ggr):6 ls 1,\
\
  "mj0.0000.dat" using (($1/1000*0.2-0.30-0.09)*ggr):7 ls 1 lw 1.5,\
  "mj0.0360.dat" using (($1/1000*0.2-0.30-0.09)*ggr):7 ls 1,\
  "mj0.0721.dat" using (($1/1000*0.2-0.30-0.09)*ggr):7 ls 1,\
  "mj0.1081.dat" using (($1/1000*0.2-0.30-0.09)*ggr):7 ls 1,\
  "mj0.1441.dat" using (($1/1000*0.2-0.30-0.09)*ggr):7 ls 1,\
  "mj0.1800.dat" using (($1/1000*0.2-0.30-0.09)*ggr):7 ls 1,\
\
  "mj0.0000.dat" using (($1/1000*0.2-0.30-0.09)*ggr):8 ls 1 lw 1.5,\
  "mj0.0360.dat" using (($1/1000*0.2-0.30-0.09)*ggr):8 ls 1,\
  "mj0.0721.dat" using (($1/1000*0.2-0.30-0.09)*ggr):8 ls 1,\
  "mj0.1081.dat" using (($1/1000*0.2-0.30-0.09)*ggr):8 ls 1,\
  "mj0.1441.dat" using (($1/1000*0.2-0.30-0.09)*ggr):8 ls 1,\
  "mj0.1800.dat" using (($1/1000*0.2-0.30-0.09)*ggr):8 ls 1


pause -1

