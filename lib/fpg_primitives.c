
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
#include <stdio.h>
#include "fpg_primitives.h"
#include "pcb_backend.h"

#define WARN_ZERO_THICKNESS \
if (line_thickness == 0)\
	fprintf(stderr, "WARNING: Drawing line with zero thickness.\n");

/*
 * Static variables.
 */
static enum fpg_units s_units     = fpg_pcb;
static double         s_units_mul = 1;

static int32_t        origin_x    = 0;
static int32_t        origin_y    = 0;

static int16_t        s_angle     = 0;

static uint32_t       line_thickness;

FILE*          fpg_out_file;

/*
 * Internal convert functions.
 */
static uint32_t c_uint32(uint32_t val)
{
	return s_units_mul * val;
}

static int32_t c_int32(int32_t val)
{
	return s_units_mul * val;
}

/*
static uint32_t u_uint32(uint32_t val)
{
	return val/s_units_mul;
}
*/

static int32_t u_int32(int32_t val)
{
	return val/s_units_mul;
}

/*
 * Wrappers.
 */
static void line(int32_t x1, int32_t y1, int32_t x2, int32_t y2)
{
	WARN_ZERO_THICKNESS
	pcb_line(fpg_out_file, x1, y1, x2, y2, line_thickness);
}

static void arc(int32_t x, int32_t y, int32_t w, int32_t h, uint16_t start_angle, uint16_t delta_angle)
{
//	WARN_ZERO_THICKNESS
	pcb_arc(fpg_out_file, x, y, w, h, start_angle, delta_angle, line_thickness);
}

static void pin(int32_t x, int32_t y, uint16_t thickness, uint16_t clearance, uint16_t mask, uint16_t drill, const char *name, const char *number, const char *sflags)
{
	pcb_pin(fpg_out_file, x, y, thickness, clearance, mask, drill, name, number, sflags);
}

/*
 * Set units we are working with.
 */
void fpg_set_units(enum fpg_units units)
{
	switch (units) {
		case fpg_mm:
			s_units_mul = FPG_MILS_IN_MM * 100;
		break;
		case fpg_um:
			s_units_mul = FPG_MILS_IN_MM / 10;
		break;
		case fpg_mil:
			s_units_mul = 100;
		break;
		case fpg_pcb:
			s_units_mul = 1;
		break;
	}

	s_units = units;
}

/*
 * Get units we are working with.
 */
enum fpg_units fpg_get_units(void)
{
	return s_units;
}

/*
 * Set origin point.
 */
void fpg_set_origin(int32_t x,  int32_t y)
{
	origin_x = c_int32(x);
	origin_y = c_int32(y);
}

/*
 * Get origin point.
 */
void fpg_get_origin(int32_t *x, int32_t *y)
{
	*x = u_int32(origin_x);
	*y = u_int32(origin_x);
}

/*
 * Add to origin.
 */
void fpg_add_origin(int32_t x, int32_t y)
{
	origin_x += c_int32(x);
	origin_y += c_int32(y);
}

/*
 * Set origin point.
 */
void fpg_set_origin_back(int32_t x,  int32_t y)
{
	origin_x = x;
	origin_y = y;
}

/*
 * Get origin point.
 */
void fpg_get_origin_back(int32_t *x, int32_t *y)
{
	*x = origin_x;
	*y = origin_y;
}

/*
 * Default angle.
 */
void fpg_set_angle(int16_t angle)
{
	if (angle < 0)
		angle += 33120; //360 * 92

	angle %= 360;

	s_angle = angle;
}


void fpg_add_angle(int16_t angle)
{
	s_angle += angle;
	
	if (s_angle < 0)
		s_angle += 360;

	s_angle %= 360;
}

int16_t fpg_get_angle(void)
{
	return s_angle;
}

/*
 * Set file to work with.
 */
void fpg_set_file(FILE *f)
{
	fpg_out_file = f;
}

/*
 * Get file we are working with.
 */
FILE *fpg_get_file(void)
{
	return fpg_out_file;
}

/*
 * Set default line thickness.
 */
void fpg_set_line_thickness(uint32_t thickness)
{
	line_thickness = c_uint32(thickness);
}

/*
 * Get default line thickness.
 */
uint32_t fpg_get_line_thickness(void)
{
	return line_thickness;
}

/*
 * Draws a line.
 */
void fpg_line(int32_t x1, int32_t y1, int32_t x2, int32_t y2)
{
	line(origin_x + c_int32(x1), origin_y + c_int32(y1), origin_x + c_int32(x2), origin_y + c_int32(y2));
}

void fpg_line_origin(int32_t x, int32_t y)
{
	fpg_line(0, 0, x, y);
}

void fpg_line_origin_add(int32_t x, int32_t y)
{
	fpg_line(0, 0, x, y);
	fpg_add_origin(x, y);
}

/*
 * Horizontal line.
 */
void fpg_hline(int32_t x, int32_t y, int32_t l)
{
	fpg_line(x, y, x + l, y);
}

void fpg_hline_origin(int32_t l)
{
	fpg_line(0, 0, l, 0);
}

void fpg_hline_origin_add(int32_t l)
{
	fpg_line(0, 0, l, 0);
	fpg_add_origin(l, 0);
}

/*
 * Vertical line.
 */
void fpg_vline(int32_t x, int32_t y, int32_t l)
{
	fpg_line(x, y, x, y + l);
}

void fpg_vline_origin(int32_t l)
{
	fpg_line(0, 0, 0, l);
}

void fpg_vline_origin_add(int32_t l)
{
	fpg_line(0, 0, 0, l);
	fpg_add_origin(0, l);
}

/*
 * Line accordigly to angle.
 */
