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

#include <string.h>
#include <stdio.h>
#include "fpg_utils.h"

int fpg_utils_find_type(const char *types[], const char *type)
{
	int i;

	for (i = 0; types[i] != NULL; i++)
		if (!strcmp(types[i], type))
			return i;

	return -1;
}

static void print_spaces(unsigned int n)
{
	unsigned int i;

	for (i = 0; i < n; i++)
		fputc(' ', stderr);
}

void fpg_utils_print_help(const char *types[], const char *descs[])
{
	unsigned int max_type = 0;
	int i;

	for (i = 0; types[i] != NULL; i++) {
		size_t len = strlen(types[i]);
		if (len > max_type)
			max_type = len;
	}

	for (i = 0; types[i] != NULL; i++) {
		fprintf(stderr, "%s", types[i]);
		print_spaces(max_type + 1 - strlen(types[i]));
		fprintf(stderr, "- %s\n", descs[i]);
	}
}

void fpg_utils_print(const char *types[])
{
	int i;

	for (i = 0; types[i] != NULL; i++)
		printf("%s\n", types[i]);
}
