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

my $line_width = 1000;
sub width
{
	return $line_width;
}

sub set_line_width
{
	($line_width) = @_;
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

sub add_origin
{
	my ($x, $y) = @_;

	$x_origin += $unit_mul * $x;
	$y_origin += $unit_mul * $y;
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

	$w = $w || width();

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
	my $x = 0;
	my $y = 0;
	my $w;
	my $h;

	if (@_ == 7 or @_ == 6) {
		$x = shift;
		$y = shift;
		$w = shift;
		$h = shift;
	} else {
		$w = shift;
		$h = $w;
	}

	my ($start_angle, $delta_angle, $s) = @_;

	$s = $s || width();

	println("\tElementArc[" .
	        xcoord($x) . " " .
	        ycoord($y) . " " .
		size($w) . " " .
		size($h) .
		" $start_angle $delta_angle $s]");
}

sub circle
{
	my ($x, $y, $r) = @_;

	arc($x, $y, $r, $r, 0, 360);
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
	my $x = 0;
	my $y = 0;

	if (@_ == 4 || @_ == 5) {
		$x = shift;
		$y = shift;
	}

	my ($w, $h) = @_;
	my $lw = width();

	hline($x, $x+$w, $y, $lw);
	vline($x, $y, $y+$h, $lw);
	vline($x+$w, $y, $y+$h, $lw);
	hline($x, $x+$w, $y+$h, $lw);
}

sub lineto
{
	my ($x, $y) = @_;

	line(0, 0, $x, $y);
	add_origin($x, $y);
}

sub koch_render
{
	my ($x1, $y1, $x2, $y2, $iter) = @_;

	if ($iter == 0) {
		line($x1, $y1, $x2, $y2);
		return;
	}

	my $x = ($x1+$x2)/2 + sqrt(3)*($y2-$y1)/6;
        my $y = ($y1+$y2)/2 - sqrt(3)*($x2-$x1)/6;

	koch_render($x1, $y1, 2*$x1/3 + $x2/3, 2*$y1/3 + $y2/3, $iter-1);
	koch_render(2*$x1/3 + $x2/3, 2*$y1/3 + $y2/3, $x, $y, $iter-1);
	koch_render($x, $y, $x1/3 + 2*$x2/3, $y1/3 + 2*$y2/3, $iter-1);
	koch_render($x1/3 + 2*$x2/3, $y1/3 + 2*$y2/3, $x2, $y2, $iter-1);
}

sub koch
{
	my ($l, $iter) = @_;

	my $x = $l/2;
	my $y = $l/2 * sqrt(3);

	koch_render(0, 0, $l, 0, $iter);
	koch_render($l, 0, $x, $y, $iter);
	koch_render($x, $y, 0, 0, $iter);
}

sub resistor
{
	my ($x1, $y1, $x2, $y2) = @_;
	my $vx = $x2 - $x1;
	my $vy = $y2 - $y1;

	my @origin = ($x_origin, $y_origin);

	lineto($vx/5, $vy/5);
	add_origin(-$vy/10, $vx/10);

	my $x3 =  $vy/5;
	my $y3 = -$vx/5;
	my $x4 = 3*$vx/5;
	my $y4 = 3*$vy/5;

	line(0, 0, $x3, $y3);
	line(0, 0, $x4, $y4);

	my $x5 = $x3 + $x4;
	my $y5 = $y3 + $y4;;

	line($x3, $y3, $x5, $y5);
	line($x4, $y4, $x5, $y5);

	add_origin($x4 + $vy/10, $y4 - $vx/10);

	lineto($vx/5, $vy/5);

	($x_origin, $y_origin) = @origin;
}

sub diode
{
	my ($x1, $y1, $x2, $y2) = @_;
	my @origin = ($x_origin, $y_origin);

	add_origin($x1, $y1);

	lineto($x2/3, $y2/3);
	line(-$y2/6, $x2/6, $y2/6, -$x2/6);
	line(-$y2/6, $x2/6, $x2/3, $y2/3);
	line($y2/6, -$x2/6, $x2/3, $y2/3);
	add_origin($x2/3, $y2/3);
	line(-$y2/6, $x2/6, $y2/6, -$x2/6);
	lineto($x2/3, $y2/3);

	($x_origin, $y_origin) = @origin;
}

#
# Draws a + sign
# x1, y1 is center
# x2, y2 is right corner
#
sub plus
{
	my ($x1, $y1, $x2, $y2) = @_;

	my $vx = $x2 - $x1;
	my $vy = $y2 - $y1;

	line($x1 - $vx, $y1 - $vy, $x2, $y2);
	line($x1 - $vy, $y1 + $vx, $x1 + $vy, $y1 - $vx);
}

sub capacitor
{
	my ($x1, $y1, $x2, $y2, $type) = @_;
	my $vx = $x2 - $x1;
	my $vy = $y2 - $y1;
	my @origin = ($x_origin, $y_origin);

	if ($type and $type eq "polarized") {
		my $x = $x2 + $vy/6 - $vx/6;
		my $y = $y2 - $vx/6 - $vy/6;
		plus($x, $y, $x + $vx/10, $y + $vy/10);
	}

	add_origin($x1, $y1);
	lineto(2*$vx/5, 2*$vy/5);
	line(-$vy/3, $vx/3, $vy/3, -$vx/3);
	add_origin($vx/5, $vy/5);

	if (not $type) {
		line(-$vy/3, $vx/3, $vy/3, -$vx/3);
	} elsif ($type eq "polarized") {
		line(-$vy/3, $vx/3, $vy/3, -$vx/3);
	}

	lineto(2*$vx/5, 2*$vy/5);

	($x_origin, $y_origin) = @origin;
}

sub coil
{
	my ($x1, $y1, $x2, $y2, $turns) = @_;
	my @origin = ($x_origin, $y_origin);
	my $parts = $turns + 2;
	my $dx = ($x2 - $x1)/$parts;
	my $dy = ($y2 - $y1)/$parts;
	my $r = sqrt(($dx/2)**2 + ($dy/2)**2);
	my $alpha = 180 - 180 * atan2($dy, $dx)/3.1415;

	add_origin($x1, $y1);

	lineto($dx, $dy);
	add_origin($dx/2, $dy/2);

	for (my $i = 0; $i < $turns; $i++) {
		arc($r, $alpha, 180);
		add_origin($dx, $dy);
	}

	add_origin(-$dx/2, -$dy/2);
	lineto($dx, $dy);

	($x_origin, $y_origin) = @origin;
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