void fpg_line_angle(int32_t x, int32_t y, int32_t l)
{
	int32_t vx = 1.00 * c_int32(l) / cos(3.1415*s_angle/180);
	int32_t vy = 1.00 * c_int32(l) / sin(3.1415*s_angle/180);
	int32_t mx = origin_x + c_int32(x);
	int32_t my = origin_y + c_int32(y);

	line(mx, my, mx + vx, my + vy);
}

void fpg_line_angle_origin(int32_t l)
{
	fpg_line_angle(0, 0, l);
}

void fpg_line_angle_origin_add(int32_t l)
{
	int32_t vx = 1.00 * c_int32(l) / cos(3.1415*s_angle/180);
	int32_t vy = 1.00 * c_int32(l) / sin(3.1415*s_angle/180);

	line(origin_x, origin_y, origin_x + vx, origin_y + vy);

	origin_x += vx;
	origin_y += vy;
}

/*
 * Draws rectangle.
 */
void fpg_rectangle_origin(int32_t w, int32_t h)
{
	fpg_rectangle(0, 0, w, h);
}

void fpg_rectangle(int32_t x, int32_t y, int32_t w, int32_t h)
{
	int32_t mx = origin_x + c_int32(x);
	int32_t my = origin_y + c_int32(y);

	line(mx             , my             , mx + c_int32(w), my             );
	line(mx             , my             , mx             , my + c_int32(h));
	line(mx + c_int32(w), my + c_int32(h), mx + c_int32(w), my             );
	line(mx + c_int32(w), my + c_int32(h), mx             , my + c_int32(h));
}

void fpg_parallelogram(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3)
{
	int32_t mx1 = origin_x + c_int32(x1);
	int32_t my1 = origin_y + c_int32(y1);
	int32_t mx2 = origin_x + c_int32(x2);
	int32_t my2 = origin_y + c_int32(y2);
	int32_t mx3 = origin_x + c_int32(x3);
	int32_t my3 = origin_y + c_int32(y3);

	line(mx1, my1, mx2, my2);
	line(mx1, my1, mx3, my3);
	
	mx1 *= -1;
	my1 *= -1;
	
	mx1 += mx2 + mx3;
	my1 += my2 + my3;

	line(mx2, my2, mx1, my1);
	line(mx3, my3, mx1, my1);
}

void fpg_parallelogram_origin(int32_t x1, int32_t y1, int32_t x2, int32_t y2)
{
	fpg_parallelogram(0, 0, x1, y1, x2, y2);
}


void fpg_tetragon(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3, int32_t x4, int32_t y4)
{
	int32_t mx1 = origin_x + c_int32(x1);
	int32_t my1 = origin_y + c_int32(y1);
	int32_t mx2 = origin_x + c_int32(x2);
	int32_t my2 = origin_y + c_int32(y2);
	int32_t mx3 = origin_x + c_int32(x3);
	int32_t my3 = origin_y + c_int32(y3);
	int32_t mx4 = origin_x + c_int32(x4);
	int32_t my4 = origin_y + c_int32(y4);
	
	line(mx1, my1, mx2, my2);
	line(mx2, my2, mx3, my3);
	line(mx3, my3, mx4, my4);
	line(mx4, my4, mx1, my1);
}

void fpg_tetragon_origin(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3)
{
	fpg_tetragon(0, 0, x1, y1, x2, y2, x3, y3);
}

void fpg_circle(int32_t x, int32_t y, uint32_t r)
{
	uint32_t tr = c_uint32(r);

	arc(origin_x + c_int32(x), origin_y + c_int32(y), tr, tr, 0, 360);
}

void fpg_circle_origin(uint32_t r)
{
	fpg_circle(0, 0, r);
}

void fpg_arc(int32_t x, int32_t y, int32_t r, int16_t start_angle, int16_t delta_angle)
{
	arc(origin_x + c_int32(x), origin_y + c_int32(y), c_int32(r), c_int32(r), start_angle, delta_angle);
}

void fpg_arc_origin(int32_t r, int16_t start_angle, int16_t delta_angle)
{
	fpg_arc(0, 0, r, start_angle, delta_angle);
}

void fpg_pin(int32_t x, int32_t y, uint32_t thickness, uint32_t clearance, uint32_t mask, uint32_t drill, const char *name, const char *number, const char *sflags)
{
	pin(origin_x + c_int32(x), origin_y + c_int32(y), c_uint32(thickness), c_uint32(clearance), c_uint32(mask), c_uint32(drill), name, number, sflags);
}

void fpg_pin_simple(int32_t x, int32_t y, uint32_t drill, uint32_t copper, const char *name, const char *number, const char *sflags)
{
	pin(origin_x + c_int32(x), origin_y + c_int32(y), c_uint32(copper), c_uint32(1.10*copper), c_uint32(copper), c_uint32(drill), name, number, sflags);
}

void fpg_pin_default(int32_t x, int32_t y, const char *name, const char *number, const char *sflags)
{
	pin(origin_x + c_int32(x), origin_y + c_int32(y), FPG_MM_TO_PCB(2), FPG_MM_TO_PCB(3), FPG_MM_TO_PCB(2), FPG_MM_TO_PCB(0.7), name, number, sflags);
}

void fpg_pin_big(int32_t x, int32_t y, const char *name, const char *number, const char *sflags)
{
	pin(origin_x + c_int32(x), origin_y + c_int32(y), FPG_MM_TO_PCB(3), FPG_MM_TO_PCB(4), FPG_MM_TO_PCB(3), FPG_MM_TO_PCB(1.7), name, number, sflags);
}

void fpg_element_begin(const char *desc)
{
	pcb_elem_begin(fpg_out_file, "", desc, "", "", 100000, 100000, 1000, 1000, 0, 100, "");
}

void fpg_element_end(void)
{
	pcb_elem_end(fpg_out_file);
}
