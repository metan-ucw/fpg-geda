#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;

#
#  Generate talema radial coil footprint.
#
#  ---     _._  - - -
#  [ ]   /\ | /\    |
#  ---   --( )--    a
#  [ ]   \/ | \/    |
# .---.    -|-  - - -
# |   |     |
# |-b-|
#
# Footprint:
#
# +-------------+
# |      o      |
# |             |
# |      o      |
# +-------------+
#
sub gen_radial_coil
{
	my ($a, $b) = @_;

	print("Radial coil radial_coil_${a}_${b}.fp...\n");
	open(my $fp, ">radial_coil_${a}_${b}.fp") or die $!;
	select $fp;

	fp::begin("Radial Coil ${a}mm x ${b}mm");
	fp::set_unit("um");

	fp::pin_s(0, 0, 700, 2000, "Pin_1", "1", "");
	fp::pin_s(0, 1000 * $b, 700, 2000, "Pin_2", "2", "");

	fp::coil(0, 0, 0, 1000*$b, 3);
	fp::rect((-1000 * ($a+1))/2, -1000, 1000 * ($a + 2), 1000 * ($b + 2));

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

my @sizes = ([16, 7], [14, 8], [15, 8], [16, 8], [15, 9], [16, 9], [19, 8],
             [20, 8], [20, 9], [25, 12], [27, 12], [30, 12], [26, 13],
	     [29, 13], [41, 13], [30, 14], [42, 16]);

for (@sizes) {
	gen_radial_coil($_->[0], $_->[1]);
}
