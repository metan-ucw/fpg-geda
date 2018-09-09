#!/usr/bin/perl
#
# Copyright (C) 2009-2016 Cyril Hrubis <metan@ucw.cz>
#
# fpg-geda code is distributed under GPLv2+
#
# See <http://www.gnu.org/licenses/> for more information
#

package fp_lihata;

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

sub println { print @_, "\n" }

sub write_padstack_circle
{
	my ($copper, $unit) = @_;

	println("       ha:ps_circ {");
	println("        x = 0");
	println("        y = 0");
	println("        dia = $copper$unit");
	println("       }");
}

sub write_padstack_rect
{
	my ($copper, $unit) = @_;
	my $c2 = $copper/2;
	my $nc2 = -$copper/2;

	println("       li:ps_poly {");
	println("        $nc2$unit");
	println("        $nc2$unit");
	println("        $c2$unit");
	println("        $nc2$unit");
	println("        $c2$unit");
	println("        $c2$unit");
	println("        $nc2$unit");
	println("        $c2$unit");
	println("       }");
}

sub write_padstack_long
{
	my ($copper, $unit, $type) = @_;

	my $c2 = $copper/4;

	my $square = 0;

	$square = 1 if ($type =~ /square/);

	println("       ha:ps_line {");
	println("        x1 = 0");
	println("        y1 = -${c2}$unit");
	println("        x2 = 0");
	println("        y2 = ${c2}$unit");
	println("        thickness = $copper$unit");
	println("        square = $square");
	println("       }");
}

sub write_padstack_shape
{
	my ($fp, $pin, $layer) = @_;
	my $type = $pin->{'type'};

	println("      ha:ps_shape_v4 {");
	println("       clearance = 0");

	if ($type eq '') {
		write_padstack_circle($pin->{'copper'}, $fp->{'unit'});
	}

	if ($type eq 'square') {
		write_padstack_rect($pin->{'copper'}, $fp->{'unit'});
	}

	if ($type =~ /long/) {
		write_padstack_long($pin->{'copper'}, $fp->{'unit'}, $type);
	}

	println("       ha:layer_mask {");
	println("        copper = 1");
	println("        $layer = 1");
	println("       }");
	println("      }");
}

sub write_padstack_prototypes
{
	my ($fp) = @_;
	my %pin_types;
	my @padstacks;
	my $proto = -1;

	for my $pin (@{$fp->{'pins'}}) {
		my $hash = "$pin->{'hole'}-$pin->{'copper'}-$pin->{'type'}";

		if (defined $pin_types{$hash}) {
			$pin->{'proto'} = $proto;
			next;
		}

		$pin_types{$hash} = 1;
		$pin->{'proto'} = ++$proto;
		push(@padstacks, $pin);
	}

	println("   li:padstack_prototypes {");

	for my $pin (@padstacks) {
		println("    ha:ps_proto_v4.$pin->{'proto'} {");
		println("     htop = 0");
		println("     hbottom = 0");
		println("     hplated = 1");
		println("     hdia = $pin->{'hole'}$fp->{'unit'}");
		println("     li:shape {");
		write_padstack_shape($fp, $pin, "top");
		write_padstack_shape($fp, $pin, "bottom");
		println("     }");
		println("    }");
	}

	println("   }");
}

sub write_padstacks
{
	my ($fp) = @_;
	my $cnt = 0;

	for my $pin (@{$fp->{'pins'}}) {
		println("    ha:padstack_ref.$cnt {");
		println("     ha:attributes {");
		println("      term = $pin->{'nr'}");
		println("      name = $pin->{'name'}");
		println("     }");
		println("     rot = 0");
		println("     proto = $pin->{'proto'}");
		println("     x = $pin->{'x'}$fp->{'unit'}");
		println("     y = $pin->{'y'}$fp->{'unit'}");
		println("    }");
		$cnt++;
	}
}

