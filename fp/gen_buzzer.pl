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
# Generates buzzer footprint.
#
#                         _    _   _
#            _.-""""-._
#          .'          `.
#         /   | 5 mm |   \         |
#        |                |
#        |    O      O    |      12.6 mm
#        |   0.5 mm       |
#         \              /         |
#          `._        _.'
#             `-....-'    _    _   _
#
sub buzzer_5mm
{
	print("Generating buzzer_5mm.fp...\n");
	open(my $fp, ">buzzer_5mm.fp") or die $!;
	select $fp;

	fp::begin("buzzer 5mm");
	fp::set_unit("um");

	fp::circle(6300);

	fp::plus(-4000, 0, -3500, 0);
	fp::pin_s(-2500, 0, 600, 1400, "Pin_1", 1, "square");
	fp::hline(3500, 4300, 0);
	fp::pin_s(2500, 0, 600, 1400, "Pin_2", 2);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

buzzer_5mm();
