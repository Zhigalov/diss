#!/usr/bin/gnuplot

A(a,b)=4.0*(1.0/b+1) 
B(a,b)=-1.0/sqrt(15) * (3.0/2.0*b*a+4.0*a+16.0) 
C(a,b)=2.0/5.0*b*a

D(a,b)=B(a,b)*B(a,b)-4*A(a,b)*C(a,b)

F1(a,b)= (-B(a,b)+sqrt(D(a,b)))/2/A(a,b)
F2(a,b)= (-B(a,b)-sqrt(D(a,b)))/2/A(a,b)

#splot [a=0:10] [b=0:10] [0:] F1(a,b), F2(a,b)

#b=0.2
#

#plot [a=0:10] [0:] F1(a,0.1), F1(a,0.5), F1(a,1), F1(a,1.5), F1(a,2), F1(a,3)

b=40.0

set terminal fig metric size 15 7
set output "pic1.fig"

plot [a=0:5] [0:3] F1(a,5), F2(a,5), F1(a,10), F2(a,10), F1(a,20), F2(a,20), F1(a,40), F2(a,40)
#   4*b/sqrt(15)/(b+8.0/3), b*a/sqrt(15.0) *3.0/8 * (b+8.0/3)/(b+1)

pause -1