sub write_shape
{
	my ($fp, $s, $cnt) = @_;
	my $shape = $s->{'shape'};

	if ($shape eq 'line') {
		println("      ha:line.$cnt {");
		println("       clearance = 0");
                println("       x1 = $s->{'x1'}$fp->{'unit'}");
                println("       y1 = $s->{'y1'}$fp->{'unit'}");
                println("       x2 = $s->{'x2'}$fp->{'unit'}");
                println("       y2 = $s->{'y2'}$fp->{'unit'}");
		println("       thickness = 10mil");
		println("      }");
	}

	if ($shape eq 'arc') {
		println("      ha:arc.$cnt {");
		println("       clearance = 0");
                println("       x = $s->{'x'}$fp->{'unit'}");
                println("       y = $s->{'y'}$fp->{'unit'}");
                println("       width = $s->{'w'}$fp->{'unit'}");
                println("       height = $s->{'h'}$fp->{'unit'}");
                println("       astart = $s->{'start_angle'}");
                println("       adelta = $s->{'delta_angle'}");
		println("       thickness = 10mil");
		println("      }");
	}
}

sub write_top_silk
{
	my ($fp) = @_;
	my $cnt = 0;

	println("    ha:top-silk {");
	println("     lid = 0");
	println("     ha:type {");
	println("      silk = 1");
	println("      top = 1");
	println("     }");
	println("     li:objects {");

	for my $shape (@{$fp->{'top'}}) {
		write_shape($fp, $shape, $cnt++);
	}

	println("      ha:text.$cnt {");
	println("       scale = 100");
	println("       direction = 0");
	println("       string = %a.parent.refdes%");
	println("       x = 0");
	println("       y = 0");
	println("       fid = 0");
	println("       ha:flags {");
	println("        dyntext = 1");
	println("        floater = 1");
	println("       }");
	println("      }");

	println("     }");
	println("    }");
}

sub write_line
{
	my ($role, $id, $x1, $y1, $x2, $y2, $unit) = @_;

	println("      ha:line.$id {");
	println("       clearance = 0");
	println("       thickness = 0");
	println("       ha:attributes {");
	println("        subc-role = $role");
	println("       }");
	println("       x1 = $x1$unit");
	println("       y1 = $y1$unit");
	println("       x2 = $x2$unit");
	println("       y2 = $y2$unit");
	println("      }");
}

sub write_bbox
{
	my ($fp) = @_;
	my $cnt = 0;
	my $bbox = $fp->{'bbox'};

	println("    ha:subc-aux {");
	println("     lid = 1");
	println("     ha:type {");
	println("      top = 1");
	println("      misc = 1");
	println("      virtual = 1");
	println("     }");
	println("     li:objects {");

	write_line("origin", $cnt++, 0, 0, 0, 0, "mm");
	write_line("x", $cnt++, 0, 0, 1, 0, "mm");
	write_line("y", $cnt++, 0, 0, 0, 1, "mm");

	println("     }");
	println("    }");
}

sub gen_uuid
{
	my ($fp) = @_;

	my $md5 = md5_hex($fp->{'fname'});

	return substr($md5, 0, 24);
}

sub write_footprint
{
	my ($fp) = @_;

	println("li:pcb-rnd-subcircuit-v4 {");
	println(" ha:subc.0 {");
	println("  ha:attributes {");
	println("   description = $fp->{'desc'}");
	println("   dist-license = GPLv2");
	println("   use-license = Unlimited");
	println("   author = {$fp->{'author'}; Created by fpg-geda.}");
	println("   copyright = $fp->{'author'}");
	println("  }");
	println("  uid = " . gen_uuid($fp));
	println("  ha:data {");
	write_padstack_prototypes($fp);
	println("   li:objects {");
	write_padstacks($fp);
	println("   }");
	println("   li:layers {");
	write_top_silk($fp);
	write_bbox($fp);
	println("   }");
	println("  }");
	println(" }");
	println("}");
}

1;
