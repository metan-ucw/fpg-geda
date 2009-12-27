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
#include "fpg_symbol.h"
#include "fpg_symbol_diode.h"

/*
 * Draws diode betwen two points.
 */
void fpg_diode(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t type)
{
	int32_t ox, oy;

	/* save origin */
	fpg_get_origin_back(&ox, &oy);

	fpg_add_origin(x1, y1);

	fpg_line_origin_add(x2/3, y2/3);
	fpg_line(-y2/6, x2/6, y2/6, -x2/6);
	fpg_line(-y2/6, x2/6, x2/3, y2/3);
	fpg_line(y2/6, -x2/6, x2/3, y2/3);
	fpg_add_origin(x2/3, y2/3);
	fpg_line(-y2/6, x2/6, y2/6, -x2/6);
	fpg_line_origin(x2/3, y2/3);

	switch (type) {
		case FPG_DIODE_GEN:
		break;
		case FPG_DIODE_LED:
			fpg_set_origin_back(ox, oy);
			fpg_add_origin(x1, y1);
			fpg_add_origin(x2/2 + y2/6, y2/2 - x2/6);
			fpg_arrow_origin(x2/10 + y2/10, y2/10 - x2/10);
			fpg_add_origin(x2/16, y2/16);
			fpg_arrow_origin(x2/10 + y2/10, y2/10 - x2/10);
		break;
	}

	/* recall origin */
	fpg_set_origin_back(ox, oy);
}
