#!/usr/bin/perl

use lib '../../lib/';
use sym;

use strict;
use warnings;

sub gen_contact
{
	my ($x1, $x2, $y, $nr) = @_;
	my $x3;

	if ($x1 < $x2) {
		$x3 = $x2 - 100;
	} else {
		$x3 = $x2 + 100;
	}

	sym::dot($x1, $y);
	sym::line($x1, $y, $x3, $y);
	sym::pin($x2, $y, $x3, $y, ["pas"], ["pas"], ["$nr"], ["$nr"]);
}

sub gen_switch
{
	my ($contacts, $y_off) = @_;
	my %line_style = ("line_size" => 15, "cap_style" => "round");

	if ($contacts == 1) {
		gen_contact(300, 100, 100 + $y_off, 1);
		gen_contact(700, 900, 100 + $y_off, 2);
		sym::line(300, 100 + $y_off, 650, 300 + $y_off, %line_style);
		return;
	}

	my $spacing = 200;
	my $off = 11;

	if ($contacts > 2) {
		$spacing = 100;
		$off = 3;
	}

	my $y_mid = 100 + $spacing * ($contacts - 1);
	my $r = 2000;
	my $roff = 700 - $r + !($spacing%2) * $off;

	for (my $i = 0; $i < $contacts; $i++) {
		my $y = 100 + 2 * $spacing * $i;
		my $y_dis = $y - $y_mid;
		my $x = $roff + int(sqrt($r * $r - $y_dis * $y_dis));

		gen_contact($x, 900, $y + $y_off, $i + 2);
	}

	my $y_max = 100 + 2 * $spacing * ($contacts - 1);
	my $x_end = $roff + int(sqrt($r * $r - ($y_max-$y_mid) * ($y_max - $y_mid)));

	gen_contact(300, 100, $y_mid + $y_off, 1);
	sym::line(300, $y_mid + $y_off, $x_end, $y_max + $y_off, %line_style);
}

sub gen_sym
{
	my ($type) = @_;

	sym::header();

	if ($type eq "spst") {
		gen_switch(1, 0);
	} elsif ($type eq "spdt") {
		gen_switch(2, 0);
	} else {
		$type =~ s/[^0-9]//g;
		gen_switch($type, 0);
	}

	sym::text(145, 225, 1, 1, "refdes=S?");
	sym::text(95, 0, 0, 1, "device=SWITCH_" . uc($type));
}

my @types = ("spst", "spdt", "sp3t", "sp4t", "sp5t", "sp6t", "sp7t", "sp8t", "sp9t", "sp10t", "sp11t", "sp12t");

for my $type (@types) {
	print("Generating switch-$type-1.sym...\n");
	open(my $sym, ">switch-$type-1.sym") or die $!;
	select $sym;
	gen_sym($type);
	select STDOUT;
	close($sym);
}
