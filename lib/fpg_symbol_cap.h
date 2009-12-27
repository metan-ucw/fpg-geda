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

#ifndef __FPG_SYMBOL_CAP_H__
#define __FPG_SYMBOL_CAP_H__

#include <stdint.h>

#define FPG_CAP_GEN     0x01 /* generic   -||- */
#define FPG_CAP_POL_A   0x02 /* polarized -|[- */
#define FPG_CAP_POL_B   0x03 /* polarized -|(- */
#define FPG_CAP_VAR     0x04 /* variable       */
#define FPG_CAP_PLUS    0x08 /* show + sing    */

/*
 * Draws capacitor betwen two points.
 */
void fpg_cap(int32_t x1, int32_t y1, int32_t x2, int32_t y2, uint8_t type);


#endif /* __FPG_SYMBOL_CAP_H__ */
