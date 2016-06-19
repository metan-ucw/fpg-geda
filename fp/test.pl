#!/usr/bin/perl

use lib '../lib/';
use fp;

use strict;
use warnings;

sub test_coil
{
	fp::coil(0, 0, 0, 1000, 3);
	fp::coil(0, 0, 1000, 0, 7);
	fp::coil(0, 0, 1000, 1000, 5);
	fp::coil(0, 0, 1000, 500, 2);
}

sub test_diode
{
	fp::diode(0, 0, 1000, 0);
	fp::diode(0, 0, 1000, 1000);
	fp::diode(1000, 0, 600, 700);
}

sub test_cap
{
	fp::capacitor(0, 0, 1000, 0, "polarized");
	fp::capacitor(0, 0, 500, 1000);
	fp::capacitor(1000, 1000, 1000, 2000);
	fp::capacitor(1000, 2000, 2000, 2000, "polarized");
	fp::capacitor(0, 2000, 1000, 2000);
	fp::capacitor(2000, 2900, 2000, 2000);
}

sub test_resistor
{
	fp::resistor(0, 0, 1000, 1000);
	fp::resistor(0, 0, 1000, 0);
	fp::resistor(1900, 1000, 1000, 0);
}

fp::begin("Footprint library test");
fp::set_unit("mm");
fp::set_line_width(30000);
test_coil();
fp::add_origin(0, 1000);
test_cap();
fp::add_origin(2000, 0);
test_resistor();
fp::add_origin(0, 1000);
test_diode();
fp::add_origin(200, 1200);
fp::koch(2000, 4);
fp::end("Cyril Hrubis");
