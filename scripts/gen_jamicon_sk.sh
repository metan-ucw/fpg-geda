#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for jamicon radial type SK series
#

#
# all in mm
#
# D 5    6.3  8    10   12.5  16   18   22  25
# F 2.0  2.5  3.5  5.0   5.0  7.5  7.5  10  12.5
# d 0.5  0.5  0.6  0.6   0.6  0.8  0.8  1.0 1.0
#

DIR=radial_can_cap

. settings.sh

prepare $DIR

for i in "5000 2000" "6300 2500" "8000 3500" "10000 5000" "12500 5000" "16000 7500" "18000 7500" "22000 1000" "25000 12500"; do
	SIZE=`echo $i | sed s/\ .*//g`
	NAME="radial_can_cap_$SIZE.fp"
	print_gen "$NAME"
	../components/gen_radial_can_cap $i > $ODIR/$DIR/$NAME
done
