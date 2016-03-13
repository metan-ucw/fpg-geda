#!/usr/bin/perl

package sym;

use strict;
use warnings;

sub println { print @_, "\n" }

sub w
{
	my $depth = 0;
	for (; caller $depth; $depth++) {1};
	my @caller = caller($depth - 1);

	print STDERR "$caller[1]: $caller[2]: ", @_, "\n";
}

sub check_ctx
{
	my (%ctx) = @_;
	my %keys = ("line_size" => 1, "cap_style" => 1, "dash_style" => 1,
	            "dash_length" => 1, "dash_space" => 1, "color" => 1,
		    "origin" => 1, "fill" => 1, "size" => 1);

	for (keys %ctx) {
		if (! $keys{$_}) {
			w("Unexpected value '$_' in context");
		}
	}
}

sub check_int
{
	for (@_) {
		if (!(/^-?\d+$/)) {
			w("Expected integer not '$_'");
		}
	}
}

sub line_size
{
	my (%ctx) = @_;
	my $size = $ctx{'line_size'};

	return $size if defined $size;

	return 10;
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

sub text_size
{
	my (%ctx) = @_;

	return $ctx{'size'} || 10;
}

#
# Public interface
#

sub round_to_grid
{
	my ($num, $mul) = @_;

	return int(($num + $mul - 1)/$mul)*$mul;
}

sub circle
{
	my ($x, $y, $radius, %ctx) = @_;

	check_ctx(%ctx);
	check_int(($x, $y, $radius));

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

	check_ctx(%ctx);
	check_int(($x, $y, $w, $h));

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

	check_ctx(%ctx);
	check_int(($x1, $y1, $x2, $y2));

	println("L $x1 $y1 $x2 $y2 3 "
		. line_size(%ctx) . " "
		. cap_style(%ctx) . " "
		. dash_style(%ctx) . " "
		. dash_length(%ctx) . " "
		. dash_space(%ctx));
}

sub hline
{
	my ($x1, $x2, $y, %ctx) = @_;

	line($x1, $y, $x2, $y, %ctx);
}

sub vline
{
	my ($x, $y1, $y2, %ctx) = @_;

	line($x, $y1, $x, $y2, %ctx);
}

sub text
{
	my ($x, $y, $visible, $name_value, $text, %ctx) = @_;

	check_ctx(%ctx);
	check_int(($x, $y));

	println("T $x $y "
		. text_color(%ctx) . " "
		. text_size(%ctx) .
		" $visible $name_value 0 "
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

	check_ctx(%ctx);
	check_int(($x, $y));

	text($x, $y, $visible, $name_value, $name . $pin[0], %ctx);
}

sub pin
{
	my ($x1, $y1, $x2, $y2, $pintype, $pinlabel, $pinnumber, $pinseq) = @_;

	check_int(($x1, $y1, $x2, $y2));

	println("P $x1 $y1 $x2 $y2 1 0 0");
	println("{");
	pin_text($x1, $y1, "pintype=", @$pintype);
	pin_text($x1, $y1, "pinlabel=", @$pinlabel);
	pin_text($x1, $y1, "pinnumber=", @$pinnumber);
	pin_text($x1, $y1, "pinseq=", @$pinseq);
	println("}");
}

sub path
{
	my @output;

	while (1) {
		my $type = shift @_;

		if ($type =~ /(z|Z)/) {
			push(@output, "$type");
			last;
		}

		if ($type =~ /(m|M|l|L)/) {
			my $coords = shift @_;

			for (my $i = 0; $i < @$coords; $i+=2) {
				push(@output, "$type $coords->[$i],$coords->[$i+1]");
			}
		}
	}

	my (%ctx) = @_;
	my $lines = @output;

	println("H 3 "
		. line_size(%ctx) . " "
		. cap_style(%ctx) . " "
		. dash_style(%ctx) . " "
		. dash_length(%ctx) . " "
		. dash_space(%ctx) . " "
		. fill(%ctx) .
		" -1 -1 -1 -1 -1 $lines");

	for (@output) {
		println($_);
	}
}

sub header
{
	println("v 20130925 2");
}

1;
