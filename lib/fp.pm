#!/usr/bin/perl

package fp;

use strict;
use warnings;

sub println { print @_, "\n" }

sub w
{
	my $depth = 0;
	for (; caller $depth; $depth++) {1};
	my @caller = caller($depth - 1);

	print STDERR "$caller[1]: $caller[2]: ", @_, "\n";
}

sub round
{
	my ($f) = @_;

	return $f < 0 ? int($f - 0.5) : int($f + 0.5);
}

sub width
{
	return 1000;
}

sub mm_to_100mils
{
	my ($v) = @_;

	return round(100 * $v * 39.3700787);
}

sub xcoord
{
	my ($c) = @_;

	return round(100 * $c);
}

sub ycoord
{
	my ($c) = @_;

	return round(100 * $c);
}

sub size
{
	my ($s) = @_;

	return abs(round(100 * $s));
}

sub attr
{
	my ($name, $value) = @_;

	println("\tAttribute($name $value)");
}

sub pin
{
	my ($x, $y, $drill, $copper, $name, $nr, $type) = @_;

	$type = $type || "";

	println("\tPin[" .
	        xcoord($x) . " " .
	        ycoord($y) . " " .
		size($copper) . " " .
		size(1.1 * $copper) . " " .
		size($copper) . " " .
		size($drill) .
	        " \"$name\" \"$nr\" \"$type\"]");
}

sub line
{
	my ($x1, $y1, $x2, $y2, $w) = @_;

	println("\tElementLine[" .
		xcoord($x1) . " " .
		ycoord($y1) . " " .
		xcoord($x2) . " " .
		ycoord($y2) . " " .
		" $w]");
}

sub arc
{
	my ($x, $y, $w, $h, $start_angle, $delta_angle, $s) = @_;

	println("\tElementArc[" .
	        xcoord($x) . " " .
	        ycoord($y) . " " .
		size($w) . " " .
		size($h) .
		" $start_angle $delta_angle $s]");
}

sub shape
{
	my $x = shift @_;
	my $y = shift @_;
	my $w = width();

	for my $shape (@_) {
		if ($shape->[0] eq "HL") {
			line($x, $y, $x + $shape->[1], $y, $w);
			$x += $shape->[1];
		} elsif ($shape->[0] eq "VL") {
			line($x, $y, $x, $y + $shape->[1], $w);
			$y += $shape->[1];
		} elsif ($shape->[0] eq "L") {
			line($x, $y, $x + $shape->[1], $y + $shape->[2], $w);
			$x += $shape->[1];
			$y += $shape->[1];
		} elsif ($shape->[0] eq "HA") {
			arc($x + $shape->[2]/2, $y, $shape->[2]/2, $shape->[2]/2, 0, $shape->[1], $w);
			$x += $shape->[2];
		} else {
			w("Invalid shape '$shape->[0]'!");
		}
	}
}

sub begin
{
	my ($desc) = @_;

	println("Element[\"\" \"$desc\" \"\" \"\" 100000 100000 1000 1000 0 100 \"\"]");
	println("(");
}

sub end
{
	println(")");
}

1;
