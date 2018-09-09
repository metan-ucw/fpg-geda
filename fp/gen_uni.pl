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
# Universal PCB patterns
#
sub uni
{
	my ($x, $y) = @_;

	my $fp = fp::begin("uni_${x}_$y", "Universal PCB ${x}x$y", "Cyril Hrubis");

	for (my $i = 0; $i < $x; $i++) {
		for (my $j = 0; $j < $y; $j++) {
			my $p = $i + $j * $y;
			fp::pin_s($fp, 100 * $i, 100 * $j, 25, 80, "Pin_$p", $p);
		}
	}

	fp::end($fp);
}

uni(1, 1);

uni(1, 5);
uni(2, 5);
uni(5, 1);
uni(5, 2);
uni(5, 5);

uni(1, 10);
uni(2, 10);
uni(10, 1);
uni(10, 2);
uni(10, 10);

uni(1, 20);
uni(2, 20);
uni(20, 1);
uni(20, 2);
uni(20, 20);

uni(2, 1);
uni(1, 2);
uni(2, 3);
uni(3, 2);
uni(1, 3);
uni(3, 1);
