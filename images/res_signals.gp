#!/usr/bin/gnuplot

# опт.градиент +18
# град -211

set terminal "x11"

#set terminal "fig"
#set output "b.fig"

set style data lines
set nokey

plot\
  "exp2003/030703.HPD/23" using ($1-0.01):($2-1.790+8),\
  "exp2003/030703.HPD/26" using ($1-0.01):($2-2.135+16),\
  "exp2003/030703.HPD/20" using ($1-0.01):($2-0.205+24),\
  "exp2003/030703.HPD/17" using ($1-0.01):($2-2.287+32),\
  "exp2003/030703.HPD/15" using ($1-0.01):($2-0.956+40),\
  "exp2003/030703.HPD/32" using ($1-0.01):(($2+0.198)*3.333/4+48),\
  "exp2003/030703.HPD/29" using ($1-0.01):($2-1.809+56)
pause -1
