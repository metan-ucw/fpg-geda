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
	print("Generating led_5mm.fp...\n");
	open(my $fp, ">led_5mm.fp") or die $!;
	select $fp;

	fp::begin("5mm LED Diode");
	fp::set_unit("um");

	fp::pin_s(-1270, 0, 600, 1800, "Pin_1", "1", "square");
	fp::pin_s(1270, 0, 600, 1800, "Pin_2", "2", "");

	fp::diode(-1270, 0, 1270, 0, "led");

	fp::arc(2750, 2750, -30, -300);
	fp::line(-2382, 1375, -2382, -1375);
	fp::circle(2300);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

led5();
