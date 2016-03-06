#!/usr/bin/perl

use lib '../../lib/';
use sym;

use strict;
use warnings;

sub draw_digits
{
	my ($x, $y, $w, $h, $type) = @_;
	my $size = $w / 10;
	my $padd = $w / 5;
	my %style = ("line_size" => $size, "cap_style" => "round");
	my %text_style = ("size" => 4, "origin" => "mc");

	sym::box($x, $y, $w, $h);

	my $y1 = $y + $padd + $size;
	my $y2 = $y + $h/2 - $size;
	my $y3 = $y + $h/2 + $size;
	my $y4 = $y + $h - $padd - $size;

	sym::vline($x + $w - $padd, $y1, $y2, %style);
	sym::text($x + $w - $padd, ($y1 + $y2)/2, 1, 0, "C", %text_style);

	sym::vline($x + $w - $padd, $y3, $y4, %style);
	sym::text($x + $w - $padd, ($y3 + $y4)/2, 1, 0, "B", %text_style);

	if ($type eq "1") {
		my $s = int(1.5 * $size);
		my $x1 = $x + $w/2 + $s - $size;
		my $x2 = $x + $w/2 - $s - $size;
		my $y1 = $y + $h/2 + $s + 3 * $size;
		my $y2 = $y + $h/2 - $s + 3 * $size;

		sym::hline($x1, $x2, $y + $h/2, %style);
		sym::text(($x1 + $x2)/2, $y + $h/2, 1, 0, "-", %text_style);

		sym::hline($x1, $x2, $y + $h/2 + 3 * $size, %style);
		sym::vline(($x1 + $x2)/2, $y1, $y2, %style);
		sym::text(($x1 + $x2)/2, ($y1 + $y2)/2, 1, 0, "+", %text_style);

		return;
	}

	my $x1 = $x + $padd + $size;
	my $x2 = $x + $w - $padd - $size;

	sym::hline($x1, $x2, $y + $padd, %style);
	sym::text(($x1 + $x2)/2, $y + $padd, 1, 0, "D", %text_style);

	sym::vline($x + $padd, $y1, $y2, %style);
	sym::text($x + $padd, ($y1 + $y2)/2, 1, 0, "E", %text_style);

	sym::hline($x1, $x2, $y + $h/2, %style);
	sym::text(($x1 + $x2)/2, $y + $h/2, 1, 0, "G", %text_style);

	sym::vline($x + $padd, $y3, $y4, %style);
	sym::text($x + $padd, ($y3 + $y4)/2, 1, 0, "F", %text_style);

	sym::vline($x + $w - $padd, $y3, $y4, %style);
	sym::text($x + $w - $padd, ($y3 + $y4)/2, 1, 0, "B", %text_style);

	sym::hline($x1, $x2, $y + $h - $padd, %style);
	sym::text(($x1 + $x2)/2, $y + $h - $padd, 1, 0, "A", %text_style);

	sym::circle($x + $w - $size, $y + $padd, int($size/2), ("fill" => 1));
}

my @displays = (
	["ca-1", "8", "Vcc", "F", "G", "E", "D", "Vcc", "DP", "C", "B", "A"],
	["ca-2", "8", "E", "D", "Vcc", "C", "DP", "B", "A", "Vcc", "F", "G"],
	["ca-3", "8", "Vcc", "E", "D", "C", "Vcc", "B", "A", "DP", "F", "G"],
	["cc-1", "8", "GND", "F", "G", "E", "D", "GND", "DP", "C", "B", "A"],
	["cc-2", "8", "E", "D", "GND", "C", "DP", "B", "A", "GND", "F", "G"],
	["cc-3", "8", "GND", "E", "D", "C", "GND", "B", "A", "DP", "F", "G"],

	["ca-1", "1", "Vcc", "+", "-", "NC", "NC", "VCC", "DP", "B", "C", "NC"],
	["cc-1", "1", "GND", "+", "-", "NC", "NC", "GND", "DP", "B", "C", "NC"],

	["ca-4", "8", "A", "F", "Vcc", "NP", "NP", "NC", "E", "D", "DP", "C", "G", "NP", "B", "Vcc"],
	["lq4x0", "8", "A", "F", "Vcc", "NC", "NC", "DP", "E", "D", "Vcc", "C", "G", "NC", "B", "Vcc"],
	["lq3x0", "1", "Vcc", "NC", "Vcc", "NC", "NC", "NC", "+", "-", "NC", "B", "A", "NC", "NC", "Vcc"],
);

for (@displays) {
	my @pins = @$_;
	my $name = shift @pins;
	my $type = shift @pins;

	print("Generating 7segment-$type-$name.sym...\n");
	open(my $sym, ">7segment-$type-$name.sym") or die $!;
	select $sym;

	sym::header();

	my $pincnt = scalar(@pins);

	my $h = $pincnt * 100;
	my $w = sym::round_to_grid($h/1.6, 100);

	draw_digits(300, 100, $w, $h, $type);

	for (my $i = 0; $i < $pincnt/2; $i++) {
		my $ph = $h - 200 * $i;

		next if $pins[$i] eq "NP";

		sym::pin(100, $ph, 200, $ph,
		         ["pas"],
			 [$pins[$i], 290, $ph+10, 1, 1, {"size" => 4, "origin" => "br"}],
			 [$i+1], [$i+1]);

		sym::hline(200, 300, $ph);
	}

	for (my $i = $pincnt/2; $i < $pincnt; $i++) {
		my $ph = 200 * ($i - $pincnt/2 + 1);

		next if $pins[$i] eq "NP";

		sym::pin($w + 500, $ph, $w + 400, $ph,
		         ["pas"],
			 [$pins[$i], $w + 310, $ph+10, 1, 1, {"size" => 4, "origin" => "bl"}],
			 [$i+1], [$i+1]);

		sym::hline($w + 300, $w + 400, $ph);
	}

	sym::text(0, 250, 0, 1, "device=7_SEGMENT_DISPLAY");
	sym::text($w + 300, $h + 125, 1, 1, "refdes=D?", ("origin" => "br"));

	select STDOUT;
	close($sym);
}
