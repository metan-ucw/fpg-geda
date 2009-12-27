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
 *  Generate talema radial coil footprint.
 *
 *  ---     _._  - - -
 *  [ ]   /\ | /\    |
 *  ---   --( )--    a
 *  [ ]   \/ | \/    |
 * .---.    -|-  - - -
 * |   |     |
 * |-b-|     
 *
 * Footprint:
 *
 * +-------------+
 * |      o      |
 * |             |
 * |      o      |
 * +-------------+
 *
 */
void do_gen_coil(int32_t a, int32_t b)
{
	char buf[256];

	snprintf(buf, 256, "Talema radial coil %imm x %imm.", a, b);

	fpg_element_begin(buf);
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_simple(0,      0, 700, 2000, "Pin_1", "1", "");
	fpg_pin_simple(0, 1000*b, 700, 2000, "Pin_2", "2", "");

	fpg_coil(0, 0, 0, 1000*b, 3); 
	
	fpg_set_origin((-1000*(a+1))/2, -1000);
	fpg_rectangle_origin(1000*(a+2), 1000*(b+2));

	FPG_METADATA_DEFAULT("Cyril Hrubis", buf);
	fpg_element_end();
}

int main(int argc, char *argv[])
{
	uint32_t a, b;

	fpg_set_file(stdout);

	if (argc != 3) {
		fprintf(stderr, "Takes two arguments numbers a nad b.\n");
		return 1;
	}
	
	a = atoi(argv[1]);
	b = atoi(argv[2]);

	do_gen_coil(a, b);
	
	return 0;
}
