#!/usr/bin/perl
#
# Copyright (C) 2009-2016 Cyril Hrubis <metan@ucw.cz>
#
# fpg-geda code is distributed under GPLv2+
#
# See <http://www.gnu.org/licenses/> for more information
#

package fp;

use strict;
use warnings;

use fp_lihata;

sub println { print @_, "\n" }

sub w
{
	my $depth = 0;
	for (; caller $depth; $depth++) {1};
	my @caller = caller($depth - 1);

	print STDERR "$caller[1]: $caller[2]: ", @_, "\n";
}

sub round
{
	my ($f) = @_;

	return $f < 0 ? int($f - 0.5) : int($f + 0.5);
}

my $line_width = 1000;
sub width
{
	return $line_width;
}

sub set_line_width
{
	($line_width) = @_;
}

sub set_origin
{
	my ($fp, $x, $y) = @_;

	$fp->{'origin'}[0] = $x;
	$fp->{'origin'}[1] = $y;
}

sub add_origin
{
	my ($fp, $x, $y) = @_;

	$fp->{'origin'}[0] += $x;
	$fp->{'origin'}[1] += $y;
}

sub get_origin
{
	my ($fp) = @_;

	return @{$fp->{'origin'}};
}

sub pin
{
	my ($fp, $x, $y, $copper, $clearance, $mask, $hole, $name, $nr, $type) = @_;

	$type = $type || '';

	$x += $fp->{'origin'}->[0];
	$y += $fp->{'origin'}->[1];

	my $pin = {x => $x, y => $y, hole => $hole, copper => $copper,
		   clearance => $clearance, mask => $mask,
		   name => $name, nr => $nr, type => $type};

	push(@{$fp->{'pins'}}, $pin);
}

sub pin_s
{
	my ($fp, $x, $y, $hole, $copper, $name, $nr, $type) = @_;

	$type = $type || '';

	my $clearance = $copper * 1.1;
	my $mask = $copper;

	pin($fp, $x, $y, $copper, $clearance, $mask, $hole, $name, $nr, $type);
}

sub line
{
	my $x1 = 0;
	my $y1 = 0;

	my $fp = shift;

	if (@_ == 4 or @_ == 5) {
		$x1 = shift;
		$y1 = shift;
	}

	my ($x2, $y2, $w) = @_;

	$w = $w || width();

	$x1 += $fp->{'origin'}->[0];
	$y1 += $fp->{'origin'}->[1];
	$x2 += $fp->{'origin'}->[0];
	$y2 += $fp->{'origin'}->[1];

	my $line = {shape => "line", x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, thickness => $w};

	push(@{$fp->{'top'}}, $line);
}

sub hline
{
	my $x1 = 0;
	my $x2;
	my $y = 0;

	my $fp = shift;

	if (@_ == 3 or @_ == 4) {
		$x1 = shift;
		$x2 = shift;
		$y = shift;
	} else {
		$x2 = shift;
	}

	my ($w) = @_;

	line($fp, $x1, $y, $x2, $y, $w);
}

sub vline
{
	my $x = 0;
	my $y1 = 0;

	my $fp = shift;

	if (@_ == 3 or @_ == 4) {
		$x = shift;
		$y1 = shift;
	}

	my ($y2, $w) = @_;

	line($fp, $x, $y1, $x, $y2, $w);
}

sub vlineto
{
	my ($fp, $h) = @_;

	vline($fp, $h);
	add_origin($fp, 0, $h);
}

sub hlineto
{
	my ($fp, $w) = @_;

	hline($fp, $w);
	add_origin($fp, $w, 0);
}

sub arc
{
	my $x = 0;
	my $y = 0;
	my $w;
	my $h;

	my $fp = shift;

	if (@_ == 7 or @_ == 6) {
		$x = shift;
		$y = shift;
		$w = shift;
		$h = shift;
	} else {
		$w = shift;
		$h = shift;
	}

	my ($start_angle, $delta_angle, $s) = @_;

	$s = $s || width();

	$x += $fp->{'origin'}[0];
	$y += $fp->{'origin'}[1];

	$w = -$w if ($w < 0);
	$h = -$h if ($h < 0);

	my $arc = {shape => 'arc', x => $x, y => $y, w => $w, h => $h,
	           start_angle => $start_angle, delta_angle => $delta_angle,
	           thickness => $s};

	push(@{$fp->{'top'}}, $arc);
}

