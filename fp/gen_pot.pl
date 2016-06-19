#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;


#
# TP160A tesla potentiometer, should also work for TP160P (plastic body)
#
#
#
# >  16 mm  <   > 10.5 <
#  |       |     |    |
#   .-^^^-.       ----
#  /   _   \     |    |--  - - -
#  |  ( )  |     |    |  |XX==== 7 mm
#  \       /     |    |--  - - -
#  | o o o |      --- |
#   -/-|-\-          ||
#    X X X           ||
#    | | |            |
#   > <
#    1 mm
#   > - - <
#     10 mm
#
sub TP160
{
	print("Generating pot_TP160.fp...\n");
	open(my $fp, ">pot_TP160.fp") or die $!;
	select $fp;

	fp::begin("Tesla potentiometer TP160A/TP160P");
	fp::set_unit("um");

	fp::pin_s(0, 0, 1400, 3000, "Pin_1", "1", "");
	fp::pin_s(5000, 0, 1400, 3000, "Pin_2", "2", "");
	fp::pin_s(10000, 0, 1400, 3000, "Pin_3", "3", "");

	fp::add_origin(-3000, -8800);
	fp::rect(16000, 10500);
	fp::rect(4500, 10500, 7000, 2000);

	fp::line(4500, 10750, 11500, 11250);
	fp::line(4500, 11250, 11500, 11750);
	fp::line(4500, 11750, 11500, 12250);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

TP160();
