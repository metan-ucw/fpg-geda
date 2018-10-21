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
# 5mm led diode
#
# ` 5.5mm  `
#
# `   5mm  `
#  `       `
# `` _---_ `
#   /     \
# `|       |
#  |       |
#  |       |
#  |       |
# ==========
#    I   I
#    |   |
#    |   |
#    |  >|< 0.6mm
#    |
#     2.54mm
#
sub led5
{
	my $fp = fp::begin("led_5mm", "5mm LED Diode", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, -1270, 0, 600, 1800, "Pin_1", "1", "square");
	fp::pin_s($fp, 1270, 0, 600, 1800, "Pin_2", "2", "");

	fp::diode($fp, -1270, 0, 1270, 0, "led");

	fp::arc($fp, 2750, 2750, 150, -300);
	fp::vline($fp, 2382, 1375, -1375);
	fp::circle($fp, 2300);

	fp::end($fp);
}

led5();