sub circle
{
	my $x = 0;
	my $y = 0;

	my $fp = shift;

	if (@_ == 3 or @_ == 4) {
		$x = shift;
		$y = shift;
	}

	my ($r, $s) = @_;

	arc($fp, $x, $y, $r, $r, 0, 360, $s);
}

sub shape
{
	my $fp = shift @_;
	my $x = shift @_;
	my $y = shift @_;
	my $w = width();

	for my $shape (@_) {
		if ($shape->[0] eq "HL") {
			line($fp, $x, $y, $x + $shape->[1], $y, $w);
			$x += $shape->[1];
		} elsif ($shape->[0] eq "VL") {
			line($fp, $x, $y, $x, $y + $shape->[1], $w);
			$y += $shape->[1];
		} elsif ($shape->[0] eq "L") {
			line($fp, $x, $y, $x + $shape->[1], $y + $shape->[2], $w);
			$x += $shape->[1];
			$y += $shape->[1];
		} elsif ($shape->[0] eq "HA") {
			arc($fp, $x + $shape->[2]/2, $y, $shape->[2]/2, $shape->[2]/2, 0, $shape->[1], $w);
			$x += $shape->[2];
		} else {
			w("Invalid shape '$shape->[0]'!");
		}
	}
}

sub rect
{
	my $x = 0;
	my $y = 0;

	my $fp = shift;

	if (@_ == 4 || @_ == 5) {
		$x = shift;
		$y = shift;
	}

	my ($w, $h) = @_;
	my $lw = width();

	hline($fp, $x, $x+$w, $y, $lw);
	vline($fp, $x, $y, $y+$h, $lw);
	vline($fp, $x+$w, $y, $y+$h, $lw);
	hline($fp, $x, $x+$w, $y+$h, $lw);
}

sub lineto
{
	my ($fp, $x, $y) = @_;

	line($fp, 0, 0, $x, $y);
	add_origin($fp, $x, $y);
}

sub min
{
	my ($a, $b) = @_;

	return $a if $a < $b;
	return $b;
}

sub max
{
	my ($a, $b) = @_;

	return $a if $a > $b;
	return $b;
}

sub merge_bboxes
{
	my ($b1, $b2) = @_;

	$b1->[0] = min($b1->[0], $b2->[0]);
	$b1->[1] = min($b1->[1], $b2->[1]);
	$b1->[2] = max($b1->[2], $b2->[2]);
	$b1->[3] = max($b1->[3], $b2->[3]);

	return $b1;
}

sub bbox
{
	my ($x1, $y1, $x2, $y2) = @_;

	return [min($x1, $x2), min($y1, $y2),
		max($x1, $x2), max($y1, $y2)];
}

sub shape_bbox
{
	my ($s) = @_;
	my $shape = $s->{'shape'};

	if ($shape eq 'arc') {
		my $x = $s->{'x'};
		my $y = $s->{'y'};
		#TODO thickness in mils!
		my $t = $s->{'thickness'};
		my $w = $s->{'w'} + $t;
		my $h = $s->{'h'} + $t;
		#TODO use the start and end angle
		return bbox($x - $w, $y - $h, $x + $w, $y + $w);
	}

	if ($shape eq 'line') {
		my $x1 = $s->{'x1'};
		my $y1 = $s->{'y1'};
		my $x2 = $s->{'x2'};
		my $y2 = $s->{'y2'};
		#TODO thickness in mils!
		my $t = $s->{'thickness'};
		return bbox($x1, $y1, $x2, $y2);
	}
}

sub pin_bbox
{
	my ($p) = @_;

	my $x = $p->{'x'};
	my $y = $p->{'y'};
	my $r = $p->{'copper'}/2;

	return bbox($x - $r, $y - $r, $x + $r, $y + $r);
}

