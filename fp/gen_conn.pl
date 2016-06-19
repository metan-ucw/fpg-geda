#!/usr/bin/perl
#
# Copyright (C) 2009-2016 Cyril Hrubis <metan@ucw.cz>
#
# fpg-geda code is distributed under GPLv2+
#
# See <http://www.gnu.org/licenses/> for more information
#

use lib '../lib/';
use fp;

use strict;
use warnings;

#
# Generates footprint for CH 3.96mm connector.
#
# (PSHXX-WG in http://www.gme.cz)
#
#            1.4mm
#            ||
#     _ _ _    _ _ _ _ _
#   |     \\ ()         |
#   |     // ||         |
#   |     || ||         8.7mm
# 12.5mm  || ||         |
#   |     |\------. - - 3.3mm
#   | _ _ \__--___| _ _ _
#            ||          3.3mm
#            \\_____     |
#             ------` ` `
#
#     3.96mm       1.98mm
#     `    `       ` `
#     `    `       ` `
#    ()   ()      () `
#    ||   ||      || `
#    ||   ||      || `
#    ||   ||      || `
#  .----------/ /----.
#  |          \ \    |
#  `----------/ /----`
#    []   []      []
#
sub conn_r_396
{
	my ($n) = @_;

	print("Generating con_${n}_r_396.fp...\n");
	open(my $fp, ">con_${n}_r_396.fp") or die $!;
	select $fp;

	my $l = $n * 3960;

	fp::begin("Connector CH $n R 3.96mm");
	fp::set_unit("um");

	fp::rect($l, 17500);

	fp::hline(0, $l, 9700);
	fp::hline(0, $l, 12000);

	fp::set_origin(1980, 15900);

	pin_396(0, 0, "Pin_1", "1", "square");

	for (my $i = 1; $i < $n; $i++) {
		pin_396($i * 3960, 0, "Pin_$i", "$i", "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
#    3.96mm
#    `   `
#  ------------ \  \ ----   ` ` ` ` `
# |  `   `      /  /      | 5.57mm  |
# |             \  \      |   |
# |  []  []  [] /  /  []  | ` `     9.8mm
# |  _--------- \  \ --_  |
#  ------------ /  / -----  ` ` ` ` `
#
sub conn_s_396
{
	my ($n) = @_;

	print("Generating con_${n}_s_396.fp...\n");
	open(my $fp, ">con_${n}_s_396.fp") or die $!;
	select $fp;

	my $l = $n * 3960;

	fp::begin("Connector $n S 3.96mm");
	fp::set_unit("um");

	fp::rect($l, 9800);
	fp::hline(0, $l, 8400);

	fp::set_origin(1980, 5570);

	pin_396(0, 0, "Pin_1", "1", "square");

	for (my $i = 1; $i < $n; $i++) {
		pin_396($i * 3960, 0, "Pin_$i", "$i", "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}


sub pin_396
{
	my ($x, $y, $name, $num, $flags) = @_;

	fp::pin($x, $y, 3000, 4000, 3000, 1700, $name, $num, $flags);
}

#
# Generates footprint for CH 2.54mm connector.
#
# (PSHXX-PG in http://www.gme.cz)
#
#            0.64mm
#            ||
#     _ _ _    _ _ _ _ _
#   |     \\ ()         |
#   |     // ||         |
#   |     || ||         7.7mm
# 11.4mm  || ||         |
#   |     |\------. - - 3.3mm
#   | _ _ \__--___| _ _ _
#            \\_____    1.48mm
#             ------` ` `
#
#     2.54mm       1.27mm
#     `    `       ` `
#     `    `       ` `
#    ()   ()      () `
#    ||   ||      || `
#    ||   ||      || `
#    ||   ||      || `
#  .----------/ /----.
#  |          \ \    |
#  `----------/ /----`
#    []   []      []
#
sub conn_r_254
{
	my ($n) = @_;

	print("Generating con_${n}_r_254.fp...\n");
	open(my $fp, ">con_${n}_r_254.fp") or die $!;
	select $fp;

	my $l = $n * 2540;

	fp::begin("Connector $n R 2.54mm");
	fp::set_unit("um");

	fp::rect($l, 14200);

	fp::hline(0, $l, 8100);
	fp::hline(0, $l, 11400);

	fp::set_origin(1270, 12880);

	pin_254(0, 0, "Pin_1", "1", "square");

	for (my $i = 1; $i < $n; $i++) {
		pin_254($i * 2540, 0, "Pin_$i", "$i", "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
#    2.54mm
#    `   `
#  ------------ \  \ ----   ` ` ` ` `
# |  `   `      /  /      | 3.26mm  |
# |             \  \      |   |
# |  []  []  [] /  /  []  | ` `     5.8mm
# |  _--------- \  \ --_  |
#  ------------ /  / -----  ` ` ` ` `
#
sub conn_s_254
{
	my ($n) = @_;

	print("Generating con_${n}_s_254.fp...\n");
	open(my $fp, ">con_${n}_s_254.fp") or die $!;
	select $fp;

	my $l = $n * 2540;

	fp::begin("Connector $n S 2.54mm");
	fp::set_unit("um");

	fp::rect($l, 5800);
	fp::hline(0, $l, 5000);

	fp::set_origin(1270, 3260);

	pin_254(0, 0, "Pin_1", "1", "square");

	for (my $i = 1; $i < $n; $i++) {
		pin_254($i * 2540, 0, "Pin_$i", "$i", "");
	}

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

sub pin_254
{
	my ($x, $y, $name, $num, $flags) = @_;

	fp::pin($x, $y, 1400, 1700, 2000, 800, $name, $num, $flags);
}

for (my $i = 2; $i <= 13; $i++) {
	conn_r_396($i);
	conn_s_396($i);
}

for (my $i = 2; $i <= 16; $i++) {
	conn_r_254($i);
	conn_s_254($i);
}
