#!/usr/bin/perl

package sym;

use strict;
use warnings;

sub println { print @_, "\n" }

sub line_size
{
	my (%ctx) = @_;

	return $ctx{'line_size'} || 10;
}

sub cap_style
{
	my (%ctx) = @_;
	my %cap = ('square' => 1, 'round' => 2);

	if ($ctx{'cap_style'}) {
		return $cap{$ctx{'cap_style'}};
	}

	return 0;
}

sub dash_style
{
	my (%ctx) = @_;
	my %dash = ('dotted' => 1, 'dashed' => 2,
	            'center' => 3, 'phantom' => 4);

	if ($ctx{'dash_style'}) {
		return $dash{$ctx{'dash_style'}};
	}

	return 0;
}

sub dash_length
{
	my (%ctx) = @_;

	return $ctx{'dash_length'} || -1;
}

sub dash_space
{
	my (%ctx) = @_;

	return $ctx{'dash_space'} || -1;
}

sub fill
{
	my (%ctx) = @_;

	return $ctx{'fill'} || 0;
}

sub text_origin
{
	my (%ctx) = @_;
	my %origin_hash = (
		"bl" => 0,
		"ml" => 1,
		"ul" => 2,
		"bc" => 3,
		"mc" => 4,
		"uc" => 5,
		"br" => 6,
		"mr" => 7,
		"ur" => 8,
	);

	if ($ctx{'origin'}) {
		return $origin_hash{$ctx{'origin'}};
	}

	return 0;
}

sub text_color
{
	my (%ctx) = @_;

	return $ctx{'color'} || 8;
}

sub circle
{
	my ($x, $y, $radius, %ctx) = @_;

	println("V $x $y $radius 3 "
		. line_size(%ctx) .
		" 0 0 -1 -1 "
		. fill(%ctx) .
		" -1 -1 -1 -1 -1");
}

# wire connection dot
sub dot
{
	my ($x, $y) = @_;

	sym::circle($x, $y, 25, ("fill" => 1));
}

sub box
{
	my ($x, $y, $w, $h, %ctx) = @_;

	println("B $x $y $w $h 3 "
		. line_size(%ctx) . " "
		. cap_style(%ctx) .
		" 0 -1 -1 "
		. fill(%ctx) .
		" -1 -1 -1 -1 -1");
}

sub line
{
	my ($x1, $y1, $x2, $y2, %ctx) = @_;

	println("L $x1 $y1 $x2 $y2 3 "
		. line_size(%ctx) . " "
		. cap_style(%ctx) . " "
		. dash_style(%ctx) . " "
		. dash_length(%ctx) . " "
		. dash_space(%ctx));
}

sub text
{
	my ($x, $y, $visible, $name_value, $text, %ctx) = @_;

	println("T $x $y "
		. text_color(%ctx) .
		" 10 $visible $name_value 0 "
		. text_origin(%ctx) . " 1");
	println("$text");
}

sub pin_text
{
	my ($dx, $dy, $name, @pin) = @_;

	my $x = $pin[1] || $dx;
	my $y = $pin[2] || $dy;
	my $visible = $pin[3] || 0;
	my $name_value = $pin[4] || 0;
	my %ctx = ();

	if (defined $pin[5]) {
		%ctx = %{$pin[5]};
	}

	$ctx{"color"} = 5;

	text($x, $y, $visible, $name_value, $name . $pin[0], %ctx);
}

sub pin
{
	my ($x1, $y1, $x2, $y2, $pintype, $pinlabel, $pinnumber, $pinseq) = @_;

	println("P $x1 $y1 $x2 $y2 1 0 0");
	println("{");
	pin_text($x1, $y1, "pintype=", @$pintype);
	pin_text($x1, $y1, "pinlabel=", @$pinlabel);
	pin_text($x1, $y1, "pinnumber=", @$pinnumber);
	pin_text($x1, $y1, "pinseq=", @$pinseq);
	println("}");
}

sub header
{
	println("v 20130925 2");
}

1;
