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
# TO220 heat sink footprint with one solder pin
#
# (V7142A or V7142B)
#
# | - - 24mm - - -|
#                   - - - - - -
# ||< - 22mm - ->||   |       |
# ||             ||   6.6mm   16mm
# ||_____________|| _ _
# | _  _     _  _ | _ _ 1.6mm |
# || || | O | || ||   |
# || || |/ \| || ||   7.8mm   |
# || || || || || || - - - - - -
#
#     | |
# ||   3.4mm
#  1mm
#
# .._____________.. _ _ _ _ _
# ||             ||         |
# ||      _      ||
# ||     ( )     ||         |
# ||             ||
# ||             ||         V7142A   25mm
# ||             ||         V7142B,C 40mm
# ||             ||         |
# ||             ||
# ||             ||         |
# ||_____________|| _ _ _ _ _
#         ||
#         ||
#
#         ||
#          2mm      /
#   2mm_            \
#       \         __/  _ _
#        \/-\    |       |
#        (\  )   |       2mm
#         \ /    | _ _ _ _
#         / \    |       2.8mm
#        / ^ \   | _ _ _ _
#       |  |  |  |       |
#       | 1mm |  |
#       |     |  |       |
#       |     |  |       3mm
#       |     |  |
#       |     |  |       |
#    |__|     |__| _ _ _ _
#
#       |3.4mm|
sub V7141
{
	my $fp = fp::begin("heatsink_V7141", "V7141 TO220 heat sink with soldering pin", "Cyril Hrubis");

	fp::set_unit($fp, "um");

	fp::pin_s($fp, 0, 0, 1700, 3000, "Pin_1", "1");
	fp::set_origin($fp, -12000, -9200);

	fp::vline($fp, 16000);
	fp::hlineto($fp, 1000);
	fp::vlineto($fp, 6600);
	fp::hlineto($fp, 22000);
	fp::vlineto($fp, -6600);
	fp::hlineto($fp, 1000);
	fp::vlineto($fp, 16000);
	fp::hlineto($fp, -1000);
	fp::vlineto($fp, -7800);
	fp::hlineto($fp, -3400);
	fp::vlineto($fp, 7800);
	fp::hlineto($fp, -1000);
	fp::vlineto($fp, -7800);
	fp::hlineto($fp, -3400);
	fp::vlineto($fp, 7800);
	fp::hlineto($fp, -1000);
	fp::vlineto($fp, -3000);
	fp::lineto($fp, -1700, -2800);
	fp::hlineto($fp, -1000);
	fp::lineto($fp, -1700, 2800);
	fp::vlineto($fp, 3000);
	fp::hlineto($fp, -1000);
	fp::vlineto($fp, -7800);
	fp::hlineto($fp, -3400);
	fp::vlineto($fp, 7800);
	fp::hlineto($fp, -1000);
	fp::vlineto($fp, -7800);
	fp::hlineto($fp, -3400);
	fp::vlineto($fp, 7800);
	fp::hlineto($fp, -1000);

	fp::end($fp);
}

V7141();
