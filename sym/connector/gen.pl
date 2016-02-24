#!/usr/bin/perl

use strict;
use warnings;

sub println { print @_, "\n" }

sub line_size
{
	my (%context) = @_;

	return $context{'line_size'} || 10;
}

sub fill
{
	my (%context) = @_;

	return $context{'fill'} || 0;
}

sub gen_circle
{
	my ($x, $y, $radius, %ctx) = @_;

	println("V $x $y $radius 3 "
		. line_size(%ctx) .
		" 0 0 -1 -1 "
		. fill(%ctx) .
		" -1 -1 -1 -1 -1");
}

sub gen_box
{
	my ($x, $y, $w, $h, %ctx) = @_;

	println("B $x $y $w $h 3 "
		. line_size(%ctx) .
		" 0 0 -1 -1 "
		. fill(%ctx) .
		" -1 -1 -1 -1 -1");
}

sub gen_line
{
	my ($x1, $y1, $x2, $y2, %ctx) = @_;

	println("L $x1 $y1 $x2 $y2 3 " . line_size(%ctx) . " 0 0 -1 -1");
}

sub gen_pin
{
	my ($y, $pin, $label, $type) = @_;

	my $yc = $y + 100;
	my $yl = $y + 45;

	if ($type eq "1") {
		gen_circle(350, $y + 100, 50, ('line_size' => 15));
	}

	if ($type eq "plug") {
		gen_box(300, $y + 80, 100, 40, ('fill' => 1));
	}

	if ($type eq "socket") {
		my $yp = $y + 50;
		println("H 3 15 0 0 -1 -1 0 -1 -1 -1 -1 -1 5");
		println("M 400,$yp");
		println("l -50,0");
		println("c -28,0 -50,22 -50,50");
		println("c 0,28 22,50 50,50");
		println("l 50,0");
	}

	gen_line(200, $yc, 300, $yc);

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
my @types = ("1", "plug", "socket");

for my $type (@types) {
	for (my $i = 1; $i <= $max; $i++) {
		print("Generating connector-$type-$i.sym...\n");
		open(my $sym, ">connector-$type-$i.sym") or die $!;
		select $sym;
		println("v 20130925 2");
		for (my $p = 0; $p < $i; $p++) {
			gen_pin(200 * $p, $p + 1, ($i > 2 and ($p == 0 or $p == $i - 1)) ? 1 : 0, $type);
		}
		println("T -5 243 8 10 0 1 0 0 1");
		println("device=CONNECTOR_$i");
		my $y = 200 * $i;
		if ($i > 1) {
			println("T 145 $y 8 10 1 1 0 0 1");
			println("refdes=J?");
		}
		select STDOUT;
		close($sym);
	}
}
