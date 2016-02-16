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

#include "fpg_primitives.h"
#include "fpg_symbol_resistor.h"

/*
 * Draws resistor betwen two points.
 */
void fpg_resistor(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t type)
{
	int32_t vx = x2 - x1;
	int32_t vy = y2 - y1;
	int32_t ox, oy;

	/* save origin */
	fpg_get_origin_back(&ox, &oy);

	fpg_add_origin(x1, y1);
	fpg_line_origin_add(vx/5, vy/5);

	if (type == FPG_RESISTOR_EU) {
		fpg_add_origin(-vy/10, vx/10);
		fpg_parallelogram_origin(vy/5, -vx/5, 3*vx/5, 3*vy/5);
		fpg_add_origin(3*vx/5 + vy/10, 3*vy/5 - vx/10);
	} else {
		fpg_line_origin_add(-vy/10 + vx/20,  vx/10 + vy/20);
		fpg_line_origin_add(vy/5   + vx/10, -vx/5  + vy/10);
		fpg_line_origin_add(-vy/5  + vx/10,  vx/5  + vy/10);
		fpg_line_origin_add(vy/5   + vx/10, -vx/5  + vy/10);
		fpg_line_origin_add(-vy/5  + vx/10,  vx/5  + vy/10);
		fpg_line_origin_add(vy/5   + vx/10, -vx/5  + vy/10);
		fpg_line_origin_add(-vy/10 + vx/20,  vx/10 + vy/20);
	}

	fpg_line_origin_add(vx/5, vy/5);

	/* recall origin */
	fpg_set_origin_back(ox, oy);
}
