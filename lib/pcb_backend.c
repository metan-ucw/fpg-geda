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

#include "pcb_backend.h"

/*
 * Line.
 */
void pcb_line(FILE *file, int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t thickness)
{
        fprintf(file, "\tElementLine[%i %i %i %i %i]\n", x1, y1, x2, y2, thickness);
}

/*
 * Arc.
 */
void pcb_arc(FILE *file, int32_t x, int32_t y, int32_t w, int32_t h, uint16_t start_angle, uint16_t delta_angle, int32_t thickness)
{
        fprintf(file, "\tElementArc[%i %i %i %i %i %i %i]\n", x, y, w, h, start_angle, delta_angle, thickness);
}

/*
 * Pin.
 */
void pcb_pin(FILE *file, int32_t x, int32_t y, uint16_t thickness, uint16_t clearance, uint16_t mask, uint16_t drill, const char *name, const char *number, const char *sflags)
{
	fprintf(file, "\tPin[%i %i %i %i %i %i \"%s\" \"%s\" \"%s\"]\n", x, y, thickness, clearance, mask, drill, name, number, sflags);
}

/*
 * Pad.
 */
void pcb_pad(FILE *file, int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint16_t thickness, uint16_t clearance, uint16_t mask, const char *name, const char *number, const char *sflags)
{
	fprintf(file, "\tPad[%i %i %i %i %u %u %u \"%s\" \"%s\" \"%s\"]\n", x1, y1, x2, y2, thickness, clearance, mask, name, number, sflags);
}

/*
 * Set attribute.
 */
void pcb_attribute(FILE *file, const char *name, const char *value)
{
	fprintf(file, "\tAttribute(\"%s\" \"%s\")\n", name, value);
}

/*
 * Open element definition.
 */
void pcb_elem_begin(FILE *file, const char *sflags, const char *desc, const char *name, const char *value, int32_t mx, int32_t my, int32_t tx, int32_t ty, uint8_t tdir, uint16_t tscale, const char *tsflags)
{
	fprintf(file, "Element[\"%s\" \"%s\" \"%s\" \"%s\" %i %i %i %i %u %u \"%s\"]\n(\n", sflags, desc, name, value, mx, my, tx, ty, tdir, tscale, tsflags);
}

/*
 * Close element.
 */
void pcb_elem_end(FILE *file)
{
	fprintf(file, ")\n");
}
