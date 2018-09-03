#!/bin/bash

# outfile prefix
outprefix=initial
# code unit of mass (cgs)
massunitcgs=2.38209e+38
# code unit of mass (M_sun)
massunitmsun=119763
# code unit of stellar mass (cgs)
mstarunitcgs=1.19104e+33
# code unit of stellar mass (M_Sun)
mstarunitmsun=0.598815
# code unit of length (cgs)
lengthunitcgs=5.39998e+18
# code unit of length (parsecs)
lengthunitparsec=1.75
# code unit of time (cgs)
timeunitcgs=8.28183e+16
# code unit of time (Myr)
timeunitsmyr=2624.41
# N-body  unit of time (cgs)
nbtimeunitcgs=3.14747e+12
# N-body unit of time (Myr)
nbtimeunitsmyr=0.0997394

cat $outprefix.dyn.dat | grep -vE '^#' | awk '{print $1*'$timeunitsmyr', $8/$21}' > $outprefix.tmyr_rcrh.dat
prunedata.pl -d 30 $outprefix.tmyr_rcrh.dat > $outprefix.tmyr_rcrh-pruned.dat

cat $outprefix.dyn.dat | grep -vE '^#' | awk '{print $1*'$timeunitsmyr', $25/$21}' > $outprefix.tmyr_rcnbrh.dat
prunedata.pl -d 30 $outprefix.tmyr_rcnbrh.dat > $outprefix.tmyr_rcnbrh-pruned.dat

cat $outprefix.dyn.dat | grep -vE '^#' | awk '{print $1*'$timeunitsmyr', $7/(4.0/3.0*3.14159265*$8*'$lengthunitparsec')^3}' > $outprefix.tmyr_nc.dat
prunedata.pl -d 30 $outprefix.tmyr_nc.dat > $outprefix.tmyr_nc-pruned.dat

cat $outprefix.dyn.dat | grep -vE '^#' | awk '{print $1*'$timeunitsmyr', $5}' > $outprefix.tmyr_m.dat
prunedata.pl -d 30 $outprefix.tmyr_m.dat > $outprefix.tmyr_m-pruned.dat

cat $outprefix.bin.dat | grep -vE '^#' | awk '{print $1*'$timeunitsmyr', $11}' > $outprefix.tmyr_fbc.dat
prunedata.pl -d 30 $outprefix.tmyr_fbc.dat > $outprefix.tmyr_fbc-pruned.dat

cat $outprefix.bin.dat | grep -vE '^#' | awk '{print $1*'$timeunitsmyr', $12}' > $outprefix.tmyr_fb.dat
prunedata.pl -d 30 $outprefix.tmyr_fb.dat > $outprefix.tmyr_fb-pruned.dat

cat $outprefix.tmyr_nc.dat | awk '{print NR, $2}' > $outprefix.NR_nc.dat
cat $outprefix.tmyr_fbc.dat | awk '{print NR, $2}' > $outprefix.NR_fbc.dat
join $outprefix.NR_fbc.dat $outprefix.NR_nc.dat | awk '{print $2, $3}' > $outprefix.fbc_nc.dat
prunedata.pl -n 300 $outprefix.fbc_nc.dat > $outprefix.fbc_nc-pruned.dat
head -n 1 $outprefix.fbc_nc.dat > $outprefix.fbc_nc-arrow.dat
tail -n 1 $outprefix.fbc_nc.dat >> $outprefix.fbc_nc-arrow.dat
