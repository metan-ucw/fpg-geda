#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for TO220 package variants.
#

DIR=TO220

. settings.sh

prepare $DIR

for TYPE in `../components/gen_TO220 -d`; do
	print_gen "$TYPE.fp"
	../components/gen_TO220 $TYPE > $ODIR/$DIR/$TYPE.fp
done
