#!/usr/bin/gnuplot

#   180504
# 1 180504.hpd   15:27-17:33  U=1V  wire=31  T=0.45Tc legg=265842
# 2 180504a.hpd  15:27-17:33  U=0.1..2.0V  wire=22.7-27.5
# 3 180504b.hpd  17:33-18:35  U=0.5V  wire=27-34
# 4 180504c.hpd  18:35-19:53  U=0.5V  wire=34-40 T=0.48-0.54 
# 5 180504d.hpd  19:53-??     U=0.5V  wire=40 T=0.54Tc legg=247437

# bulk, 24.8 bar, 906.5 Hz

set terminal "x11"
set style data points
set style line 1 pt 7 ps 3
set nokey

#set terminal "fig" metric
#set output "out.fig"

#u1=1.50 #180504/10
#u3=1.95 #180504/11
#u4=7.30 #180504/12
#u5=3.10 #180504/13

u1=1.27 #180504/10
u3=1.84 #180504/11
u4=6.97 #180504/12
u5=2.87 #180504/13

l1=265842
l2=247437

gamma=20378

H=284
pi=3.1415926
gammaH=gamma*H
bb(l)=(l*2*pi/gammaH)**2
fosc(h,l) = gammaH/pi * sqrt(h/H * bb(l)/sqrt(15.0)/(1+8.0/3.0*bb(l)))

f(x)=f0-f1*exp(x/k)
f0=580
f1=1
k=10000

plot [-400:1800][0.75:1.05]\
 "treat1" using (-268*($6-u1)):($4/fosc(0.00627/2,l1)) ls 1 lc 1,\
       "" using (-268*($6-u1)):($5/fosc(0.00627/2,l1)) ls 1 lc 1 pt 6,\
 "treat5" using (-268*($5-u5)):($3/fosc(0.003135/2,l2)) ls 1 lc 4,\
       "" using (-268*($5-u5)):($4/fosc(0.003135/2,l2)) ls 1 lc 4 pt 6,\
 "num_data" using (($1)*0.1*gamma):($2/fosc(0.003135/2,l2)) with points ps 2 pt 5 lc 1,\
 "cw" using (-268*($1-u5)):($2*0.7e2+0.761) with lines,1

print fosc(6.27,242680)
pause -1

#plot [0:]\
# "treat1" using (-268*($6-u1)):($4/809) ls 1 lc 1,\
#       "" using (-268*($6-u1)):($5/809) ls 1 lc 1 pt 6,\
# "treat3" using (-268*($5-u3)):($3/579) ls 1 lc 2,\
#       "" using (-268*($5-u3)):($4/579) ls 1 lc 2 pt 6,\
# "treat4" using (-268*($5-u4)):($3/566) ls 1 lc 3,\
#       "" using (-268*($5-u4)):($4/566) ls 1 lc 3 pt 6,\
# "treat5" using (-268*($5-u5)):($3/547) ls 1 lc 4,\
#       "" using (-268*($5-u5)):($4/547) ls 1 lc 4 pt 6,\
# "cw" using (-268*($1-u5)):($2*0.7e2+0.85) with lines
#
#
#pause -1
