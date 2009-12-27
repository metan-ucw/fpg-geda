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
#include <string.h>
#include "fpg_common.h"

/*      
 * DO35
 *
 *            | 3.5 mm |
 *
 *  0.3 mm     --------  - - - - - - -
 * -----------| ||     |------------ 1.6 mm
 *             --------  - - - - - - -
 *  PIN1                        PIN2
 *            ___|/|___
 *               |\|
 */
void do_gen_DO35(void)
{
	const char *desc = "Diode DO35";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(   0, 0, 500, 1600, "Pin_1", "1", "square");
	fpg_pin_simple(5000, 0, 500, 1600, "Pin_2", "2", "");
	fpg_diode(5000, 0, -5000, 0, FPG_DIODE_GEN);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*
 * Staying DO35 diode, space between pins is 0.5 mm.
 */
void do_gen_DO35_stay(void)
{
	const char *desc = "Diode DO35 staying";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(0, 0, 500, 1600, "Pin_1", "1", "square");
	fpg_circle_origin(800);

	fpg_hline(800, 0, 1050);

	fpg_pin_simple(2100, 0, 500, 1600, "Pin_2", "2", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*      
 * DO41
 *
 *            |- 5 mm -|
 *
 *  0.7 mm    +--------+ - - - - - - -
 * -----------|X|      |------------ 2.7 mm
 *            +--------+ - - - - - - -
 *  PIN1                        PIN2
 *            ___|/|___
 *               |\|
 */
void do_gen_DO41(void)
{
	const char *desc = "Diode DO41";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(    0, 0, 800, 2500, "Pin_1", "1", "square");
	fpg_pin_simple(10000, 0, 800, 2500, "Pin_2", "2", "");
	fpg_diode(10000, 0, -10000, 0, FPG_DIODE_GEN);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*
 * Staying DO41 diode, space between pins is 1 mm
 */
void do_gen_DO41_stay(void)
{
	const char *desc = "Diode DO41 staying";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(0, 0, 800, 2500, "Pin_1", "1", "square");
	fpg_circle_origin(1350);

	fpg_hline(1350, 0, 1750);

	fpg_pin_simple(3500, 0, 800, 2500, "Pin_2", "2", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*      
 * DO201
 *
 *            |- 8 mm -|
 *            
 *  1 mm      +--------+ - - - - - - - 
 * ___________|X|      |____________
 *            |X|      |             5 mm
 *            +--------+ - - - - - - -
 *  PIN1                        PIN2
 *            ___|/|___
 *               |\|
 */
void do_gen_DO201(void)
{
	const char *desc = "Diode DO201";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(    0, 0, 1100, 4000, "Pin_1", "1", "square");
	fpg_pin_simple(15000, 0, 1100, 4000, "Pin_2", "2", "");
	fpg_diode(15000, 0, -15000, 0, FPG_DIODE_GEN);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*
 * Staying DO201 diode, space between pins is 2 mm
 */
void do_gen_DO201_stay(void)
{
	const char *desc = "Diode DO201 staying";

	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_simple(0, 0, 1100, 4000, "Pin_1", "1", "square");
	fpg_circle_origin(2500);

	fpg_hline(2500, 0, 2000 + 950);

	fpg_pin_simple(6000, 0, 1100, 4000, "Pin_2", "2", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}


const char *diode_sizes[] = {
	"DO35",
	"DO35_stay",
	"DO41",
	"DO41_stay",
	"DO201",
	"DO201_stay",
	NULL
}; 

const char *diode_desc[] = {
	"Diode DO35",
	"Diode DO35 staying",
	"Diode DO41",
	"Diode DO41 staying",
	"Diode DO201",
	"Diode DO201 staying",
};

void (*diode_gen[])(void) = {
	do_gen_DO35,
	do_gen_DO35_stay,
	do_gen_DO41,
	do_gen_DO41_stay,
	do_gen_DO201,
	do_gen_DO201_stay,
};

int main(int argc, char *argv[])
{
	int type;

	fpg_set_file(stdout);

	if (argc != 2) {
		fprintf(stderr, "Takes one argument, either diode type or -d\n");
		return 1;
	}

	if (!strcmp(argv[1], "-d")) {
		fpg_utils_print(diode_sizes);
		return 0;
	}

	type = fpg_utils_find_type(diode_sizes, argv[1]);

	if (type == -1) {
		fprintf(stderr, "Invalid diode type.\n");
		fpg_utils_print_help(diode_sizes, diode_desc);	
		return -1;
	}

	diode_gen[type]();

	return 0;
}
