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

bb(l)=(l*2*pi/gamma/H)**2
fosc(h,l) = gamma*H/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))


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

gamma=20378
grad=0.1
H=284
HR=0.003
pi=3.1415926
x0=2113*HR
cell_len=0.18

ff1(x)=A1-B1*exp(x/y1)-C1/(x-x1)
A1= 1
B1= 0.010
C1= 0.1
x1= 148
y1= 424

ff2(x)=A2-B2*exp(x/y2)-C2/(x-x2)
A2= 1
B2= 0.010
C2= 1
x2= 148
y2= 455

ff3(x)=A3-B3*exp(x/y3)-C3/(x-x3)
A3= 1
B3= 0.013
C3= 30
x3= 148
y3= 705

ff4(x)=A4-B4*exp(x/y4)-C4/(x-x4)
A4= 1
B4= 0.011
C4= 170
x4= 148
y4= 705

ff5(x)=A5-B5*exp(x/y5)-C5/(x-x5)
A5= 1
B5= 0.018
C5= 763
x5= 148
y5= 886


ff6(x)=A6-B6*exp(x/y6)-C6/(x-x6)
A6= 1
B6= 0.022
C6= 5681
x6= 148
y6= 1017


cm_hz(x) = (x-cell_len/2)*grad*gamma


fit [0.155:] ff1(x) "res_t090"  using (cm_hz($1)):($2/fosc(0.003,l2)) via A1,B1,C1,y1
fit [0.155:] ff2(x) "res_t080b" using (cm_hz($1)):($2/fosc(0.003,l4)) via A2,B2,C2,y2
fit [0.155:] ff3(x) "res_t070a" using (cm_hz($1)):($2/fosc(0.003,l6)) via A3,B3,C3,y3
fit [0.155:] ff4(x) "res_t060a" using (cm_hz($1)):($2/fosc(0.003,l8)) via A4,B4,C4,y4

#  "res_t094a" using (cm_hz($1)):($2/fosc(0.003,l1)) with points ps 2 pt 7 lc 1,\
#  "res_t085b" using (cm_hz($1)):($2/fosc(0.003,l3)) with points ps 2 pt 7 lc 3,\
#  "res_t075a" using (cm_hz($1)):($2/fosc(0.003,l5)) with points ps 2 pt 7 lc 5,\
#  "res_t065a" using (cm_hz($1)):($2/fosc(0.003,l7)) with points ps 2 pt 7 lc 7,\
#   ff1(x),\
#   ff3(x),\
#   ff5(x),\

plot [0:] [0.8:1.02]\
  "res_t090" using (cm_hz($1)):($2/fosc(0.003,l2)) with points ps 2 pt 7 lc 2,\
  "res_t080b" using (cm_hz($1)):($2/fosc(0.003,l4)) with points ps 2 pt 7 lc 4,\
  "res_t070a" using (cm_hz($1)):($2/fosc(0.003,l6)) with points ps 2 pt 7 lc 6,\
  "res_t060a" using (cm_hz($1)):($2/fosc(0.003,l8)) with points ps 2 pt 7 lc 8,\
   ff1(x),\
   ff2(x),\
   ff3(x),\
   ff4(x),\
  1
print A1,A2,A3,A4,A5,A6
print B1,B2,B3,B4,B5,B6
print C1,C2,C3,C4,C5,C6
print x1,x2,x3,x4,x5,x6
print y1,y2,y3,y4,y5,y6
pause -1


#   ff1(x),\
#   ff2(x),\
#   ff3(x),\
#   ff4(x),\
