#!/usr/bin/perl
#
# Copyright (C) 2009-2016 Cyril Hrubis <metan@ucw.cz>
#
# fpg-geda code is distributed under GPLv2+
#
# See <http://www.gnu.org/licenses/> for more information
#

use lib '../../lib/';
use sym;

use strict;
use warnings;

sub gen_contact
{
	my ($x1, $x2, $y, $nr) = @_;
	my $x3 = $x1 < $x2 ? $x2 - 100 : $x2 + 100;

	sym::dot($x1, $y);
	sym::line($x1, $y, $x3, $y);
	sym::pin($x2, $y, $x3, $y, ["pas"], ["pas"], ["$nr"], ["$nr"]);
}

sub gen_switch
{
	my ($contacts, $y_off, $pin_off) = @_;
	my %line_style = ("line_size" => 15, "cap_style" => "round");

	if ($contacts == 1) {
		gen_contact(300, 100, 100 + $y_off, 1 + $pin_off);
		gen_contact(700, 900, 100 + $y_off, 2 + $pin_off);
		sym::line(300, 100 + $y_off, 650, 300 + $y_off, %line_style);
		return (100 + $y_off, 475, 200 + $y_off);
	}

	if ($contacts == 2) {
		gen_contact(700, 900, $y_off, 2 + $pin_off);
		gen_contact(700, 900, 400 + $y_off, 3 + $pin_off);
		gen_contact(300, 100, 200 + $y_off, 1 + $pin_off);
		sym::line(300, 200 + $y_off, 700, 400 + $y_off, %line_style);
		return (400 + $y_off, 500, 300 + $y_off);
	}

	my $spacing = 200;
	my @sizes = (0, 0, 0, 600, 600, 600, 600, 700, 800, 800, 900, 900, 900);
	my $size = $sizes[$contacts];

	my $y_mid = $spacing * ($contacts - 1)/ 2;
	my $r = $spacing * int($contacts/2) + 400;
	my $x_off = $size - $r + 100;
	my $x_max_grid = $size + 300;

	for (my $i = 0; $i < $contacts; $i++) {
		my $y = $spacing * $i;
		my $y_dis = $y - $y_mid;
		my $x = int(sqrt($r * $r - $y_dis * $y_dis)) + $x_off;

		gen_contact($x, $x_max_grid, $y + $y_off, $i + 2 + $pin_off);
	}

	my $y_max = $spacing * ($contacts-1);
	my $y_dis = $y_max - $y_mid;
	my $x_end = int(sqrt($r * $r - $y_dis * $y_dis)) + $x_off;

	gen_contact(300, 100, $y_mid + $y_off, 1 + $pin_off);
	sym::line(300, $y_mid + $y_off, $x_end, $y_max + $y_off, %line_style);

	my $x_m = 150 + int($x_end/2 + 0.5);
	my $y_m = int(($y_mid + $y_max)/2 + 0.5);

	return ($y_max + $y_off, $x_m, $y_m + $y_off);
}

sub gen_sym
{
	my ($name, $poles, $throws) = @_;

	sym::header();

	my @first = gen_switch($throws, 100, 0);
	my @last = @first;

	for (my $i = 0; $i < $poles-1; $i++) {
		@last = gen_switch($throws, $last[0] + 300, ($throws + 1) * ($i + 1));
	}

	if ($poles > 1) {
		sym::line($first[1], $first[2], $last[1], $last[2],
		          ("dash_style" => "dashed",
		           "dash_length" => 50, "dash_space" => 50));
	}

	sym::text(145, 0, 1, 1, "refdes=S?");
	sym::text(95, 0, 0, 1, "device=SWITCH_" . uc($name));
}

sub gen_name
{
	my ($poles, $throws) = @_;
	my $p = "sp";
	my $t = "st";

	if ($poles == 2) {
		$p = "dp";
	}

	if ($poles > 2) {
		$p = "${poles}p"
	}

	if ($throws == 2) {
		$t = "dt";
	}

	if ($throws > 2) {
		$t = "${throws}t";
	}

	return "$p$t";
}

for (my $p = 1; $p <= 4; $p++) {
	for (my $t = 1; $t <= 12; $t++) {
		if ($p <= 2 or $t <= 5) {
			my $name = gen_name($p, $t);

			print("Generating switch-$name-1.sym...\n");
			open(my $sym, ">switch-$name-1.sym") or die $!;
			select $sym;
			gen_sym($name, $p, $t);
			select STDOUT;
			close($sym);
		}
	}
}
