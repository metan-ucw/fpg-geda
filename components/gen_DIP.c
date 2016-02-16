/******************************************************************************
 * This file is part of pcb_utils.                                            *
 *                                                                            *
 * Pcb_utils is free software; you can redistribute it and/or modify          *
 * it under the terms of the GNU General Public License as published by       *
 * the Free Software Foundation; either version 2 of the License, or          *
 * (at your option) any later version.                                        *
 *                                                                            *
 * Pcb_utils is distributed in the hope that it will be useful,               *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of             *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              *
 * GNU General Public License for more details.                               *
 *                                                                            *
 * You should have received a copy of the GNU General Public License          *
 * along with pcb_utils; if not, write to the Free Software                   *
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA *
 *                                                                            *
 * Copyright (C) 2009 Cyril Hrubis                                            *
 *                                                                            *
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <getopt.h>
#include "fpg_common.h"

/*
 * Dual in line package.
 *
 *
 *   == == == == \  \ == == == ==  - - -
 * --------------/  /--------------    |
 * |            /  /              |
 * |            \  \              |    |
 *  --           \  \             |
 *    )          /  /             |  0.3 in or 0.6 for wide package
 *  --          /  /              |
 * |            \  \              |    |
 * |             \  \             |
 * --------------/  /--------------    |
 *   == == == == \  \ == == == ==  - - -
 *   |  |
 *    0.1 in
 */
void do_gen_dip(int8_t n, uint16_t thickness)
{
	char buf[256];
	char name[256];
	char desc[256];
	uint8_t d = 50;
	int i;

	snprintf(desc, 256, "DIP %u (%u mils wide)", 2*n, thickness);

	fpg_element_begin(desc);
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_mil);

	fpg_pin_simple(0, 0, 25, 80, "Pin_1", "1", "square");

	for (i = 1; i < n; i++) {
		snprintf(name, 256, "Pin_%u", i+1);
		snprintf(buf, 256, "%u", i+1);
		fpg_pin_simple(0, 100*i, 25, 80, name, buf, "");
	}

	for (i = 0; i < n; i++) {
		snprintf(name, 256, "Pin_%u", n+1+i);
		snprintf(buf, 256, "%u", n+1+i);
		fpg_pin_simple(thickness, 100*(n-1-i), 25, 80, name, buf, "");
	}

	fpg_add_origin(-d, -d);

	fpg_hline_origin(d + thickness/3);
	fpg_vline_origin_add(2*d + 100*(n-1));
	fpg_hline_origin_add(2*d + thickness);
	fpg_vline_origin_add(-2*d - 100*(n-1));
	fpg_hline_origin(-d - thickness/3);
	fpg_add_origin(-d-thickness/2, 0);
	fpg_arc(0, 0, thickness/6, 0, 180); 

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);

	fpg_element_end();
}

static void print_help(void)
{
	fprintf(stderr, "./get_DIP -n x [-w]\n");
	fprintf(stderr, "-n odd number of pins; eg: 14\n");
	fprintf(stderr, "-w wide package (0.6 in, default is 0.3)\n");
}

int main(int argc, char *argv[])
{
	uint8_t n = 0;
	uint16_t size = 300;
	int opt;

	fpg_set_file(stdout);

	while ((opt = getopt(argc, argv, "n:w")) != -1) {
		switch (opt) {
			case 'n':
				n = atoi(optarg); 
			break;
			case 'w':
				size = 600;
			break;
			default:
				print_help();
				return 1;
		}
	}

	if (n == 0) {
		print_help();
		return 1;
	}

	if (n%2) {
		fprintf(stderr, "Takes only even numbers as parameter.\n");
		return 1;
	}

	do_gen_dip(n/2, size);

	return 0;
}
