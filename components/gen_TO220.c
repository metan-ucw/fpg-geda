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
 * Generates TO220_5 footprint.
 *
 * SIZES has been taken from LM2576 datasheet.
 *
 * |- - 10mm - - - -|
 *
 *   ______________
 *  /              \
 * |      /  \      |
 * |      \__/      |
 * |                |
 * |----------------|
 * |----------------|
 * |                |
 * |                |
 * |                |
 * | ()             |
 * |                |
 *  ----------------
 *   [] [] [] [] []
 *   [] [] [] [] [] |
 *   [] [] [] [] []
 *   [] [] [] [] [] |
 *   || || || || ||
 *   || || || || || |
 *   || || || || ||
 *   || || || || || |
 *   || || || || ||
 *          `  `  ` 1.6mm
 *          `  `
 *   ||      1.9mm
 *   0.8mm
 *
 * - - - - - -   ______________
 * |            /              |________________
 * 4.6mm       /               |---------------- ` `
 * |  --------|                |                    2.6mm
 * -  -------------------------- - - - - - - - - - -
 *
 */
static void gen_TO220_5(void)
{
	//fpg_element_begin("", "TO220 5 pin", "", "", 10000, 10000, 2500, 1000);
	fpg_element_begin("TO220 5 pin");

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_rectangle_origin(10000, 4600);

	fpg_set_origin(1600, 2600);

	fpg_pin(0     , 0, 1400, 1700, 2000, 800, "Pin_1", "1", "square");
	fpg_pin(1700  , 0, 1400, 1700, 2000, 800, "Pin_2", "2", "");
	fpg_pin(2*1700, 0, 1400, 1700, 2000, 800, "Pin_3", "3", "");
	fpg_pin(3*1700, 0, 1400, 1700, 2000, 800, "Pin_4", "4", "");
	fpg_pin(4*1700, 0, 1400, 1700, 2000, 800, "Pin_5", "5", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", "TO220 5 pin package.");
	fpg_element_end();
}

static void gen_TO220(void)
{
	printf("TODO\n");
}

static char *TO220s[] = {
	"TO220",
	"TO220_5",
	"TO220_lay",
	"TO220_5_lay",
	NULL
};

static char *TO220_desc[] = {
	"TO220.",
	"TO220 with five pins.",
	"TO220 laying.",
	"TO220 with five pins laying."
};

static void (*gen_TO220s[])(void) = {
	gen_TO220,
	gen_TO220_5,
	gen_TO220,
	gen_TO220,
};

#define MAX_NAME 13

static void print_TO220s(void)
{
	int i, j;

	for (i = 0; TO220s[i] != NULL; i++) {
		fprintf(stderr, "%s", TO220s[i]);
		for (j = strlen(TO220s[i]); j < MAX_NAME; j++)
			fprintf(stderr, " ");

		fprintf(stderr, "-- %s\n", TO220_desc[i]);
	}
}

static void dump_TO220s(void)
{
	int i;

	for (i = 0; TO220s[i] != NULL; i++)
		printf("%s ", TO220s[i]);
	printf("\n");
}

int main(int argc, char *argv[])
{
	int i;

	if (argc != 2) {
		fprintf(stderr, "Takes -d or variant of TO220 package, that's one of following:\n");
		print_TO220s();
		return 1;
	}

	fpg_set_file(stdout);

	if (!strcmp(argv[1], "-d")) {
		dump_TO220s();
		return 0;
	}

	for(i = 0; TO220s[i] != NULL; i++)
		if (!strcmp(argv[1], TO220s[i])) {
			gen_TO220s[i]();
			return 0;
		}

	fprintf(stderr, "Invalid TO220 package selected!\n");
	return 1;
}
