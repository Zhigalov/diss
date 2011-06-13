#!/usr/bin/gnuplot

set terminal "x11"
set samples 500
set style data linespoints
set nokey

#set terminal "fig" metric size 15 9
#set output "fh.fig"

DD(lf,tf) = a1 * 1e-6/tf - a2 * 1e-6/tf * (lf/1e6)**2
#a1=0.1699
#a2=0.4187
a1=0.1693
a2=0.4146


l1 = 66502  # 0.94 Tc
l2 = 89803  # 0.90 Tc
l3 = 115099 # 0.85 Tc
l4 = 138144 # 0.80 Tc
l5 = 158626 # 0.75 Tc
l6 = 177240 # 0.70 Tc
l7 = 194060 # 0.65 Tc
l8 = 209091 # 0.60 Tc

TF1 = 4.8990e-7
TF2 = 3.7947e-7
TF3 = 3.0984e-7
TF4 = 2.6766e-7
TF5 = 2.3952e-7
TF6 = 2.1872e-7
TF7 = 2.0255e-7
TF8 = 1.8950e-7

gamma=20378
H=284
HR=0.003
pi=3.1415926
x0=2113*HR
x0=3633*HR

plot [0:] [0:]\
  "res_t094a" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 1,\
  "res_t090" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 2,\
  "res_t085" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 3,\
  "res_t080b" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 4,\
  "res_t075a" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 5,\
  "res_t070a" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 6,\
  "res_t065b" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 7,\
  "res_t060a" using (($1-0.09)*0.1*gamma):(1000/$3) with points ps 2 pt 7 lc 8,\
 DD(l1,TF1)*(x-x0),\
 DD(l2,TF2)*(x-x0),\
 DD(l3,TF3)*(x-x0),\
 DD(l4,TF4)*(x-x0),\
 DD(l5,TF5)*(x-x0),\
 DD(l6,TF6)*(x-x0),\
 DD(l7,TF7)*(x-x0),\
 DD(l8,TF8)*(x-x0),\
 0 
pause -1



