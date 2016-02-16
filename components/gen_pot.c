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
#include <string.h>
#include "fpg_common.h"

/*
 * TP160A tesla potentiometer, should also work for TP160P (plastic body)
 *
 *
 *
 * >  16 mm  <   > 10.5 <
 *  |       |     |    |
 *   .-^^^-.       ----
 *  /   _   \     |    |-   - - -
 *  |  ( )  |     |    ||XX==== 7 mm
 *  \       /     |    |-   - - -
 *  | o o o |      --- |
 *   -/-|-\-          ||
 *    X X X           ||
 *    | | |            |
 *   > <
 *    1 mm
 *
 *   > - - <
 *     10 mm
 *
 *
 */
void do_gen_TP160A(void)
{
	const char *desc = "Tesla potentiometr TP160A";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(    0, 0, 1400, 3000, "Pin_1", "1", "");
	fpg_pin_simple( 5000, 0, 1400, 3000, "Pin_2", "2", "");
	fpg_pin_simple(10000, 0, 1400, 3000, "Pin_3", "3", "");

	fpg_add_origin(-3000, -8800);
	fpg_rectangle_origin(16000, 10500);


	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

const char *pot_type[] = {
	"TP160A",
	NULL
};

const char *pot_desc[] = {
	"Tesla potentiometr TP160A",
};

void (*pot_gen[])(void) = {
	do_gen_TP160A,
};

int main(int argc, char *argv[])
{
	int type;

	fpg_set_file(stdout);

	if (argc != 2) {
		fprintf(stderr, "Takes one argument, either pot type or -d\n");
		return 1;
	}

	if (!strcmp(argv[1], "-d")) {
		fpg_utils_print(pot_type);
		return 0;
	}

	type = fpg_utils_find_type(pot_type, argv[1]);

	if (type == -1) {
		fprintf(stderr, "Invalid pot type.\n");
		fpg_utils_print_help(pot_type, pot_desc);
		return -1;
	}

	pot_gen[type]();

	return 0;
}
