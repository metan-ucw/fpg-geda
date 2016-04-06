#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;

sub pin
{
	my ($x, $y, $nr, $type) = @_;

	fp::pin($x, $y, 1400, 1700, 2000, 800, "Pin_$nr", "$nr", $type);
}

sub rect
{
	fp::rect(0, 0, 10000, 4600);
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
	print("Generating TO220_5.fp...\n");
	open(my $fp, ">TO220_5.fp") or die $!;
	select $fp;

	fp::begin("TO220 5 pin");
	fp::set_unit("um");
	rect();
	fp::set_origin(1600, 2600);

	pin(0, 0, 1, "square");
	for (my $i = 2; $i <= 5; $i++) {
		pin(($i-1)*1700, 0, "$i", "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
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
	print("Generating TO220.fp...\n");
	open(my $fp, ">TO220.fp") or die $!;
	select $fp;

	fp::begin("TO220");
	fp::set_unit("um");
	rect();
	fp::set_origin(2460, 2600);

	pin(0, 0, 1, "square");
	for (my $i = 2; $i <= 3; $i++) {
		pin(($i-1)*2540, 0, $i, "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

to220_5();
to220();
