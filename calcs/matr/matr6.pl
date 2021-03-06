#!/usr/bin/perl -w

use strict;

# l = W_b^2 / w;
# h = Gh
# A = sqrt(15)/5
# B = sqrt(15)/4
# C = 5/4

#my $matr =[ 
# ["-ix",      "-D",          "0",    "s_2 b kT d/h",  "-s_2 b T",      "0"],
# [  "D",      "-ix",         "H",    "-s b",        "-s_2 b T kT d/h", "-s_2 b T kT"],
# [  "0",      "-H",          "-ix",  "s_2 b kT",     "0",           "-s_2 b T"],
# [  "-d/h kT", "s_1",         "-kT",  "-(ix+ks_2)", "s B",          "-C"],
# [  "s_2 A",   "kT (sAd/h-1)", "-s_1", "-s_1 A",      "-(2ix+kTo)",  "-kT p"],
# [  "s_1",    "kT (sA+d/h)",  "s_2 A", "s_2",        "kT q",         "-(2ix+kTr)"]
#];

# A = \sqrt{\frac35}
# B = \frac{\sqrt{15}}{4}
# C = -\frac54
my $matr =[ 
 ["-ix",    "-D",     "0",      "0", "-s_2 b T",        "0"],
 [  "D",   "-ix",     "H",   "-s b",        "0",        "0"],
 [  "0",    "-H",   "-ix",      "0",        "0", "-s_2 b T"],
 [  "0",   "s_1",     "0",    "-ix",      "s B",       "-C"],
 [  "s_2 A", "0",  "-s_1", "-s_1 A",     "-2 ix",        "0"],
 [  "s_1",   "0", "s_2 A",    "s_2",        "0",     "-2 ix"]
];

#my @a0=("  1",  "0",  "0",   "0",   "0",   "0");
#my @a1=(  "0","-ix", "-D",  "-C",   "0",   "0");
#my @a2=(  "0",  "h","-ix",   "0",   "0",   "B");
#my @a3=(  "0", "5A",  "0","-4ix",  "5A",  "-5");
#my @a4=(  "0",  "0", "-3/2A",  "-A","-2ix", "0");
#my @a5=(  "0",  "0", "-1",   "1",   "0","-2ix");

my @i;

for ($i[0]=0; $i[0]<6; $i[0]++){
for ($i[1]=0; $i[1]<6; $i[1]++){
for ($i[2]=0; $i[2]<6; $i[2]++){
for ($i[3]=0; $i[3]<6; $i[3]++){
for ($i[4]=0; $i[4]<6; $i[4]++){
for ($i[5]=0; $i[5]<6; $i[5]++){

  my $s=0;
  my ($x, $y);
  for ($x=0; $x<5; $x++){
    for ($y=$x+1; $y<6; $y++){
      if ($i[$x]>$i[$y]) {$s++;}
      elsif ($i[$x]==$i[$y]) {goto A;}
    }
  }

  my @p;
  foreach (0..5){
    my $b = $matr->[$_]->[$i[$_]];
    if ($b eq "0"){goto A;}
    $s+=($b=~s/^-//);
    push(@p, split(' ', $b));
  }
  my $dht=0;
  foreach (@p){
    $dht++ if ($_ eq 'D')||($_ eq 'H')||($_ eq 'T')||($_ eq 'kT');
  }
  goto A if $dht >2;

  $s= ($s%2==0)?"+":"-";


  my $line= join '', sort @p;
  my $W=($line=~s/x/x/g);
  $W = 0 if $W eq '';
  print "$s$line\n";
  A:

}}}}}}
