#!/usr/bin/perl

use strict;
use warnings;

sub println { print @_, "\n" }

sub gen_pin
{
	my ($y, $pin, $label) = @_;

	my $yc = $y + 100;
	my $yl = $y + 45;

	println("V 350 $yc 50 3 15 0 0 -1 -1 0 -1 -1 -1 -1 -1");
	println("L 200 $yc 300 $yc 3 10 0 0 -1 -1");
	println("P 100 $yc 200 $yc 1 0 0");
	println("{");
	println("T 100 $yc 5 10 0 0 0 0 1");
	println("pintype=pas");
	println("T 430 $yl 5 10 $label 1 0 0 1");
	println("pinlabel=$pin");
	println("T 155 $yc 5 10 0 1 0 6 1");
	println("pinnumber=$pin");
	println("T 100 $yc 5 10 0 0 0 0 1");
	println("pinseq=$pin");
	println("}");
}

my $max = 20;

for (my $i = 2; $i <= $max; $i++) {
	print("Generating connector1-$i.sym...\n");
	open(my $sym, ">connector1-$i.sym") or die $!;
	select $sym;
	println("v 20130925 2");
	for (my $p = 0; $p < $i; $p++) {
		gen_pin(200 * $p, $p + 1, ($p == 0 or $p == $i - 1) ? 1 : 0);
	}
	println("T -5 243 8 10 0 1 0 0 1");
	println("device=CONNECTOR_$i");
	my $y = 200 * $i;
	println("T 145 $y 8 10 1 1 0 0 1");
	println("refdes=J?");
	select STDOUT;
	close($sym);
}
