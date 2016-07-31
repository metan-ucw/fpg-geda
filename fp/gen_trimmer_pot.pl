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
# Size        -- Package overall size
# Hole/Width  -- Radius of the middle hole or package width
# Type        -- Horizontal or Vertical
# Spacing     -- Lenght between upper (second) pin and bottom (first and third)
#                pins, usually 2.5 mm, 5 mm, and 10 mm
#
sub trimmer
{
	my ($size, $hole_width, $type, $spacing) = @_;

	print("Generating trimmer_${size}mm_$type$spacing.fp...\n");
	open(my $fp, ">trimmer_${size}mm_$type$spacing.fp") or die $!;
	select $fp;

	fp::begin("Trimming Pot ${size}mm $type$spacing");
	fp::set_unit("um");

	$size *= 1000;
	$hole_width *= 1000;
	$spacing *= 1000;

	if ($type eq "V") {
		fp::rect($size, $size);
		fp::add_origin($size/2, $size/2);
		fp::circle($hole_width);
		fp::add_origin(0, -$spacing/2) if $spacing == 2500;
	} else {
		fp::rect($size, $hole_width);
		fp::add_origin($size/2, $hole_width/2);
	}

	fp::pin_s(-2500, $spacing/2, 1000, 2000, "Pin_1", "1");
	fp::pin_s(0, -$spacing/2, 1000, 2000, "Pin_2", "2");
	fp::pin_s(2500, $spacing/2, 1000, 2000, "Pin_3", "3");

	fp::end("Cyril Hrubis");
	select STDOUT;
	close($fp);
}

trimmer(6.5, 3.60, "H", 2.5);
trimmer(6.5, 1.25, "V", 2.5);
trimmer(6.5, 1.25, "V", 5.0);
trimmer(9.8, 2.00, "V", 10.0);
trimmer(9.8, 5.20, "H", 2.5);
