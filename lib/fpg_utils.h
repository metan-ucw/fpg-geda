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

#ifndef __FPG_UTILS_H__
#define __FPG_UTILS_H__

/*
 * Returns possition for type in types or -1
 */
int fpg_utils_find_type(const char *types[], const char *type);

/*
 * Prints help into stderr.
 */
void fpg_utils_print_help(const char *types[], const char *descs[]);

/*
 * Prints types into stdout.
 */
void fpg_utils_print(const char *types[]);

#endif /* __FPG_UTILS_H__ */
