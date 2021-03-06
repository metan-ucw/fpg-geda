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
# R0207
#
#            | - 6.3 mm - |
#
#            +==--------==+ - - - - - - -
# -----------|            |------------ 2.5 mm
#            +==--------==+ - - - - - - -
#
#
sub R0207
{
	my $fp = fp::begin("R0207", "R0207 Resistor", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 600, 2000, "Pin_1", "1", "");
	fp::pin_s($fp, 10000, 0, 600, 2000, "Pin_2", "2", "");

	fp::resistor($fp, 0, 0, 10000, 0);

	fp::end($fp);
}

#
# R0207 staying, space between pins is 0.7 mm.
#
sub R0207_stay
{
	my $fp = fp::begin("R0207_stay", "R0207 Resistor staying", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 600, 2000, "Pin_1", "1", "");
	fp::circle($fp, 0, 0, 1250);
	fp::hline($fp, 1250, 2400, 0);
	fp::pin_s($fp, 2700, 0, 600, 2000, "Pin_2", "2", "");

	fp::end($fp);
}

#
# R0204
#
#            | - 4.1 mm - |
#
#            +==--------==+ - - - - - - -
# -----------|            |------------ 1.8 mm
#            +==--------==+ - - - - - - -
#
sub R0204
{
	my $fp = fp::begin("R0204", "R0204 Resistor", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 550, 1600, "Pin_1", "1", "");
	fp::pin_s($fp, 6000, 0, 550, 1600, "Pin_2", "2", "");
	fp::resistor($fp, 0, 0, 6000, 0);

	fp::end($fp);
}

#
# R0204 staying space between pins is 0.5 mm.
#
sub R0204_stay
{
	my $fp = fp::begin("R0204_stay", "R0204 Resistor staying", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 550, 1600, "Pin_1", "1", "");
	fp::circle($fp, 0, 0, 900);
	fp::hline($fp, 900, 1835, 0);
	fp::pin_s($fp, 2100, 0, 550, 1600, "Pin_2", "2", "");

	fp::end($fp);
}

R0207();
R0207_stay();
R0204();
R0204_stay();
