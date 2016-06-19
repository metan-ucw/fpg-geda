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

my @voltages = ("", "1.5V", "3V", "3.3V", "4.5V", "5V", "6V", "7.5V", "9V",
                "12V", "24V", "-5V", "-9V", "-12V", "-24V");

for my $voltage (@voltages) {
	my $fname = $voltage eq "" ? "" : "-$voltage";
	my $netname = "Vcc$voltage";
	my $label = $voltage eq "" ? "Vcc" : "$voltage";
	print("Generating vcc$fname-1.sym...\n");
	open(my $sym, ">vcc$fname-1.sym") or die $!;
	select $sym;
	sym::header();
	sym::vline(300, 300, 200, ('line_size' => 10));
	sym::circle(300, 350, 50, ('line_size' => 15));
	sym::text(300, 425, 1, 0, $label, ('origin' => 'bc', 'color' => 9));
	sym::pin(300, 100, 300, 200, ["pwr"], [$label], ["1"], ["1"]);
	sym::text(300, 500, 0, 1, "net=$netname:1");
	select STDOUT;
	close($sym);
}
