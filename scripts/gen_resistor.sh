#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for resistors.
#

DIR=resistor

. settings.sh

prepare $DIR

for TYPE in `../components/gen_resistor -d`; do
	print_gen "$TYPE.fp"
	../components/gen_resistor $TYPE > $ODIR/$DIR/$TYPE.fp
done
