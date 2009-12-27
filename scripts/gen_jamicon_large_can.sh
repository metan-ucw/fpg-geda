#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for large can jamicon capacitors.
#

DIR=large_can_cap

. settings.sh

prepare $DIR

#
# These numbers are taken from jamicon datasheet
#
for i in "22 8" "25 10" "30 10" "35 14"; do
	SIZE=`echo $i | sed s/\ .\*//`
	NAME="large_can_cap_$SIZE.fp"
	print_gen "$NAME"
	../components/gen_large_can_cap $i > $ODIR/$DIR/$NAME
done
