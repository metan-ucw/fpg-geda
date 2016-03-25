#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;

#
# Dual in line package.
#
#
#   == == == == \  \ == == == ==  - - -
# --------------/  /--------------    |
# |            /  /              |
# |            \  \              |    |
#  --           \  \             |
#    )          /  /             |  0.3 in or 0.6 for wide package
#  --          /  /              |
# |            \  \              |    |
# |             \  \             |
# --------------/  /--------------    |
#   == == == == \  \ == == == ==  - - -
#   |  |
#    0.1 in
#
sub dip
{
	my ($n, $w) = @_;
	my $W = $w == 300 ? "" : "W";

	print("Generating DIP$n$W.fp...\n");
	open(my $fp, ">DIP$n$W.fp") or die $!;
	select $fp;
	fp::begin("DIP $n ($w mils wide)");

	fp::pin(0, 0, 25, 80, "Pin_1", "1", "Square");

	for (my $i = 0; $i <= $n/2-1; $i++) {
		my $p = $i + 2;
		fp::pin(0, 100*$i, 25, 80, "Pin_$p", "$p", "");
	}

	for (my $i = 0; $i < $n/2; $i++) {
		my $p = $i + $n/2 + 1;
		my $y = $n/2 - $i - 1;
		fp::pin($w, 100*$y, 25, 80, "Pin_$i", "$i", "");
	}

	my $d = 50;
	my $l = 2 * $d + 100 * ($n/2 - 1);

	fp::shape(-$d, -$d,
	          ["VL", $l],
		  ["HL", 2*$d + $w],
		  ["VL", -$l],
		  ["HL", -$d - $w/3],
		  ["HA", 180, -$w/3],
		  ["HL", -$d - $w/3],
	);

	fp::end();
	select STDOUT;
	close($fp);
}

my $max = 64;
my @width = (300, 600);

for my $w (@width) {
	for (my $i = 4; $i <= $max; $i+=2) {
		if ($w != 600 or $i >= 24) {
			dip($i, $w);
		}
	}
}
