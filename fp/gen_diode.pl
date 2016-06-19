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
	print("Generating DO35.fp...\n");
	open(my $fp, ">DO35.fp") or die $!;
	select $fp;

	fp::begin("DO35 Diode");
	fp::set_unit("um");

	fp::pin_s(0, 0, 500, 1600, "Pin_1", "1", "square");
	fp::pin_s(5000, 0, 500, 1600, "Pin_2", "2", "");
	fp::diode(5000, 0, 0, 0);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# Staying DO35 diode, space between pins is 0.5 mm.
#
sub DO35_stay
{
	print("Generating DO35_stay.fp...\n");
	open(my $fp, ">DO35_stay.fp") or die $!;
	select $fp;

	fp::begin("DO35 Diode staying");
	fp::set_unit("um");

	fp::pin_s(0, 0, 500, 1600, "Pin_1", "1", "square");
	fp::circle(0, 0, 800);
	fp::hline(800, 1850, 0);
	fp::pin_s(2100, 0, 500, 1600, "Pin_2", "2", "");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
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
	print("Generating DO41.fp...\n");
	open(my $fp, ">DO41.fp") or die $!;
	select $fp;

	fp::begin("DO41 Diode");
	fp::set_unit("um");

	fp::pin_s(0, 0, 800, 2500, "Pin_1", "1", "square");
	fp::pin_s(10000, 0, 800, 2500, "Pin_2", "2", "");
	fp::diode(10000, 0, 0, 0);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# Staying DO41 diode, space between pins is 1 mm
#
sub DO41_stay
{
	print("Generating DO41_stay.fp...\n");
	open(my $fp, ">DO41_stay.fp") or die $!;
	select $fp;

	fp::begin("DO41 Diode staying");
	fp::set_unit("um");

	fp::pin_s(0, 0, 800, 2500, "Pin_1", "1", "square");
	fp::circle(0, 0, 1350);
	fp::hline(1350, 3100, 0);
	fp::pin_s(3500, 0, 800, 2500, "Pin_2", "2", "");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
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
	print("Generating DO201.fp...\n");
	open(my $fp, ">DO201.fp") or die $!;
	select $fp;

	fp::begin("DO201 Diode");
	fp::set_unit("um");

	fp::pin_s(0, 0, 800, 2500, "Pin_1", "1", "square");
	fp::pin_s(10000, 0, 800, 2500, "Pin_2", "2", "");
	fp::diode(10000, 0, 0, 0);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# Staying DO201 diode, space between pins is 2 mm
#
sub DO201_stay
{
	print("Generating DO201_stay.fp...\n");
	open(my $fp, ">DO201_stay.fp") or die $!;
	select $fp;

	fp::begin("DO201 Diode staying");
	fp::set_unit("um");

	fp::pin_s(0, 0, 1100, 4000, "Pin_1", "1", "square");
	fp::circle(0, 0, 2500);
	fp::hline(2500, 5450, 0);
	fp::pin_s(6000, 0, 1100, 4000, "Pin_2", "2", "");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
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
	print("Generating wob_bridge.fp...\n");
	open(my $fp, ">wob_bridge.fp") or die $!;
	select $fp;

	fp::begin("WOB Bridge rectifier");
	fp::set_unit("um");

	fp::circle(0, 0, 4600);

	fp::diode(0, -3600, -3600, 0);
	fp::diode(0, 3600, -3600, 0);
	fp::diode(3600, 0, 0, -3600);
	fp::diode(3600, 0, 0, 3600);

	fp::pin_s(-3600, 0, 810, 2000, "+", "1", "square");
	fp::pin_s(0, 3600, 810, 2000, "~", "2", "");
	fp::pin_s(3600, 0, 810, 2000, "-", "3", "");
	fp::pin_s(0, -3600, 810, 2000, "~", "4", "");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
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
	print("Generating db_bridge.fp...\n");
	open(my $fp, ">db_bridge.fp") or die $!;
	select $fp;

	fp::begin("WOB Bridge rectifier");
	fp::set_unit("um");

	fp::rect(-4300, -4000, 8600, 8000);
	fp::vline(-3900, -4000, 4000);

	fp::pin_s(-2550, 3950, 600, 1200, "+", "1", "square");
	fp::pin_s(2550, -3950, 600, 1200, "~", "2");
	fp::pin_s(2550, 3950, 600, 1200, "-", "3");
	fp::pin_s(-2550, -3950, 600, 1200, "~", "4");

	my $dw = 2000;

	fp::diode(-2550, -$dw, -2550, $dw);
	fp::diode(-850, -$dw, -850, $dw);
	fp::diode(850, $dw, 850, -$dw);
	fp::diode(2550, $dw, 2550, -$dw);

	fp::line(-2550, -3950, -2550, -$dw);
	fp::line(-2550, -3950, 850, -$dw);
	fp::line(2550, -3950, 2550, -$dw);
	fp::line(2550, -3950, -850, -$dw);

	fp::line(-2550, 3950, -2550, $dw);
	fp::line(-2550, $dw, -850, $dw);
	fp::line(2550, 3950, 2550, $dw);
	fp::line(2550, $dw, 850, $dw);

	fp::dot(-2550, $dw);
	fp::dot(2550, $dw);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

DO35();
DO35_stay();
DO41();
DO41_stay();
DO201();
DO201_stay();
WOB();
DB();