sub fp_bbox
{
	my ($fp) = @_;
	my $bbox = [0, 0, 0, 0];

	for my $pin (@{$fp->{'pins'}}) {
		$bbox = merge_bboxes($bbox, pin_bbox($pin));
	}

	for my $shape (@{$fp->{'top'}}) {
		$bbox = merge_bboxes($bbox, shape_bbox($shape));
	}

	return $bbox;
}

sub move_shape
{
	my ($s, $x_inc, $y_inc) = @_;
	my $shape = $s->{'shape'};

	if ($shape eq 'arc') {
		$s->{'x'} += $x_inc;
		$s->{'y'} += $y_inc;
	}

	if ($shape eq 'line') {
		$s->{'x1'} += $x_inc;
		$s->{'y1'} += $y_inc;
		$s->{'x2'} += $x_inc;
		$s->{'y2'} += $y_inc;
	}
}

sub move_pin
{
	my ($p, $x_inc, $y_inc) = @_;

	$p->{'x'} += $x_inc;
	$p->{'y'} += $y_inc;
}

sub fp_move
{
	my ($fp, $x_inc, $y_inc) = @_;

	for my $pin (@{$fp->{'pins'}}) {
		move_pin($pin, $x_inc, $y_inc);
	}

	for my $shape (@{$fp->{'top'}}) {
		move_shape($shape, $x_inc, $y_inc);
	}
}

sub koch_render
{
	my ($fp, $x1, $y1, $x2, $y2, $iter) = @_;

	if ($iter == 0) {
		line($fp, $x1, $y1, $x2, $y2);
		return;
	}

	my $x = ($x1+$x2)/2 + sqrt(3)*($y2-$y1)/6;
        my $y = ($y1+$y2)/2 - sqrt(3)*($x2-$x1)/6;

	koch_render($fp, $x1, $y1, 2*$x1/3 + $x2/3, 2*$y1/3 + $y2/3, $iter-1);
	koch_render($fp, 2*$x1/3 + $x2/3, 2*$y1/3 + $y2/3, $x, $y, $iter-1);
	koch_render($fp, $x, $y, $x1/3 + 2*$x2/3, $y1/3 + 2*$y2/3, $iter-1);
	koch_render($fp, $x1/3 + 2*$x2/3, $y1/3 + 2*$y2/3, $x2, $y2, $iter-1);
}

sub koch
{
	my ($fp, $l, $iter) = @_;

	my $x = $l/2;
	my $y = $l/2 * sqrt(3);

	koch_render($fp, 0, 0, $l, 0, $iter);
	koch_render($fp, $l, 0, $x, $y, $iter);
	koch_render($fp, $x, $y, 0, 0, $iter);
}

sub resistor
{
	my ($fp, $x1, $y1, $x2, $y2) = @_;
	my $vx = $x2 - $x1;
	my $vy = $y2 - $y1;

	my @origin = get_origin($fp);

	lineto($fp, $vx/5, $vy/5);
	add_origin($fp, -$vy/10, $vx/10);

	my $x3 =  $vy/5;
	my $y3 = -$vx/5;
	my $x4 = 3*$vx/5;
	my $y4 = 3*$vy/5;

	line($fp, 0, 0, $x3, $y3);
	line($fp, 0, 0, $x4, $y4);

	my $x5 = $x3 + $x4;
	my $y5 = $y3 + $y4;;

	line($fp, $x3, $y3, $x5, $y5);
	line($fp, $x4, $y4, $x5, $y5);

	add_origin($fp, $x4 + $vy/10, $y4 - $vx/10);

	lineto($fp, $vx/5, $vy/5);

	set_origin($fp, @origin);
}

