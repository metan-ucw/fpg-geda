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
 *  Generate jamicon large can type.
 *
 *  |-  Dmm  -|
 *
 *   ---------
 *  | | |     |
 *  | |v|     |
 *  | | |     |
 *  | | |     |
 *  | |v|     |
 *  | | |     |
 *   ---------
 *  ===========
 *     |   |
 *     |   |
 *       
 *     |Pmm|
 *  
 */
void gen_large_cap(uint32_t D, uint32_t P)
{
	char buf[256];

	snprintf(buf, 256, "Radial large can %imm", D);

	//fpg_element_begin("", buf, "", "", 1000000, 1000000, 2500, 1000);
	fpg_element_begin(buf);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_big(0, 0, "Pin_1", "1", "square");
	fpg_pin_big(1000*P, 0, "Pin_2", "2", "");

	/* draw capacitor symbol */
        fpg_cap(0, 0, P, 0, FPG_CAP_POL_A | FPG_CAP_PLUS);

	fpg_set_origin(1000*P/2, 0);

	/* draw circle around */
	fpg_circle_origin(1000*D/2);

	FPG_METADATA_DEFAULT("Cyril Hrubis", buf);
	fpg_element_end();
}

int main(int argc, char *argv[])
{
	uint32_t D, P;

	fpg_set_file(stdout);

	if (argc != 3) {
		fprintf(stderr, "Takes two arguments numbers D nad P.\n");
		return 1;
	}
	
	D = atoi(argv[1]);
	P = atoi(argv[2]);

	gen_large_cap(D, P);
	
	return 0;
}
