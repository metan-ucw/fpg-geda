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
 * R0207
 *
 *            | - 6.3 mm - |
 *
 *            +==--------==+ - - - - - - -
 * -----------|            |------------ 2.5 mm
 *            +==--------==+ - - - - - - -
 *  
 */
void do_gen_R0207(void)
{
	const char *desc = "Resistor R0207";

	fpg_element_begin(desc);
	
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_simple(   0, 0, 600, 2000, "Pin_1", "1", "");
	fpg_pin_simple(10000, 0, 600, 2000, "Pin_2", "2", "");
	
	fpg_resistor(0, 0, 10000, 0, FPG_RESISTOR_EU);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

void do_gen_R0207_stay(void)
{
	const char *desc = "Resistor R0207 staying";
	
	fpg_element_begin(desc);
	
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_simple(0, 0, 600, 2000, "Pin_1", "1", "");
	fpg_circle_origin(1250);
	fpg_hline(1250, 0, 950);

	fpg_pin_simple(2500, 0, 600, 2000, "Pin_2", "2", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*      
 * R0204
 *
 *            | - 4.1 mm - |
 *
 *            +==--------==+ - - - - - - -
 * -----------|            |------------ 1.8 mm
 *            +==--------==+ - - - - - - -
 *  
 */
void do_gen_R0204(void)
{
	const char *desc = "Resistor R0204";

	fpg_element_begin(desc);
	
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_simple(   0, 0, 550, 1600, "Pin_1", "1", "");
	fpg_pin_simple(6000, 0, 550, 1600, "Pin_2", "2", "");
	fpg_resistor(0, 0, 6000, 0, FPG_RESISTOR_EU);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

void do_gen_R0204_stay(void)
{
	const char *desc = "Resistor R0204 staying";
	
	fpg_element_begin(desc);
	
	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);
	
	fpg_pin_simple(0, 0, 550, 1600, "Pin_1", "1", "");
	fpg_circle_origin(900);
	fpg_hline(900, 0, 935);

	fpg_pin_simple(2100, 0, 550, 1600, "Pin_2", "2", "");

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}


const char *resistor_sizes[] = {
	"R0204", 
	"R0204_stay", 
	"R0207", 
	"R0207_stay", 
	NULL
}; 

const char *resistor_desc[] = {
	"R0204 0.4W",
	"R0204 0.4W staying",
	"R0207 0.6W", 
	"R0207 0.6W staying", 
};

void (*resistor_gen[])(void) = {
	do_gen_R0204,
	do_gen_R0204_stay,
	do_gen_R0207,
	do_gen_R0207_stay,
};

int main(int argc, char *argv[])
{
	int type;

	fpg_set_file(stdout);

	if (argc != 2) {
		fprintf(stderr, "Takes one argument, either resistor type or -d\n");
		return 1;
	}

	if (!strcmp(argv[1], "-d")) {
		fpg_utils_print(resistor_sizes);
		return 0;
	}

	type = fpg_utils_find_type(resistor_sizes, argv[1]);

	if (type == -1) {
		fprintf(stderr, "Invalid resistory type.\n");
		fpg_utils_print_help(resistor_sizes, resistor_desc);	
		return -1;
	}

	resistor_gen[type]();

	return 0;
}