sub diode
{
	my ($fp, $x1, $y1, $x2, $y2, $type) = @_;
	my @origin = get_origin($fp);

	add_origin($fp, $x1, $y1);

	$x2 -= $x1;
	$y2 -= $y1;

	lineto($fp, $x2/3, $y2/3);
	line($fp, -$y2/6, $x2/6, $y2/6, -$x2/6);
	line($fp, -$y2/6, $x2/6, $x2/3, $y2/3);
	line($fp, $y2/6, -$x2/6, $x2/3, $y2/3);
	add_origin($fp, $x2/3, $y2/3);
	line($fp, -$y2/6, $x2/6, $y2/6, -$x2/6);
	lineto($fp, $x2/3, $y2/3);

	if ($type and $type eq "led") {
		set_origin($fp, @origin);
		add_origin($fp, $x1, $y1);
		add_origin($fp, $x2/2 + $y2/6, $y2/2 - $x2/6);
		line($fp, $x2/10 + $y2/10, $y2/10 - $x2/10);
		add_origin($fp, $x2/16, $y2/16);
		line($fp, $x2/10 + $y2/10, $y2/10 - $x2/10);
	}

	if ($type and $type eq "zener") {
		add_origin($fp, -$x2/3, -$y2/3);
		line($fp, $y2/6, -$x2/6, -3*$x2/24+$y2/6, -3*$y2/24-$x2/6);
	}

	if ($type and $type eq "schottky") {
		add_origin($fp, -$x2/3, -$y2/3);
		line($fp, $y2/6, -$x2/6,  $x2/12+$y2/6,  $y2/12-$x2/6);
		line($fp, -$y2/6, $x2/6, -$x2/12-$y2/6, -$y2/12+$x2/6);
	}

	set_origin($fp, @origin);
}

#
# Draws a + sign
# x1, y1 is center
# x2, y2 is right corner
#
sub plus
{
	my ($fp, $x1, $y1, $x2, $y2) = @_;

	my $vx = $x2 - $x1;
	my $vy = $y2 - $y1;

	line($fp, $x1 - $vx, $y1 - $vy, $x2, $y2);
	line($fp, $x1 - $vy, $y1 + $vx, $x1 + $vy, $y1 - $vx);
}

sub capacitor
{
	my ($fp, $x1, $y1, $x2, $y2, $type) = @_;
	my $vx = $x2 - $x1;
	my $vy = $y2 - $y1;
	my @origin = get_origin($fp);

	if ($type and $type eq "polarized") {
		my $x = $x1 - $vy/6 + $vx/6;
		my $y = $y1 - $vx/6 - $vy/6;
		plus($fp, $x, $y, $x + $vx/10, $y + $vy/10);
	}

	add_origin($fp, $x1, $y1);
	lineto($fp, 2*$vx/5, 2*$vy/5);
	line($fp, -$vy/3, $vx/3, $vy/3, -$vx/3);
	add_origin($fp, $vx/5, $vy/5);

	if (not $type) {
		line($fp, -$vy/3, $vx/3, $vy/3, -$vx/3);
	} elsif ($type eq "polarized") {
		line($fp, -$vy/3, $vx/3, $vy/3, -$vx/3);
	}

	lineto($fp, 2*$vx/5, 2*$vy/5);

	set_origin($fp, @origin);
}

sub coil
{
	my ($fp, $x1, $y1, $x2, $y2, $turns) = @_;
	my @origin = get_origin($fp);
	my $parts = $turns + 2;
	my $dx = ($x2 - $x1)/$parts;
	my $dy = ($y2 - $y1)/$parts;
	my $r = sqrt(($dx/2)**2 + ($dy/2)**2);
	my $alpha = 180 - 180 * atan2($dy, $dx)/3.1415;

	add_origin($fp, $x1, $y1);

	lineto($fp, $dx, $dy);
	add_origin($fp, $dx/2, $dy/2);

	for (my $i = 0; $i < $turns; $i++) {
		arc($fp, $r, $r, $alpha, 180);
		add_origin($fp, $dx, $dy);
	}

	add_origin($fp, -$dx/2, -$dy/2);
	lineto($fp, $dx, $dy);

	set_origin($fp, @origin);
}

sub dot
{
	my ($fp, $x, $y) = @_;

	circle($fp, $x, $y, width()/(2 * get_unit_mul($fp)));
}

sub get_unit_mul
{
	my ($fp) = @_;

	my $unit = $fp->{'unit'};

	if ($unit eq "mil") {
		return 1000.00;
	} elsif ($unit eq "mm") {
		return 3937.00787;
	} elsif ($unit eq "um") {
		return 3.93700787;
	}
}

