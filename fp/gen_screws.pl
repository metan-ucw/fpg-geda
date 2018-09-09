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
# Generates holes for metric screws.
#
# Variant 1 has 1mm copper ring around the hole
# Variant 2 has copper of the size of the screew head
#
sub hole
{
	my ($size, $head_size, $var) = @_;
	my $fp = fp::begin("M${size}-$var", "M${size}", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	my $radius = ${size} * 1000 / 2 + 100;
	my $hs = $head_size * 1000 / 2;

	#fp::circle(0, 0, $radius);
	fp::hline($fp, $radius + 1000, $hs, 0);
	fp::hline($fp, -$radius - 1000, -$hs, 0);
	fp::vline($fp, 0, $radius + 1000, $hs);
	fp::vline($fp, 0, -$radius - 1000, -$hs);

	my $copper_size = $var == 1 ? ($size+0.5) * 1000 : $head_size * 1000;

	fp::pin_s($fp, 0, 0, $size * 1000, $copper_size, "Pin_1", 1);

	fp::end($fp);
}

# screew size, head size in mm
my @sizes = ([1.6, 3.2], [2, 4], [2.5, 5], [3, 6], [3.5, 7], [4, 8], [5, 10], [6, 12], [8, 16], [10, 20]);

for my $i (@sizes) {
	hole($i->[0], $i->[1], 1);
	hole($i->[0], $i->[1], 2);
}
