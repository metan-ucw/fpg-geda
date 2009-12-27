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

#ifndef __FPG_SYMBOL_DIODE_H__
#define __FPG_SYMBOL_DIODE_H__

#include <stdint.h>

#define FPG_DIODE_GEN 0x00 /* -|<|- */
#define FPG_DIODE_LED 0x02 /*  */

/*
 * Draws diode betwen two points.
 */
void fpg_diode(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t type);

#endif /* __FPG_SYMBOL_DIODE_H__ */
