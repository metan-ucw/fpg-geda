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
	my $fp = fp::begin("buzzer_5mm", "buzzer 5mm", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	fp::circle($fp, 6300);

	fp::plus($fp, -4000, 0, -3500, 0);
	fp::pin_s($fp, -2500, 0, 600, 1400, "Pin_1", 1, "square");
	fp::hline($fp, 3500, 4300, 0);
	fp::pin_s($fp, 2500, 0, 600, 1400, "Pin_2", 2);

	fp::end($fp);
}

buzzer_5mm();
