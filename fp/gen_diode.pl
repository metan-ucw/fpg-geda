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
# DO35
#
#            | 3.5 mm |
#
#  0.3 mm     --------  - - - - - - -
# -----------| ||     |------------ 1.6 mm
#             --------  - - - - - - -
#  PIN1                        PIN2
#            ___|/|___
#               |\|
sub DO35
{
	my ($type) = @_;
	my $suffix = $type ? "_$type" : "";

	my $fp = fp::begin("DO35$suffix", "DO35 Diode", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 500, 1600, "Pin_1", "1", "square");
	fp::pin_s($fp, 5000, 0, 500, 1600, "Pin_2", "2");
	fp::diode($fp, 0, 0, 5000, 0, $type);

	fp::end($fp);
}

#
# Staying DO35 diode, space between pins is 0.5 mm.
#
sub DO35_stay
{
	my $fp = fp::begin("DO35_stay", "DO35 Diode staying", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 500, 1600, "Pin_1", "1", "square");
	fp::circle($fp, 0, 0, 800);
	fp::hline($fp, 800, 1850, 0);
	fp::pin_s($fp, 2100, 0, 500, 1600, "Pin_2", "2");

	fp::end($fp);
}

#
# DO41
#
#            |- 5 mm -|
#
#  0.7 mm    +--------+ - - - - - - -
# -----------|X|      |------------ 2.7 mm
#            +--------+ - - - - - - -
#  PIN1                        PIN2
#            ___|/|___
#               |\|
sub DO41
{
	my ($type) = @_;
	my $suffix = $type ? "_$type" : "";

	my $fp = fp::begin("DO41$suffix", "DO41 Diode", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 800, 2500, "Pin_1", "1", "square");
	fp::pin_s($fp, 10000, 0, 800, 2500, "Pin_2", "2");
	fp::diode($fp, 0, 0, 10000, 0, $type);

	fp::end($fp);
}

#
# Staying DO41 diode, space between pins is 1 mm
#
sub DO41_stay
{
	my $fp = fp::begin("DO41_stay", "DO41 Diode staying", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 800, 2500, "Pin_1", "1", "square");
	fp::circle($fp, 0, 0, 1350);
	fp::hline($fp, 1350, 3100, 0);
	fp::pin_s($fp, 3500, 0, 800, 2500, "Pin_2", "2");

	fp::end($fp);
}

#
# DO201
#
#            |- 8 mm -|
#
#  1 mm      +--------+ - - - - - - -
# ___________|X|      |____________
#            |X|      |             5 mm
#            +--------+ - - - - - - -
#  PIN1                        PIN2
#            ___|/|___
#               |\|
sub DO201
{
	my ($type) = @_;
	my $suffix = $type ? "_$type" : "";

	my $fp = fp::begin("DO201$suffix", "DO201 Diode", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 800, 2500, "Pin_1", "1", "square");
	fp::pin_s($fp, 10000, 0, 800, 2500, "Pin_2", "2");
	fp::diode($fp, 0, 0, 10000, 0, $type);

	fp::end($fp);
}

#
# Staying DO201 diode, space between pins is 2 mm
#
sub DO201_stay
{
	my $fp = fp::begin("DO201_stay", "DO201 Diode staying", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 1100, 4000, "Pin_1", "1", "square");
	fp::circle($fp, 0, 0, 2500);
	fp::hline($fp, 2500, 5450, 0);
	fp::pin_s($fp, 6000, 0, 1100, 4000, "Pin_2", "2");

	fp::end($fp);
}

#
# Generates wob package used for bridge recfilters.
#
#
#          |- - 9.3 mm - -|
#
#          +--------------+  -
#          |              |  |
#          |              |  5.6 mm
#          |              |
#          |              |  |
#          +--------------+  -
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |  |    |  |
#            |
#            |
#
#                    /
#
#                  /      4.6 - 5.6 mm
#              ---------
#            /    (~)    \      /
#          /               \
#         |                 | /
#        |                   |
#        | (+)           (-) |
#        |                   |
#         |                 |
#          \               /
#            \    (~)    /
#              ---------
#
sub WOB
{
	my $fp = fp::begin("wob_bridge", "WOB Bridge rectifier", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::circle($fp, 0, 0, 4600);

	fp::diode($fp, 0, -3600, -3600, 0);
	fp::diode($fp, 0, 3600, -3600, 0);
	fp::diode($fp, 3600, 0, 0, -3600);
	fp::diode($fp, 3600, 0, 0, 3600);

	fp::pin_s($fp, -3600, 0, 810, 2000, "+", "1", "square");
	fp::pin_s($fp, 0, 3600, 810, 2000, "~", "2");
	fp::pin_s($fp, 3600, 0, 810, 2000, "-", "3");
	fp::pin_s($fp, 0, -3600, 810, 2000, "~", "4");

	fp::end($fp);
}

#
# DB package bridge rectifier (DIL compatible)
#
#
#    [ ]       [ ] `  `  `  `  `
#   ---------------  - -
#  || ~         ~  |   |       |
#  ||              |
#  ||              |   6.4mm   7.9mm
#  ||              |
#  || +         -  |   |       |
#  `---------------` - -
#    [ ]       [ ]
#  `  `         `  `  `  `  `  `
#     `  5.1mm  `
#  `     8.5mm     `
#
sub DB
{
	my $fp = fp::begin("db_bridge", "DB Bridge rectifier", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::rect($fp, -4300, -4000, 8600, 8000);
	fp::vline($fp, -3900, -4000, 4000);

	fp::pin_s($fp, -2550, 3950, 600, 1200, "+", "1", "square");
	fp::pin_s($fp, 2550, -3950, 600, 1200, "~", "2");
	fp::pin_s($fp, 2550, 3950, 600, 1200, "-", "3");
	fp::pin_s($fp, -2550, -3950, 600, 1200, "~", "4");

	my $dw = 2000;

	fp::diode($fp, -2550, -$dw, -2550, $dw);
	fp::diode($fp, -850, -$dw, -850, $dw);
	fp::diode($fp, 850, $dw, 850, -$dw);
	fp::diode($fp, 2550, $dw, 2550, -$dw);

	fp::line($fp, -2550, -3950, -2550, -$dw);
	fp::line($fp, -2550, -3950, 850, -$dw);
	fp::line($fp, 2550, -3950, 2550, -$dw);
	fp::line($fp, 2550, -3950, -850, -$dw);

	fp::line($fp, -2550, 3950, -2550, $dw);
	fp::line($fp, -2550, $dw, -850, $dw);
	fp::line($fp, 2550, 3950, 2550, $dw);
	fp::line($fp, 2550, $dw, 850, $dw);

	fp::dot($fp, -2550, $dw);
	fp::dot($fp, 2550, $dw);

	fp::end($fp);
}

my @types = (undef, "zener", "schottky");

for (@types) {
	DO35($_);
	DO41($_);
	DO201($_);
}

DO35_stay();
DO41_stay();
DO201_stay();

WOB();
DB();
