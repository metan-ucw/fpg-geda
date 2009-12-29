#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for potentiometers.
#

DIR=potentiometer

. settings.sh

prepare $DIR

for TYPE in `../components/gen_pot -d`; do
	print_gen "$TYPE.fp"
	../components/gen_pot $TYPE > $ODIR/$DIR/$TYPE.fp
done
