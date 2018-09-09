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
# TP160A tesla potentiometer, should also work for TP160P (plastic body)
#
#
#
# >  16 mm  <   > 10.5 <
#  |       |     |    |
#   .-^^^-.       ----
#  /   _   \     |    |--  - - -
#  |  ( )  |     |    |  |XX==== 7 mm
#  \       /     |    |--  - - -
#  | o o o |      --- |
#   -/-|-\-          ||
#    X X X           ||
#    | | |            |
#   > <
#    1 mm
#   > - - <
#     10 mm
#
sub TP160
{
	my $fp = fp::begin("pot_TP160", "Tesla potentiometer TP160A/TP160P", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 1400, 3000, "Pin_1", "1", "long");
	fp::pin_s($fp, 5000, 0, 1400, 3000, "Pin_2", "2", "long");
	fp::pin_s($fp, 10000, 0, 1400, 3000, "Pin_3", "3", "long");

	fp::add_origin($fp, -3000, -8800);
	fp::rect($fp, 16000, 10500);
	fp::rect($fp, 4500, 10500, 7000, 2000);

	fp::line($fp, 4500, 10750, 11500, 11250);
	fp::line($fp, 4500, 11250, 11500, 11750);
	fp::line($fp, 4500, 11750, 11500, 12250);

	fp::end($fp);
}

TP160();
