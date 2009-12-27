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

#ifndef __PCB_BACKEND_H__
#define __PCB_BACKEND_H__

#include <stdio.h>
#include <stdint.h>

/*
 * Metadata definitions.
 */
#define PCB_AUTHOR "author"
#define PCB_COPYRIGHT "copyright"
#define PCB_USE_LICENSE "use-license"
#define PCB_DIST_LICENSE "dist-license"
#define PCB_DESCRIPTION "description"

/*
 * Simple line.
 */
void pcb_line(FILE *file, int32_t x1, int32_t y1, int32_t x2, int32_t y2, int32_t thickness);

/*
 * Arc.
 */
void pcb_arc(FILE *file, int32_t x, int32_t y, int32_t w, int32_t h, uint16_t start_angle, uint16_t delta_angle, int32_t thickness);

/*
 * Pin.
 *
 * Thickness: outer diameter of copper.
 * Clearance: thickness + clearance = actual clearance
 * Mask:      solder mask
 * Drill:     drill hole
 * Name:      pin name
 * Number:    pin number
 * SFlags:    flags (for example "square", generates square pin)
 *                  ("onsolder" creates pin/pad on the oposit side)
 */
void pcb_pin(FILE *file, int32_t x, int32_t y, uint16_t thickness, uint16_t clearance, uint16_t mask, uint16_t drill, const char *name, const char *number, const char *sflags);

/*
 * Pad.
 *
 * Thickness: size of copper around line.
 * Clearance: add to thickness to get actual clearance
 * Mask:      solder mask
 * Name:      pad name
 * Number:    pad number
 * SFlags:    flags
 */
void pcb_pad(FILE *file, int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint16_t thickness, uint16_t clearance, uint16_t mask, const char *name, const char *number, const char *sflags); 

/*
 * Used for metadata.
 *
 * Known attributes:
 *
 * "author"
 * "copyright"
 * "use-licence"
 * "dist-licence"
 * "description"
 */
void pcb_attribute(FILE *file, const char *name, const char *value);

/*
 * Open element definition.
 *
 * SFlags:  flags applied to whole footprint.
 * 
 * Desc:    footprint description, leave empty it's filled by gsch2pcb.
 *
 * Name:    name, leave empty, it's filled by gsch2pcb.
 *
 * Value:   component value, filled by gsch2pcb.
 *
 * mx, my:  initial footprint location when inserted into schematics.
 * tx, ty:  text location
 *
 * Tdir:   text direction
 *       
 *       0 = horizontal
 *       1 = ccw 90 deg
 *       2 = 180 deg
 *       3 = cw 90 deg
 *
 * Tscale:  text scale, integer, 100 = 100% is default
 * 
 * TSFlags: text flags.
 */
void pcb_elem_begin(FILE *file, const char *sflags, const char *desc, const char *name, const char *value, int32_t mx, int32_t my, int32_t tx, int32_t ty, uint8_t tdir, uint16_t tscale, const char *tsflags);  

/*
 * Close element.
 */
void pcb_elem_end(FILE *file);

#endif /* __PCB_BACKEND_H__ */
