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

#
# Generates TO92 footprint.
#
#     `2.54 mm`
#  --------------   -  -  -  -  -
# /   `       `  \  1.6 mm
# |  ()  ()  ()  |  -  -
# \     0.47mm   /           4.2 mm
#  -_          _-
#    `--____--`     -  -  -  -  -
#
#  Circle radius = 2.6 mm
#
# Types:
#
# sl - straight leads
# bl - bent leads to match 2.54 mm grid
# bm - middle pin bent back (cannot be insterted wrongly)
#
sub to92
{
	my ($type) = @_;

	my $fp = fp::begin("TO92_$type", "TO92", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::arc($fp, 2600, 2600, -40, 260);

	fp::hline($fp, -1992, 1992, -1671);

	my $pin_spacing = $type eq "bl" ? 2540 : 1900;
	my $drill = 500;
	my $copper = 1500;
	my $middle_pin_off = $type eq "bm" ? 1270 : 0;

	fp::pin_s($fp, -$pin_spacing, 0, $drill, $copper, "Pin_3", 3, "long");
	fp::pin_s($fp, 0, $middle_pin_off, $drill, $copper, "Pin_2", 2, "long");
	fp::pin_s($fp, $pin_spacing, 0, $drill, $copper, "Pin_1", 1, "square|long");

	fp::end($fp);
}

to92('sl');
to92('bl');
to92('bm');
