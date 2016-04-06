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

# Default units are mils
my $unit_mul = 100;

# Origin added to everything in pcb units i.e. mils * 100
my $x_origin = 0;
my $y_origin = 0;

sub set_unit
{
	my ($unit) = @_;

	if ($unit eq "pcb") {
		$unit_mul = 1;
	} elsif ($unit eq "mil") {
		$unit_mul = 100;
	} elsif ($unit eq "mm") {
		$unit_mul = 3937.00787;
	} elsif ($unit eq "um") {
		$unit_mul = 3.93700787;
	} else {
		w("Invalid unit $unit");
	}
}

sub set_origin
{
	my ($x, $y) = @_;

	$x_origin = $unit_mul * $x;
	$y_origin = $unit_mul * $y;
}

sub xcoord
{
	my ($c) = @_;

	return round($unit_mul * $c + $x_origin);
}

sub ycoord
{
	my ($c) = @_;

	return round($unit_mul * $c + $y_origin);
}

sub size
{
	my ($s) = @_;

	return abs(round($unit_mul * $s));
}

sub attribute
{
	my ($name, $value) = @_;

	println("\tAttribute(\"$name\" \"$value\")");
}

sub pin
{
	my ($x, $y, $copper, $clearance, $mask, $drill, $name, $nr, $type) = @_;

	$type = $type || "";

	println("\tPin[" .
	        xcoord($x) . " " .
	        ycoord($y) . " " .
		size($copper) . " " .
		size($clearance) . " " .
		size($mask) . " " .
		size($drill) .
	        " \"$name\" \"$nr\" \"$type\"]");
}

sub pin_s
{
	my ($x, $y, $drill, $copper, $name, $nr, $type) = @_;

	pin($x, $y, $copper, 1.1 * $copper, $copper, $drill, $name, $nr, $type);
}

sub line
{
	my ($x1, $y1, $x2, $y2, $w) = @_;

	println("\tElementLine[" .
		xcoord($x1) . " " .
		ycoord($y1) . " " .
		xcoord($x2) . " " .
		ycoord($y2) .
		" $w]");
}

sub hline
{
	my ($x1, $x2, $y, $w) = @_;

	line($x1, $y, $x2, $y, $w);
}

sub vline
{
	my ($x, $y1, $y2, $w) = @_;

	line($x, $y1, $x, $y2, $w);
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

sub rect
{
	my ($x, $y, $w, $h) = @_;
	my $lw = width();

	hline($x, $x+$w, $y, $lw);
	vline($x, $y, $y+$h, $lw);
	vline($x+$w, $y, $y+$h, $lw);
	hline($x, $x+$w, $y+$h, $lw);
}

sub begin
{
	my ($desc) = @_;

	println("Element[\"\" \"$desc\" \"\" \"\" 100000 100000 1000 1000 0 100 \"\"]");
	println("(");
	attribute("description", $desc);
}

sub end
{
	my ($author) = @_;

	attribute("dist-license", "GPLv2");
	attribute("use-license", "Unlimited");
	attribute("author", "$author; Created by fpg-geda.");
	attribute("copyright", $author);
	println(")");

	set_origin(0, 0);
	set_unit("mil");
}

1;
