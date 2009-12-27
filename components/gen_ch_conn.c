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
 * Generates footprint for CH 3.96 connector.
 *
 * (PSHXX-WG in http://www.gme.cz)
 *
 *            1.4mm
 *            || 
 *     _ _ _    _ _ _ _ _
 *   |     \\ ()         |
 *   |     // ||         |
 *   |     || ||         8.7mm
 * 12.5mm  || ||         |
 *   |     |\------. - - 3.3mm
 *   | _ _ \__--___| _ _ _
 *            ||          3.3mm
 *            \\_____     |
 *             ------` ` `
 *
 *     3.96mm       1.98mm
 *     `    `       ` `
 *     `    `       ` `
 *    ()   ()      () `
 *    ||   ||      || `
 *    ||   ||      || `
 *    ||   ||      || `
 *  .----------/ /----.
 *  |          \ \    |
 *  `----------/ /----`
 *    []   []      []
 */
void do_gen_conn(uint8_t n)
{
	char buf[256];
	int i;

	snprintf(buf, 256, "Connector 3.96 90st %i", n);

	//fpg_element_begin("", buf, "", "", 10000, 10000, 2500, 1000);
	fpg_element_begin(buf);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	/* draw rectangle around whole connector */
	fpg_rectangle_origin(n*3960, 17500);
	
	fpg_hline(0, 9700, n*3960);
	fpg_hline(0, 12000, n*3960);
	
	fpg_set_origin(1980, 15900);

	fpg_pin_big(0, 0, "Pin_1", "1", "square");
	
	for (i = 1; i < n; i++) {
		char name[128], pin[16];

		snprintf(name, 128, "Pin_%i", i+1);
		snprintf(pin, 16, "%i", i+1);
		fpg_pin_big(i * 3960, 0, name, pin, "");
	}

	FPG_METADATA_DEFAULT("Cyril Hrubis", buf);
	fpg_element_end();
}

int main(int argc, char *argv[])
{
	uint8_t n;

	fpg_set_file(stdout);

	if (argc != 2) {
		fprintf(stderr, "Takes exactly one argument; number of pins.\n");
		return 1;
	}
	
	n = atoi(argv[1]);

	do_gen_conn(n);
	
	return 0;
}
