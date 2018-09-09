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

sub pin
{
	my ($fp, $x, $y, $nr, $type) = @_;

	fp::pin($fp, $x, $y, 1400, 1700, 2000, 800, "Pin_$nr", "$nr", $type);
}

sub rect
{
	my ($fp) = @_;

	fp::rect($fp, 0, 0, 10000, 4600);
	fp::hline($fp, 0, 10000, 1000);
}

#
# Generates TO220_5 footprint.
#
# SIZES has been taken from LM2576 datasheet.
#
# |- - 10mm - - - -|
#
#   ______________
#  /              \
# |      /  \      |
# |      \__/      |
# |                |
# |----------------|
# |----------------|
# |                |
# |                |
# |                |
# | ()             |
# |                |
#  ----------------
#   [] [] [] [] []
#   [] [] [] [] [] |
#   [] [] [] [] []
#   [] [] [] [] [] |
#   || || || || ||
#   || || || || || |
#   || || || || ||
#   || || || || || |
#   || || || || ||
#          `  `  ` 1.6mm
#          `  `
#   ||      1.7mm
#   0.8mm
#
# - - - - - -   ______________
# |            /              |________________
# 4.6mm       /               |---------------- ` `
# |  --------|                |                    2.6mm
# -  -------------------------- - - - - - - - - - -
#
sub to220_5
{
	my $fp = fp::begin("TO220_5", "TO220 5 pins", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	rect($fp);
	fp::set_origin($fp, 1600, 2600);

	pin($fp, 0, 0, 1, "square|long");
	for (my $i = 2; $i <= 5; $i++) {
		pin($fp, ($i-1)*1700, 0, "$i", "long");
	}

	fp::end($fp);
}

#
# Generates TO220 footprint.
#
# SIZES has been taken from LM317 datasheet.
#
# |- - 10mm - - - -|
#
#   ______________
#  /              \
# |      /  \      |
# |      \__/      |
# |                |
# |----------------|
# |----------------|
# |                |
# |                |
# |                |
# | ()             |
# |                |
#  ----------------
#     []  []  []
#     []  []  []   |
#     []  []  []
#     []  []  []   |
#     ||  ||  ||
#     ||  ||  ||   |
#     ||  ||  ||
#     ||  ||  ||   |
#     ||  ||  ||
#          `   ` 2.46mm
#          `   `
#     ||    2.54mm
#     0.8mm
#
# - - - - - -   ______________
# |            /              |________________
# 4.6mm       /               |---------------- ` `
# |  --------|                |                    2.6mm
# -  -------------------------- - - - - - - - - - -
#
sub to220
{
	my $fp = fp::begin("TO220", "TO220", "Cyril Hrubis");
	fp::set_unit($fp, "um");

	rect($fp);
	fp::set_origin($fp, 2460, 2600);

	pin($fp, 0, 0, 1, "square");
	for (my $i = 2; $i <= 3; $i++) {
		pin($fp, ($i-1)*2540, 0, $i, "");
	}

	fp::end($fp);
}

to220_5();
to220();
