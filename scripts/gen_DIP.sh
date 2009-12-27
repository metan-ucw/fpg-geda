#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for dual in line package.
#

DIR=DIP

. settings.sh

prepare $DIR

SLIM="6 8 14 16 18 20 24 28"

for TYPE in $SLIM; do
	print_gen "DIP$TYPE.fp"
	../components/gen_DIP $TYPE > $ODIR/$DIR/DIP$TYPE.fp
done
