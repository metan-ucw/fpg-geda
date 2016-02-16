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
#include "fpg_symbol_coil.h"
#include "fpg_primitives.h"

/*
 * Draws coil betwen two points.
 */
void fpg_coil(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t coils)
{
	int32_t ox, oy, i;
	int32_t vx = x2 - x1;
	int32_t vy = y2 - y1;
	uint8_t parts = coils + 2;
	int32_t r = sqrt((vx/(2*parts))*(vx/(2*parts))+(vy/(2*parts))*(vy/(2*parts)));
	int16_t alpha = 180 - 180*atan(1.00*vy/vx)/3.1415;

	/* save origin */
	fpg_get_origin_back(&ox, &oy);

	fpg_add_origin(x1, y1);

	fpg_line_origin_add(vx/parts, vy/parts);
	fpg_add_origin(vx/(2*parts), vy/(2*parts));

	for (i = 0; i < coils; i++) {
		fpg_arc_origin(r, alpha, 180); 
		fpg_add_origin(vx/parts, vy/parts);
	}

	fpg_add_origin(-vx/(2*parts), -vy/(2*parts));
	fpg_line_origin(vx/parts, vy/parts);

	/* load origin */
	fpg_set_origin_back(ox, oy);
}
