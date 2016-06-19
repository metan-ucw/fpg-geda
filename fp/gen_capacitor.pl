#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;

#
#  Ceramic capacitor 5mm
#
#       .----.
#       |    |
#       |____|
#        |  |
#       /    \
#       |    |
#       |    |
#       |   >|< 0.5 mm
#       |    |
#      >|----|< RM = 5 mm
#
sub ceramic_cap_5mm
{
	print("Generating ceramic_cap_5mm.fp...\n");
	open(my $fp, ">ceramic_cap_5mm.fp") or die $!;
	select $fp;

	fp::begin("Ceramic capacitor 5mm");
	fp::set_unit("um");

	fp::pin_s(0, 0, 600, 2000, "Pin_1", "1", "");
	fp::pin_s(5000, 0, 600, 2000, "Pin_2", "2", "");

	fp::capacitor(0, 0, 5000, 0);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# jamicon large can type.
#
#  |-  Dmm  -|
#
#   ---------
#  | | |     |
#  | |v|     |
#  | | |     |
#  | | |     |
#  | |v|     |
#  | | |     |
#   ---------
#  ===========
#     |   |
#     |   |
#
#     |Pmm|
#
sub gen_radial_can
{
	my ($D, $P) = @_;

	print("Generating radial_can_cap_${D}mm.fp...\n");
	open(my $fp, ">radial_can_cap_${D}mm.fp") or die $!;
	select $fp;

	fp::begin("Radial can capacitor ${D}mm");
	fp::set_unit("um");

	$D *= 1000;
	$P *= 1000;

	#pin_big
	fp::pin_s(0, 0, 600, 2000, "Pin_1", "1", "square");
	fp::pin_s($P, 0, 600, 2000, "Pin_2", "2", "");

	fp::capacitor(0, 0, $P, 0, "polarized");

	fp::circle($P/2, 0, $D/2);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

ceramic_cap_5mm

my @sizes = ([22, 8], [25, 10], [30, 10], [35, 14]);

for (@sizes) {
	gen_radial_can($_->[0], $_->[1]);
}
