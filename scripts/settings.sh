#!/bin/bash
#
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#

#
# Output directory
#
ODIR=../footprints

#
# Prepares directory.
#
prepare()
{
	echo "CRT $ODIR/$1/"
	rm -rf $ODIR/$1
	mkdir $ODIR/$1
}

#
# Print GEN $1 line
#
print_gen()
{
	echo "GEN $1"
}
