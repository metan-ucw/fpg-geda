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
 *    )          /  /             |  0.285-315in
 *  --          /  /              |
 * |            \  \              |    |
 * |             \  \             |
 * --------------/  /--------------    |
 *   == == == == \  \ == == == ==  - - -
 *
 */
void do_gen_dip(int8_t n)
{
	char buf[256];
	char name[256];
	uint8_t i;

	snprintf(buf, 256, "DIP %u", n);

	fpg_element_begin(buf);
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_mil);
	
	fpg_pin_default(0, 0, "Pin_1", "1", "square");

	for (i = 1; i < n; i++) {
		snprintf(name, 256, "Pin_%u", i+1);
		snprintf(buf, 256, "%u", i+1);
		fpg_pin_default(100*i, 0, name, buf, "");
	}
	
	for (i = 1; i <= n; i++) {
		snprintf(name, 256, "Pin_%u", n+i);
		snprintf(buf, 256, "%u", n+i);
		fpg_pin_default(100*(n-i), -300, name, buf, "");
	}
	
	fpg_add_origin(-100, -400);

	fpg_rectangle_origin(100*(n+1), 500);

	snprintf(buf, 256, "DIP %u.", n);
	FPG_METADATA_DEFAULT("Cyril Hrubis", buf);

	fpg_element_end();
}

void gen_dip(int8_t n, uint16_t thickness)
{
	char buf[256];
	char name[256];
	uint8_t d = 50;
	int i;

	snprintf(buf, 256, "DIP %u", 2*n);
	
	fpg_element_begin(buf);
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_mil);
	
	fpg_pin_default(0, 0, "Pin_1", "1", "square");

	for (i = 1; i < n; i++) {
		snprintf(name, 256, "Pin_%u", i+1);
		snprintf(buf, 256, "%u", i+1);
		fpg_pin_default(0, 100*i, name, buf, "");
	}

	for (i = 0; i < n; i++) {
		snprintf(name, 256, "Pin_%u", n+1+i);
		snprintf(buf, 256, "%u", n+1+i);
		fpg_pin_default(thickness, 100*(n-1-i), name, buf, "");
	}

	fpg_add_origin(-d, -d);

	fpg_hline_origin(d + thickness/3);
	fpg_vline_origin_add(2*d + 100*(n-1));
	fpg_hline_origin_add(2*d + thickness);
	fpg_vline_origin_add(-2*d - 100*(n-1));
	fpg_hline_origin(-d - thickness/3);
	fpg_add_origin(-d-thickness/2, 0);
	fpg_arc(0, 0, thickness/6, 0, 180); 

	snprintf(buf, 256, "DIP %u.", 2*n);
	FPG_METADATA_DEFAULT("Cyril Hrubis", buf);

	fpg_element_end();
}

int main(int argc, char *argv[])
{
	uint8_t n;

	fpg_set_file(stdout);

	if (argc != 2) {
		fprintf(stderr, "Takes number of pins in dip package as argument.\n");
		return 1;
	}
	
	n = atoi(argv[1]);

	if (n%2) {
		fprintf(stderr, "Takes only even numbers as parameter.\n");
		return 1;
	}

	gen_dip(n/2, 300);
	
	return 0;
}
