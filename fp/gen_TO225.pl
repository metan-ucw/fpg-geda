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
	my ($fp, $x, $y, $nr, $type) = @_;

	fp::pin($fp, $x, $y, 1700, 2000, 2200, 800, "Pin_$nr", "$nr", $type);
}

sub rect
{
	my ($fp) = @_;

	fp::rect($fp, 0, 0, 7800, 4000);
	fp::hline($fp, 1800, 6000, 600);
	fp::vline($fp, 1800, 0, 600);
	fp::vline($fp, 6000, 0, 600);
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
	my $fp = fp::begin("TO225", "TO225", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	rect($fp);
	fp::set_origin($fp, 1360, 1760);

	pin($fp, 0, 0, 1, "square|long");
	for (my $i = 2; $i <= 3; $i++) {
		pin($fp, ($i-1)*2540, 0, $i, "long");
	}

	fp::end($fp);
}

to225();
