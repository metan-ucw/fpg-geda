#!/usr/bin/perl

use lib '../../lib/';
use sym;

use strict;
use warnings;

sub pin
{
	my ($y, $pin, $label, $type) = @_;

	my $yc = $y + 100;
	my $yl = $y + 45;

	if ($type eq "1") {
		sym::circle(350, $y + 100, 50, ('line_size' => 15));
	}

	if ($type eq "plug") {
		sym::box(300, $y + 80, 100, 40, ('fill' => 1));
	}

	if ($type eq "socket") {
		my $yp = $y + 50;
		sym::println("H 3 15 0 0 -1 -1 0 -1 -1 -1 -1 -1 5");
		sym::println("M 400,$yp");
		sym::println("l -50,0");
		sym::println("c -28,0 -50,22 -50,50");
		sym::println("c 0,28 22,50 50,50");
		sym::println("l 50,0");
	}

	sym::line(200, $yc, 300, $yc);

	sym::pin(100, $yc, 200, $yc,
	         ["pas"],
	         ["$pin", 430, $yl, $label, 1],
	         ["$pin", 155, $yc, 0, 1, {'origin' => 'br'}],
		 ["$pin"],
	);
}

my $max = 20;
my @types = ("1", "plug", "socket");

for my $type (@types) {
	for (my $i = 1; $i <= $max; $i++) {
		print("Generating connector-$type-$i.sym...\n");
		open(my $sym, ">connector-$type-$i.sym") or die $!;
		select $sym;
		sym::header();
		for (my $p = 0; $p < $i; $p++) {
			pin(200 * $p, $p + 1, ($i > 2 and ($p == 0 or $p == $i - 1)) ? 1 : 0, $type);
		}
		sym::text(-5, 243, 0, 1, "device=CONNECTOR_$i");
		if ($i > 1) {
			sym::text(145, 200 * $i, 1, 1, "refdes=J?");
		}
		select STDOUT;
		close($sym);
	}
}
