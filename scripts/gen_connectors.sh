#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates connector footprints
#

DIR=connectors
. settings.sh
prepare $DIR

for i in `seq 2 13`; do
	FILENAME="ch_conn_3_36_W_$i.fp"
	print_gen "$FILENAME"
	../components/gen_ch_conn $i > $ODIR/$DIR/$FILENAME
done