sub set_unit
{
	my ($fp, $unit) = @_;

	if ($unit eq 'mil') {
		$fp->{'unit'} = 'mil';
	} elsif ($unit eq "mm") {
		$fp->{'unit'} = 'mm';
	} elsif ($unit eq "um") {
		$fp->{'unit'} = 'um';
	} else {
		w("Invalid unit $unit");
		return;
	}
}

sub begin
{
	my ($fname, $desc, $author) = @_;

	my %elem;

	$elem{'desc'} = $desc;
	$elem{'author'} = $author;
	$elem{'fname'} = $fname;
	$elem{'origin'} = [0, 0];

	$elem{'pins'} = [];
	$elem{'top'} = [];

	set_unit(\%elem, 'mil');

	return \%elem;
}

sub pcb_attribute
{
	my ($name, $value) = @_;

	println("\tAttribute(\"$name\" \"$value\")");
}

sub pcb_coord
{
	my ($pin, $k) = @_;

	return round($pin->{'unit_mul'} * $pin->{$k});
}

sub pcb_size
{
	my ($pin, $k) = @_;

	return abs(round($pin->{'unit_mul'} * $pin->{$k}));
}

sub pcb_pin_type
{
	my ($pin) = @_;
	my $type = $pin->{'type'};

	return "square" if ($type =~ /square/);

	return '';
}

sub pcb_top_shape
{
	my ($s) = @_;
	my $shape = $s->{'shape'};

	if ($shape eq 'arc') {
		println("\tElementArc[" .
		        pcb_coord($s, 'x') . " " .
			pcb_coord($s, 'y') . " " .
			pcb_size($s, 'w') . " " .
			pcb_size($s, 'h') .
			" $s->{'start_angle'} $s->{'delta_angle'} $s->{'thickness'}]");
	}

	if ($shape eq 'line') {
		println("\tElementLine[" .
			pcb_coord($s, 'x1') . " " .
			pcb_coord($s, 'y1') . " " .
			pcb_coord($s, 'x2') . " " .
			pcb_coord($s, 'y2') .
			" $s->{'thickness'}]");
	}
}

sub write_pcb_footprint
{
	my ($fp) = @_;
	my $unit_mul = get_unit_mul($fp);

	println("Element[\"\" \"$fp->{'desc'}\" \"\" \"\" 100000 100000 1000 1000 0 100 \"\"]");
	println("(");

	pcb_attribute("description", $fp->{'desc'});

	for my $pin (@{$fp->{'pins'}}) {

		$pin->{'unit_mul'} = $unit_mul;

		println("\tPin[" .
		        pcb_coord($pin, 'x') . " " .
		        pcb_coord($pin, 'y') . " " .
			pcb_size($pin, 'copper') . " " .
			pcb_size($pin, 'clearance') . " " .
			pcb_size($pin, 'mask') . " " .
			pcb_size($pin, 'hole') .
		        " \"$pin->{'name'}\" \"$pin->{'nr'}\" " .
			'"' . pcb_pin_type($pin) . '"]');
	}

	for my $shape (@{$fp->{'top'}}) {
		$shape->{'unit_mul'} = $unit_mul;
		pcb_top_shape($shape);
	}

	pcb_attribute("dist-license", "GPLv2");
	pcb_attribute("use-license", "Unlimited");
	pcb_attribute("author", "$fp->{'author'}; Created by fpg-geda.");
	pcb_attribute("copyright", $fp->{'author'});
	println(")");
}

sub end
{
	my ($fp) = @_;
	my $file;
	my $bbox = fp_bbox($fp);

	$fp->{'bbox'} = $bbox;

	print("Writing $fp->{'fname'}.fp...\n");

	open($file, ">$fp->{'fname'}.fp") or die;
	select($file);
	write_pcb_footprint($fp);
	select(STDOUT);
	close($file);

	my $x_inc = -$bbox->[0];
	my $y_inc = -$bbox->[1];

	printf("Moving $fp->{'fname'} by $x_inc,$y_inc\n");
	fp_move($fp, $x_inc, $y_inc);

	print("Writing $fp->{'fname'}.lht...\n");

	open($file, ">$fp->{'fname'}.lht") or die;
	select($file);
	fp_lihata::write_footprint($fp);
	select(STDOUT);
	close($file);
}

1;
