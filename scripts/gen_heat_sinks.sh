#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprints for standart heatsinks.
#

DIR=heatsinks

. settings.sh

prepare $DIR

for TYPE in V7141X V7477X; do
	print_gen "heatsink_$TYPE.fp"
	../components/gen_heat_sinks $TYPE > $ODIR/$DIR/heat_sink_$TYPE.fp
done
