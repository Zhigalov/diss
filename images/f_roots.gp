#!/usr/bin/gnuplot

A(a,b)=4.0*(b+1.0)*b
B(a,b)=-1.0/sqrt(15) * (3.0/2.0*a + 4.0*a*b + 16.0*b)
C(a,b)=2.0/5.0*a

D(a,b)=B(a,b)*B(a,b)-4*A(a,b)*C(a,b)

F1(a,b)= (-B(a,b)+sqrt(D(a,b)))/2.0/A(a,b)
F2(a,b)= (-B(a,b)-sqrt(D(a,b)))/2.0/A(a,b)

# splot [a=0:5] [b=0:1] [0:3] F1(a,b), F2(a,b)

pause -1
#set nokey
#set terminal fig metric size 15 7
#set output "out.fig"

plot [a=-2:5] [-1:3] F1(a,0.025), F2(a,0.025),\
       F1(a,0.05), F2(a,0.05), F1(a,0.1), F2(a,0.1), F1(a,0.2), F2(a,0.2)
#   4*b/sqrt(15)/(b+8.0/3), b*a/sqrt(15.0) *3.0/8 * (b+8.0/3)/(b+1)

pause -1