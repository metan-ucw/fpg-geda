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

#ifndef __FPG_UNITS_H__
#define __FPG_UNITS_H__

#define FPG_MILS_IN_MM 39.3700787
#define FPG_MM_TO_PCB(x) (100.00*(x)*FPG_MILS_IN_MM)

/*
 * Units.
 */
enum fpg_units {
	fpg_mm,  // mimimeters
	fpg_um,  // micrometers
	fpg_mil, // mils
	fpg_pcb, // pcb default, that's mils/100
};

#endif /* __FPG_UNITS_H__ */
