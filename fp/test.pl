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

sub test_coil
{
	my ($fp) = @_;

	fp::coil($fp, 0, 0, 0, 1000, 3);
	fp::coil($fp, 0, 0, 1000, 0, 7);
	fp::coil($fp, 0, 0, 1000, 1000, 5);
	fp::coil($fp, 0, 0, 1000, 500, 2);
}

sub test_diode
{
	my ($fp) = @_;

	fp::diode($fp, 0, 0, 1000, 0);
	fp::diode($fp, 0, 0, 1000, 1000);
	fp::diode($fp, 1000, 0, 600, 700, "zener");
}

sub test_cap
{
	my ($fp) = @_;

	fp::capacitor($fp, 0, 0, 1000, 0, "polarized");
	fp::capacitor($fp, 0, 0, 500, 1000);
	fp::capacitor($fp, 1000, 1000, 1000, 2000);
	fp::capacitor($fp, 1000, 2000, 2000, 2000, "polarized");
	fp::capacitor($fp, 0, 2000, 1000, 2000);
	fp::capacitor($fp, 2000, 2900, 2000, 2000);
}

sub test_resistor
{
	my ($fp) = @_;

	fp::resistor($fp, 0, 0, 1000, 1000);
	fp::resistor($fp, 0, 0, 1000, 0);
	fp::resistor($fp, 1900, 1000, 1000, 0);
}

my $fp = fp::begin("fptest", "Footprint library test", "Cyril Hrubis");
fp::set_unit($fp, "mm");
fp::set_line_width(30000);
test_coil($fp);
fp::add_origin($fp, 0, 1000);
test_cap($fp);
fp::add_origin($fp, 2000, 0);
test_resistor($fp);
fp::add_origin($fp, 0, 1000);
test_diode($fp);
fp::add_origin($fp, 200, 1200);
fp::koch($fp, 2000, 4);
fp::end($fp);
