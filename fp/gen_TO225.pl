#!/usr/bin/perl
#
# Copyright (C) 2009-2016 Cyril Hrubis <metan@ucw.cz>
#
# fpg-geda code is distributed under GPLv2+
#
# See <http://www.gnu.org/licenses/> for more information
#

use lib '../lib/';
use fp;

use strict;
use warnings;

sub pin
{
	my ($x, $y, $nr, $type) = @_;

	fp::pin($x, $y, 1400, 1700, 2000, 800, "Pin_$nr", "$nr", $type);
}

sub rect
{
	fp::rect(0, 0, 7800, 4000);
}

#
# Generates TO225 footprint.
#
# |- - - 7.8mm- - -|
#
#  ----------------
# |                |
# |       __
# |      /  \      |
# |      \__/      |
# |                |
# |                |
# |                |
# |                |
# | ()             |
# |                |
#  ----------------
#    []   []   []
#    []   []   []   |
#    []   []   []
#    []   []   []   |
#    ||   ||   ||
#    ||   ||   ||   |
#    ||   ||   ||
#    ||   ||   ||   |
#    ||   ||   ||
#          `   ` 1.36mm
#          `   `
#    ||    2.54mm
#    0.8mm
#
# - -  ________________________
# |   |                        |________________
# 4mm |                        |---------------- ` `
# |   |                        |                    1.76mm
# - -  ------------------------  - - - - - - - - - -
#
sub to225
{
	print("Generating TO225.fp...\n");
	open(my $fp, ">TO225.fp") or die $!;
	select $fp;

	fp::begin("TO225");
	fp::set_unit("um");
	rect();
	fp::set_origin(1360, 1760);

	pin(0, 0, 1, "square");
	for (my $i = 2; $i <= 3; $i++) {
		pin(($i-1)*2540, 0, $i, "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

to225();
