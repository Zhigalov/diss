#!/usr/bin/perl -w

use strict;

my $matr =[ 
 ["-ix",   "1",   "0", "-s b n_x"],
 [ "-1", "-ix",   "0", "-s b n_y"],
 [  "0",   "0", "-ix", "-s b n_z"],
 ["n_x", "n_y", "n_z", "-(ix+sk)"],
];

my @i;

for ($i[0]=0; $i[0]<4; $i[0]++){
for ($i[1]=0; $i[1]<4; $i[1]++){
for ($i[2]=0; $i[2]<4; $i[2]++){
for ($i[3]=0; $i[3]<4; $i[3]++){

  my $s=0;
  my ($x, $y);
  for ($x=0; $x<3; $x++){
    for ($y=$x+1; $y<4; $y++){
      if ($i[$x]>$i[$y]) {$s++;}
      elsif ($i[$x]==$i[$y]) {goto A;}
    }
  }

  my @p;
  foreach (0..3){
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

}}}}
