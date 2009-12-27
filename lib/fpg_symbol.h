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

#ifndef __FPG_SYMBOL_H__
#define __FPG_SYMBOL_H__

#include <stdint.h>

/*
 * Draws arrow betwen two points.
 *    
 *   __ [x2,y2]
 *    /\
 *   /  
 *  /
 *  [x1,y1]
 */
void fpg_arrow(int32_t x1, int32_t y1, int32_t x2, int32_t y2);
void fpg_arrow_origin(int32_t x, int32_t y);

/*
 * Draws plus '+' sing.
 *
 *       |
 *       |
 *  --[x1,y1]--[x2, y2]
 *       |
 *       |
 */
void fpg_plus(int32_t x1, int32_t y1, int32_t x2, int32_t y2);
void fpg_plus_origin(int32_t x, int32_t y);

/*
 * Koch's snowflake
 */
void fpg_koch_origin(int32_t l, uint8_t iter);


#endif /* __FPG_SYMBOL_H__ */
