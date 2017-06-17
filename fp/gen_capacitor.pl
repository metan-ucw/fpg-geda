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
sub large_radial_can
{
	my ($D, $P) = @_;

	$D *= 1000;
	$P *= 1000;

	print("Generating radial_can_cap_${D}_${P}.fp...\n");
	open(my $fp, ">radial_can_cap_${D}_${P}.fp") or die $!;
	select $fp;

	fp::begin("Radial can capacitor ${D}um ${P}um");
	fp::set_unit("um");


	fp::pin_s(0, 0, 600, 2000, "Pin_1", "1", "square");
	fp::pin_s($P, 0, 600, 2000, "Pin_2", "2", "");

	fp::capacitor(0, 0, $P, 0, "polarized");

	fp::circle($P/2, 0, $D/2);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
#  Radial can capacitor
#
#  |-  Dum  -|
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
#     |Pum|
#
sub radial_can
{
	my ($d, $D, $P) = @_;

	print("Generating radial_can_cap_${D}_${P}.fp...\n");
	open(my $fp, ">radial_can_cap_${D}_${P}.fp") or die $!;
	select $fp;

	fp::begin("Radial can capacitor ${D}um ${P}um");
	fp::set_unit("um");

	my $hole = $d+50;
	my $copper = 3 * $hole;

	fp::pin_s(0, 0, $hole, $copper, "Pin_1", "1", "square");
	fp::pin_s($P, 0, $hole, $copper, "Pin_2", "2");

	fp::capacitor(0, 0, $P, 0, "polarized");
	fp::circle($P/2, 0, $D/2);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

ceramic_cap_5mm

my @large_sizes = ([22, 8], [25, 10], [30, 10], [35, 14]);

for (@large_sizes) {
	large_radial_can($_->[0], $_->[1]);
}

my @sizes = ([500, 5000, 2000], [500, 6300, 2500],
	     [600, 8000, 3500], [600, 10000, 5000], [600, 12500, 5000],
	     [800, 16000, 7500], [800, 18000, 7500],
             [1000, 22000, 10000], [1000, 25000, 10000]);

for (@sizes) {
	radial_can($_->[0], $_->[1], $_->[2]);
}


