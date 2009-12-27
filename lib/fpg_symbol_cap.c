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

#include <math.h>
#include "fpg_symbol_cap.h"
#include "fpg_symbol.h"
#include "fpg_primitives.h"

/*
 * Draws capacitor.
 */
void fpg_cap(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t type)
{
	int32_t ox, oy;
	int32_t vx = x2 - x1;
	int32_t vy = y2 - y1;
	int32_t r, alpha;

	/* save origin */
	fpg_get_origin_back(&ox, &oy);

	fpg_add_origin(x1, y1);
	fpg_line_origin_add(2*vx/5, 2*vy/5);
	fpg_line(-vy/3, vx/3, vy/3, -vx/3);

	fpg_add_origin(vx/5, vy/5);

	if (type & FPG_CAP_PLUS) {
		int oox, ooy;
		
		type &= ~FPG_CAP_PLUS;

		fpg_get_origin_back(&oox, &ooy);
		fpg_set_origin_back(ox, oy);

		fpg_add_origin(x2 + vy/6 - vx/6, y2 - vx/6 - vy/6);
	
		fpg_plus_origin(vx/10, vy/10);

		fpg_set_origin_back(oox, ooy);
	}

	switch (type) {
		case FPG_CAP_GEN:
			fpg_line(-vy/3, vx/3, vy/3, -vx/3);
		break;

		case FPG_CAP_POL_A:
			fpg_tetragon(-vy/3, vx/3, vy/3, -vx/3, vy/3-vx/10, -vx/3-vy/10, -vy/3-vx/10, vx/3-vy/10); 
		break;

		case FPG_CAP_POL_B:
			r     = sqrt((vx/3)*(vx/3) + (vy/3)*(vy/3));
			alpha = 180+180*atan(1.00*vx/vy)/3.1415; 
			fpg_add_origin(vx/3, vy/3);
			fpg_arc_origin(r, alpha + 20, 140);
			fpg_add_origin(-vx/3, -vy/3);
		break;

		case FPG_CAP_VAR:
			fpg_line(-vy/3, vx/3, vy/3, -vx/3);
			fpg_add_origin(-vx/10, -vy/10);
			fpg_arrow((vy-vx)/3, (vx+vy)/3, (vx-vy)/3, -(vx+vy)/3);
			//fpg_arrow_origin(vx/10, vy/10);
			fpg_add_origin(vx/10, vy/10);
		break;
	}

	fpg_line_origin(2*vx/5, 2*vy/5);

	/* load origin */
	fpg_set_origin_back(ox, oy);
}
