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

#ifndef __FPG_PRIMITIVES_H__
#define __FPG_PRIMITIVES_H__

#include "fpg_units.h"
#include <stdio.h>
#include <stdint.h>

/*
 * Set/get units we are working with.
 */
void           fpg_set_units(enum fpg_units units);
enum fpg_units fpg_get_units(void);

/*
 * Set/get origin for some operations. 
 */
void           fpg_set_origin(int32_t x,  int32_t y);
void           fpg_get_origin(int32_t *x, int32_t *y); 
void           fpg_add_origin(int32_t x, int32_t y);

/*
 * You allways get these in backend specific format to avoid rounding errors.
 *
 * Use them to save/load origin point in subruntines.
 */
void           fpg_get_origin_back(int32_t *x, int32_t *y); 
void           fpg_set_origin_back(int32_t x, int32_t y); 

/*
 * Default angle.
 */
void          fpg_set_angle(int16_t angle);
void          fpg_add_angle(int16_t angle);
int16_t       fpg_get_angle(void);

/*
 * Set/get file we are working with.
 */
void           fpg_set_file(FILE *f);
FILE          *fpg_get_file(void);

/*
 * Seg/get line thickness.
 */
void           fpg_set_line_thickness(uint32_t thickness);
uint32_t       fpg_get_line_thickness(void);

/*
 * Draw line.
 */
void fpg_line(int32_t x1, int32_t y1, int32_t x2, int32_t y2);
/*
 * Draw line from origin.
 */
void fpg_line_origin(int32_t x, int32_t y);
/*
 * Draw line from origin and set origin to the endpoint of line.
 */
void fpg_line_origin_add(int32_t x, int32_t y);

/*
 * Draws horizontal line.
 */
void fpg_hline(int32_t x, int32_t y, int32_t l);
/*
 * Draws horizontal line starting in origin.
 */
void fpg_hline_origin(int32_t l);
/*
 * Draw horizontal line starting in origin and moves origin at the end of the line.
 */
void fpg_hline_origin_add(int32_t l);

/*
 * Draws vertical line.
 */
void fpg_vline(int32_t x, int32_t y, int32_t l);
/*
 * Draws vertical line starting in origin.
 */
void fpg_vline_origin(int32_t l);
/*
 * Draws vertical line starting in origin and sets origin to the end of the line.
 */
void fpg_vline_origin_add(int32_t l);
/*
 * Draws line accorgingly to origin and angle.
 */
void fpg_line_angle(int32_t x, int32_t y, int32_t l);
void fpg_line_angle_origin(int32_t l);
void fpg_line_angle_origin_add(int32_t l);

/*
 * Rectangles parallel to axis.
 */
void fpg_rectangle_origin(int32_t w, int32_t h);
void fpg_rectangle(int32_t x1, int32_t y1, int32_t w, int32_t h);

/*
 * Paraelogram.
 *
 * [x2,y2]
 *         ^    [x3,y3]
 *         |   /
 *         |  /
 *         | /
 *         +
 * [x1,y1]
 *
 *
 */
void fpg_parallelogram(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3, int32_t y3);
void fpg_parallelogram_origin(int32_t x1, int32_t y1, int32_t x2, int32_t y2);


/*
 * Generic tetgragon.
 */
void fpg_tetragon(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3,  int32_t y3, int32_t x4, int32_t y4);
void fpg_tetragon_origin(int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t x3,  int32_t y3);

/*
 * Circles.
 */
void fpg_circle_origin(uint32_t r);
void fpg_circle(int32_t x, int32_t y, uint32_t r);

/*
 * Arc. 
 */
void fpg_arc(int32_t x, int32_t y, int32_t r, int16_t start_angle, int16_t delta_angle);
void fpg_arc_origin(int32_t r, int16_t start_angle, int16_t delta_angle);

/*
 * Pin functions.
 */
void fpg_pin(int32_t x, int32_t y, uint32_t thickness, uint32_t clearance, uint32_t mask, uint32_t drill, const char *name, const char *number, const char *sflags);

/*
 * Simple pin, only drill hole and copper are needed.
 */
void fpg_pin_simple(int32_t x, int32_t y, uint32_t drill, uint32_t copper, const char *name, const char *number, const char *sflags);

/* 
 * Default size pin, should fit for standart SMT components.
 */
void fpg_pin_small(int32_t x, int32_t y, const char *name, const char *number, const char *sflags);
void fpg_pin_default(int32_t x, int32_t y, const char *name, const char *number, const char *sflags);
void fpg_pin_big(int32_t x, int32_t y, const char *name, const char *number, const char *sflags);

/*
 * Basics element init.
 */
void fpg_element_begin(const char *desc);
void fpg_element_end(void);

#endif /* __FPG_PRIMITIVES_H__ */
