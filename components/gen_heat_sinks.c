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
 * Generates TO220 heat sink footprint.
 *
 * (V7142A or V7142B)
 * 
 * | - - 24mm - - -|
 *                   - - - - - -
 * ||< - 22mm - ->||   |       |
 * ||             ||   6.6mm   16mm
 * ||_____________|| _ _
 * | _  _     _  _ | _ _ 1.6mm |
 * || || | O | || ||   |
 * || || |/ \| || ||   7.8mm   |
 * || || || || || || - - - - - -
 *  
 *     | |
 * ||   3.4mm
 *  1mm
 *
 * .._____________.. _ _ _ _ _
 * ||             ||         |
 * ||      _      ||
 * ||     ( )     ||         |
 * ||             ||
 * ||             ||         V7142A   25mm 
 * ||             ||         V7142B,C 40mm
 * ||             ||         |
 * ||             ||
 * ||             ||         |
 * ||_____________|| _ _ _ _ _
 *         ||
 *         ||
 *
 *         ||
 *          2mm      /
 *   2mm_            \
 *       \         __/  _ _
 *        \/-\    |       |
 *        ( \ )   |       2mm
 *         \ /    | _ _ _ _
 *         / \    |       2.8mm
 *        / ^ \   | _ _ _ _
 *       |  |  |  |       |
 *       | 1mm |  |
 *       |     |  |       |
 *       |     |  |       3mm
 *       |     |  |
 *       |     |  |       |
 *    |__|     |__| _ _ _ _
 *
 *       |     |
 *
 *       |3.4mm|
 */
static void gen_V7141X(void)
{
	char *desc = "SOT93/TO220 heat sink with one soldering pin.";
//	fpg_element_begin("", "TO220 heat sink with one soldering pin", "", "", 10000, 10000, 2500, 1000);
	fpg_element_begin(desc);

	fpg_set_line_thickness(1000);
	fpg_set_units(fpg_um);

	fpg_pin_big(0, 0, "Pin_1", "1", "");
	fpg_set_origin(-12000, -9200);

	fpg_vline_origin(16000);
	fpg_hline_origin_add(1000);
	fpg_vline_origin_add(6600);
	fpg_hline_origin_add(22000);
	fpg_vline_origin_add(-6600);
	fpg_hline_origin_add(1000);
	fpg_vline_origin_add(16000);
	fpg_hline_origin_add(-1000);
	fpg_vline_origin_add(-7800);
	fpg_hline_origin_add(-3400);
	fpg_vline_origin_add(7800);
	fpg_hline_origin_add(-1000);
	fpg_vline_origin_add(-7800);
	fpg_hline_origin_add(-3400);
	fpg_vline_origin_add(7800);
	fpg_hline_origin_add(-1000);
	fpg_vline_origin_add(-3000);	
	fpg_line_origin_add(-1700, -2800);
	fpg_hline_origin_add(-1000);
	fpg_line_origin_add(-1700, 2800);
	fpg_vline_origin_add(3000);
	fpg_hline_origin_add(-1000);
	fpg_vline_origin_add(-7800);
	fpg_hline_origin_add(-3400);
	fpg_vline_origin_add(7800);
	fpg_hline_origin_add(-1000);
	fpg_vline_origin_add(-7800);
	fpg_hline_origin_add(-3400);
	fpg_vline_origin_add(7800);
	fpg_hline_origin_add(-1000);

	FPG_METADATA_DEFAULT("Cyril Hrubis", desc);
	fpg_element_end();
}

/*
 * CHL142/25-BLK
 * 
 * SOT93/TO220
 *             
 *             | - -17mm - - |
 *                                         _
 *  \\   \\   ||             ||   //   //  |
 *    \\  \\  ||    1.5mm    ||  //  //
 *  \\  \\ \\ ||   /         || // //  //  |
 *    \\  \ \\||  |          ||//  / //    
 *      \  /   | \|/         |   \  /      |
 *       >O      ==|==========    O<       25mm
 *      /  \   | /|\         |   /  \      |
 *    // /  //||             ||\\  \ \\    
 *  //  // // ||             || \\ \\  \\  |
 *    //  //  ||             ||  \\  \\
 *  //   //   ||             ||   \\   \\  _
 *
 * | - - - - - - - 41.5mm  - - - - - - - |
 * 
 *     
 *         1mm
 *        >---<
 *
 *            |5mm |  |4mm | 
 *   -      -       __      __
 *   |     | |     / /     / /
 *         | |    / /    / /  
 * 7.5mm   | |   / /   / /    
 *   |     | |  /  \ / /    /|
 *   _     |  \/     /    / /
 *   |     |       /    / /
 * 4.25mm  |       \  / /
 *   |     |      __   /
 *   - /---      /  --
 *     \         \__--
 *     /---     
 *         |      
 *
 */
static void gen_V7477X(void)
{

	fpg_element_begin("SOT93/TO220 heat sink with one soldering pin");
	

	fpg_element_end();
}

static char *heat_sinks[] = {
	"V7141X",
	"V7477X",
	NULL
};

static void (*gen_heat_sink[])(void) = {
	gen_V7141X,
	gen_V7477X,
};

static void print_heatsinks(void)
{
	int i;

	for (i = 0; heat_sinks[i] != NULL; i++)
		fprintf(stderr, "%s\n", heat_sinks[i]);
}

int main(int argc, char *argv[])
{
	int i;

	if (argc != 2) {
		fprintf(stderr, "Takes name of heatsink, that's one of following:\n");
		print_heatsinks();
		return 1;
	}

	fpg_set_file(stdout);

	for(i = 0; heat_sinks[i] != NULL; i++)
		if (!strcmp(argv[1], heat_sinks[i])) {
			gen_heat_sink[i]();
			return 0;
		}


	fprintf(stderr, "No valid heatsink selected!\n");
	return 1;
}
