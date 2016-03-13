#!/usr/bin/perl

use lib '../../lib/';
use sym;

use strict;
use warnings;

sub gen_mos
{
	my ($type, $y, $x_off) = @_;

	sym::vline(600, 400, 200);
	sym::vline(600, 600, 800);

	sym::hline(500 + $x_off, 600, 600, ("cap_style" => "round"));
	sym::hline(500 + $x_off, 600, 400, ("cap_style" => "round"));

	if ($type =~ /mos-e/) {
		my $ls = 80;
		my $ss = (300 - 3 * $ls) / 2;
		my $sy = 350;
		my %ls = ("line_size" => 25);
		my $x = 500 + $x_off;

		sym::vline($x, $sy, $sy + $ls, %ls);
		$sy += $ls + $ss;
		sym::vline($x, $sy, $sy + $ls, %ls);
		$sy += $ls + $ss;
		sym::vline($x, $sy, $sy + $ls, %ls);
	} else {
		sym::vline(500, 350, 650, ("line_size" => 35));
	}

	if ($type =~ /n-jfet/) {
		sym::path("M", [485, $y-5], "L", [485, $y+5, 360, $y + 25, 360, $y - 25], "z",
		          ("fill" => 1, "line_size" => 0));
	}

	if ($type =~ /p-jfet/) {
		sym::path("M", [300, $y-5], "L", [300, $y+5, 425, $y + 25, 425, $y - 25], "z",
		          ("fill" => 1, "line_size" => 0));
	}

	if ($type =~ /jfet/) {
		sym::hline(200, 500, $y);
	} else {
		my $x1 = 200 + $x_off;
		my $x2 = $x_off + ($type =~ /diode/ ? 450 : 440);

		sym::hline($x1, $x2, $y);
		sym::vline($x2, 400, 600, ("cap_style" => "round"));
	}

	if ($type =~ /p-mos-e/) {
		my $x1 = 595 + $x_off;
		my $x2 = 525 + $x_off;
		my $x3 = 500 + $x_off;

		sym::path("M", [$x1, 495], "L", [$x1, 505, $x2, 500 + 25, $x2, 500 - 25], "z",
		          ("fill" => 1, "line_size" => 0));
		sym::hline($x3, $x3+100, 500);
		sym::vline($x3 + 100, 495, 600);
	}

	if ($type =~ /n-mos-e/) {
		my $x1 = 500 + $x_off;
		my $x2 = 575 + $x_off;
		my $x3 = 600 + $x_off;

		sym::path("M", [$x1, 500], "L", [$x2, 500 + 25, $x2, 500 - 25], "z",
		          ("fill" => 1, "line_size" => 0));

		sym::hline($x2, $x3, 500, ("cap_style" => "round"));
		sym::vline($x3, 500, 400);
	}

}

sub gen_transistor
{
	my ($type) = @_;
	my @pins;
	my $y = 500;

	$y = 600 if $type =~ /^p-/;
	$y = 400 if $type =~ /^n-/;

	sym::header();
	sym::circle(500, 500, 225, ("line_size" => 15));

	if ($type =~ /(npn|pnp)/) {
		sym::hline(200, 350, 500);
		sym::vline(600, 300, 200);
		sym::vline(600, 700, 800);

		sym::line(350, 500, 600, 300);
		sym::line(350, 500, 600, 700);

		sym::box(350, 375, 50, 250, ("fill" => 1, "line_size" => 0));

		if ($type eq "npn") {
			sym::path("M", [525, 400], "L", [600, 300, 484, 354], "z",
			          ("fill" => 1, "line_size" => 0));
		}

		if ($type eq "pnp") {
			sym::path("M", [471, 364], "L", [396, 464, 512, 410], "z",
			          ("fill" => 1, "line_size" => 0));
		}

		@pins = ("C", "B", "E");
	} else {
		my $x_off = $type =~ /diode/ ? -60 : 0;

		gen_mos($type, $y, $x_off);

		if ($type =~ /diode/) {
			my $ds = 30;
			my $dx = 600;

			sym::vline($dx, 400, 600);

			sym::circle(600, 400, 15, ("fill" => 1, "line_size" => 0));
			sym::circle(600, 600, 15, ("fill" => 1, "line_size" => 0));

			if ($type =~ /^p-/) {
				sym::path("M", [$dx, 495 - $ds],
					  "L", [$dx + $ds, 500 + $ds, $dx - $ds, 500 + $ds], "z",
					  ("fill" => 1, "line_size" => 0));
				sym::hline($dx - $ds, $dx + $ds, 500 - $ds);
			}

			if ($type =~ /^n-/) {
				sym::path("M", [$dx, 505 + $ds],
					  "L", [$dx + $ds, 500 - $ds, $dx - $ds, 500 - $ds], "z",
					  ("fill" => 1, "line_size" => 0));
				sym::hline($dx - $ds, $dx + $ds, 500 + $ds);
			}
		}

		@pins = ("D", "G", "S");
	}

	sym::pin(600, 900, 600, 800,
		 ["pas"], [$pins[0]], [$pins[0]], ["1"]);

	sym::pin(100, $y, 200, $y,
		 ["pas"], [$pins[1]], [$pins[1]], ["2"]);

	sym::pin(600, 100, 600, 200,
		 ["pas"], [$pins[2]], [$pins[2]], ["3"]);

	my $name = uc($type);

	sym::text(195, 795, 1, 1, "refdes=Q?");
	sym::text(95, 95, 0, 1, "device=TRANSISTOR_$name");
}

my @types = ("npn", "pnp", "n-jfet", "p-jfet", "p-mos-e", "n-mos-e", "p-mos-e-diode", "n-mos-e-diode");

for my $type (@types) {
	print("Generating $type-1.sym...\n");
	open(my $sym, ">$type-1.sym") or die $!;
	select $sym;
	gen_transistor($type);
	select STDOUT;
	close($sym);
}
