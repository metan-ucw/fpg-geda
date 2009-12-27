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

#ifndef __FPG_METADATA_H__
#define __FPG_METADATA_H__

#define FPG_METADATA_DEFAULT(author, description) \
	fpg_author(author"; Created by pcb utils."); \
	fpg_copyright(author); \
	fpg_dist_license("GPLv2"); \
	fpg_use_license("Unlimited"); \
	fpg_description(description);

/*
 * Author of the footprint.
 */
void fpg_author(const char *author);

/*
 * Footprint description.
 */
void fpg_description(const char *desc);

/*
 * Fotprint license, you can distribute it under.
 */
void fpg_dist_license(const char *license);

/*
 * Footprint use license.
 */
void fpg_use_license(const char *license);

/*
 * Footprint copyright.
 */
void fpg_copyright(const char *copyright);

/*
 * Generic metadata.
 */
void fpg_metadata(const char *key, const char *value);

#endif /* __FPG_METADATA_H__ */
