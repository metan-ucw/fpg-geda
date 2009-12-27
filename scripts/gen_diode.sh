#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for TO220 package variants.
#

DIR=diode

. settings.sh

prepare $DIR

for TYPE in `../components/gen_diode -d`; do
	print_gen "$TYPE.fp"
	../components/gen_diode $TYPE > $ODIR/$DIR/$TYPE.fp
done
