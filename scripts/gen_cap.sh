#!/bin/bash
#
# Distributed under GPLv2
#
# (C) Cyril Hrubis 2009
#
# Generates footprint for talema coils.
#

DIR=ceramic_cap

. settings.sh

prepare $DIR

print_gen "ceramic_cap_5mm.fp"
../components/gen_cap > $ODIR/$DIR/ceramic_cap_5mm.fp
