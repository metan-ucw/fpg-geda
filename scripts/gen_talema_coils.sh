#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprint for talema coils.
#

DIR=talema_coils

. settings.sh

prepare $DIR

#
# These numbers are taken from gme.cz eshop
#
for i in "14 8" "15 8" "15 9" "19 8" "20 8" "20 9" "25 12" "27 12" "30 12" "26 13" "29 13" "41 13" "30 14" "42 16"; do
	SIZE=`echo $i | sed s/\ /_/g`
	print_gen "coil_talema_$SIZE.fp"
	../components/gen_coil $i > $ODIR/$DIR/coil_talema_$SIZE.fp
done
