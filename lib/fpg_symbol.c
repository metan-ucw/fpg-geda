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
#include "fpg_symbol.h"
#include "fpg_primitives.h"

/*
 * Draws arrow betwen two points.
 */
void fpg_arrow(int32_t x1, int32_t y1, int32_t x2, int32_t y2)
{
	int32_t ox, oy;
	int32_t vx = x2 - x1;
	int32_t vy = y2 - y1;

	/* save origin */
	fpg_get_origin_back(&ox, &oy);
	
	fpg_line(x1, y1, x2, y2);
	fpg_add_origin(x2, y2);
	fpg_line_origin((vy-vx)/8, (-vy-vx)/8);
	fpg_line_origin((-vx-vy)/8, (vx-vy)/8);
	
	/* recall origin */
	fpg_set_origin_back(ox, oy);
}

void fpg_arrow_origin(int32_t x, int32_t y)
{
	fpg_arrow(0, 0, x, y);
}

/*
 * Draws plus '+' sing.
 */
void fpg_plus(int32_t x1, int32_t y1, int32_t x2, int32_t y2)
{
	int32_t vx = x2 - x1;
	int32_t vy = y2 - y1;

	fpg_line(x1 - vx, y1 - vy, x2, y2);
	fpg_line(x1 - vy, y1 + vx, x1 + vy, y1 - vx);
}

void fpg_plus_origin(int32_t x, int32_t y)
{
	fpg_plus(0, 0, x, y);
}

static void koch_render(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t iter)
{
	int32_t x, y;

	if (iter == 0) {
		fpg_line(x1, y1, x2, y2);
		return;
	}
	
	x = (x1+x2)/2 + sqrt(3)*(y2-y1)/6;
	y = (y1+y2)/2 - sqrt(3)*(x2-x1)/6;

	koch_render(x1, y1, 2*x1/3 + x2/3, 2*y1/3 + y2/3, iter-1);
	koch_render(2*x1/3 + x2/3, 2*y1/3 + y2/3, x, y, iter-1);
	koch_render(x, y, x1/3 + 2*x2/3, y1/3 + 2*y2/3, iter-1);
	koch_render(x1/3 + 2*x2/3,y1/3+ 2*y2/3, x2, y2, iter-1);
}

void fpg_koch_origin(int32_t l, uint8_t iter)
{
	uint32_t x = l / 2;
	uint32_t y = 1.00 * l/2 * sqrt(3);

	koch_render(0, 0, l, 0, iter);
	koch_render(l, 0, x, y, iter);
	koch_render(x, y, 0, 0, iter);
}
