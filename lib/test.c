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

#include "fpg_primitives.h"
#include "fpg_symbols.h"

static void test_coil(void)
{
	fpg_coil(0, 0, 0, 1000, 3);
	fpg_coil(0, 0, 1000, 0, 7);
	fpg_coil(0, 0, 1000, 1000, 5);
	fpg_coil(0, 0, 1000, 500, 2);
}

static void test_cap(void)
{
	fpg_cap(0, 0, 1000, 0, FPG_CAP_GEN | FPG_CAP_PLUS);
	fpg_cap(0, 0, 500,  1000, FPG_CAP_POL_B | FPG_CAP_PLUS);
	fpg_cap(1000, 1000, 1000, 2000, FPG_CAP_POL_A | FPG_CAP_PLUS);
	fpg_cap(1000, 2000, 2000, 2000, FPG_CAP_POL_B);
	fpg_cap(0, 2000, 1000, 2000, FPG_CAP_VAR);
	fpg_cap(2000, 2900, 2000, 2000, FPG_CAP_VAR);
}

static void test_resistor(void)
{
	fpg_resistor(0, 0, 1000, 1000, FPG_RESISTOR_EU);
	fpg_resistor(0, 0, 1000, 0, FPG_RESISTOR_US);
	fpg_resistor(1900, 1000, 1000, 0, FPG_RESISTOR_US);
}

static void test_diode(void)
{
	fpg_diode(0, 0, 1000, 0, FPG_DIODE_GEN);
	fpg_diode(0, 0, 1000, 1000, FPG_DIODE_LED);
	fpg_diode(1000, 0, 600, 700, FPG_DIODE_LED);
}

int main(void)
{
	fpg_set_file(stdout);
	fpg_set_units(fpg_mm);
	fpg_set_line_thickness(10);

	fpg_element_begin("test");

	test_coil();
	fpg_add_origin(0, 1000);
	test_cap();
	fpg_add_origin(2000, 0);
	test_resistor();
	fpg_add_origin(0, 1000);
	test_diode();
	fpg_add_origin(200, 1200);
	fpg_koch_origin(2000, 4);

	/*
	 * This should produce warning.
	 */
	fpg_set_line_thickness(0);
	fpg_line(0,0,0,1);

	fpg_element_end();

	return 0;
}
