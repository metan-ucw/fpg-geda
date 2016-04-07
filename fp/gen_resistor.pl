#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;

#
# R0207
#
#            | - 6.3 mm - |
#
#            +==--------==+ - - - - - - -
# -----------|            |------------ 2.5 mm
#            +==--------==+ - - - - - - -
#
#
sub R0207
{
	print("Generating R0207.fp...\n");
	open(my $fp, ">R0207.fp") or die $!;
	select $fp;

	fp::begin("R0207 Resistor");
	fp::set_unit("um");

	fp::pin_s(0, 0, 600, 2000, "Pin_1", "1", "");
	fp::pin_s(10000, 0, 600, 2000, "Pin_2", "2", "");

	fp::resistor(0, 0, 10000, 0);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# R0207 staying, space between pins is 0.7 mm.
#
sub R0207_stay
{
	print("Generating R0207_stay.fp...\n");
	open(my $fp, ">R0207_stay.fp") or die $!;
	select $fp;

	fp::begin("R0207 Resistor staying");
	fp::set_unit("um");

	fp::pin_s(0, 0, 600, 2000, "Pin_1", "1", "");
	fp::circle(0, 0, 1250);
	fp::hline(1250, 2400, 0);
	fp::pin_s(2700, 0, 600, 2000, "Pin_2", "2", "");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# R0204
#
#            | - 4.1 mm - |
#
#            +==--------==+ - - - - - - -
# -----------|            |------------ 1.8 mm
#            +==--------==+ - - - - - - -
#
sub R0204
{
	print("Generating R0204.fp...\n");
	open(my $fp, ">R0204.fp") or die $!;
	select $fp;

	fp::begin("R0204 Resistor");
	fp::set_unit("um");

	fp::pin_s(0, 0, 550, 1600, "Pin_1", "1", "");
	fp::pin_s(6000, 0, 550, 1600, "Pin_2", "2", "");
	fp::resistor(0, 0, 6000, 0);

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

#
# R0204 staying space between pins is 0.5 mm.
#
sub R0204_stay
{
	print("Generating R0204_stay.fp...\n");
	open(my $fp, ">R0204_stay.fp") or die $!;
	select $fp;

	fp::begin("R0204 Resistor staying");
	fp::set_unit("um");

	fp::pin_s(0, 0, 550, 1600, "Pin_1", "1", "");
	fp::circle(0, 0, 900);
	fp::hline(900, 1835, 0);
	fp::pin_s(2100, 0, 550, 1600, "Pin_2", "2", "");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

R0207();
R0207_stay();
R0204();
R0204_stay();
