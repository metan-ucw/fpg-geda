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
 * Generates wob package. Usually used for bridge recfilters.
 *
 * There are some gEDA symbols for recfilter bridges, they hawe pins 1 and 2
 * for AC and 3 and 4 for DC, however plus and minus is not allways the same. 
 *
 *          |- - 9.3 mm - -|
 *
 *          +--------------+  -
 *          |              |  |
 *          |              |  5.6 mm
 *          |              |
 *          |              |  |
 *          +--------------+  -
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |  |    |  |
 *            |
 *            |
 *
 *                    /
 *
 *                  /      4.6 - 5.6 mm
 *              ---------     
 *            /    (~)    \      /
 *          /               \
 *         |                 | /
 *        |                   |
 *        | (+)           (-) |
 *        |                   |
 *         |                 |
 *          \               /
 *            \    (~)    /
 *              ---------
 *
 */
static void gen_wob(void)
{
	fpg_element_begin("WOB bridge recfilter");
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_circle_origin(4600);

	fpg_pin_default(-3600,     0, "Plus",  "1", "square");
	fpg_pin_default(    0,  3600, "AC",    "2", "");
	fpg_pin_default( 3600,     0, "Minus", "3", "");
	fpg_pin_default(    0, -3600, "AC",    "4", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", "WOB bridge recfilter");
	fpg_element_end();
}

int main(int argc, char *argv[] __attribute__ ((unused)))
{
	fpg_set_file(stdout);

	if (argc != 1) {
		fprintf(stderr, "Doesn't take any arguments.\n");
		return 1;
	}
	
	gen_wob();

	return 0;
}
