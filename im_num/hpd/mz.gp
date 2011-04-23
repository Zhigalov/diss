#!/usr/bin/gnuplot

set terminal "x11"
set style data lines
set nokey

#set terminal "fig" metric size 5 5
#set output "mz.fig"

set style line 1 lc 1
set style line 2 lc 0
set style line 3 lc 3

set title "Mz" 

cell_len=0.18


plot [-2:3] [-0.3:1.1]\
  "mj0.0000.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1 lw 1.5,\
  "mj0.0181.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.0360.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.0541.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.0721.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.0900.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.1081.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.1260.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.1441.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.1621.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
  "mj0.1800.dat" using (($1/1000*0.2-0.48)/.18):5 ls 1,\
0 ls 2,\
-1/4. ls 2,\
1 ls 2

pause -1

