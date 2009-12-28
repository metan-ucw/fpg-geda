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

#include <stdio.h>
#include <stdlib.h>
#include "fpg_common.h"

/*
 *  Generate footprint for ceramic capacitor.
 *
 *           .----.
 *           |    |
 *           |____|
 *            |  |
 *           /    \
 *           |    |
 *           |    |
 *           |   >|< 0.5 mm
 *           |    |
 *          >|----|< RM = 5 mm
 */
void do_gen_cap(void)
{
	const char *desc = "Ceramic capacitor RM 5mm";

	fpg_element_begin(desc);
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_simple(0,    0, 600, 2000, "Pin_1", "1", "");
	fpg_pin_simple(5000, 0, 600, 2000, "Pin_2", "2", "");
	fpg_cap(0, 0, 5000, 0, FPG_CAP_GEN);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

int main(void)
{

	fpg_set_file(stdout);
	
	do_gen_cap();
	
	return 0;
}
