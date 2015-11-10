/* *********************************************************************
 * 
 *   counter Tcl-Extention
 *   =====================
 *      Uwe Berger; 2015
 * 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *     
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 *
 * 
 * *********************************************************************
 */
#ifndef __LIBCOUNTER_H__
#define __LIBCOUNTER_H__

#include <stdlib.h>


typedef struct {
	int value;
} Counter;

/* Forwards */

void DeleteCounter (ClientData clientData);

int ObjectCmd (ClientData clientData, 
				Tcl_Interp *interp,
				int argc,
				const char *argv[]);
				
int CounterCmd (ClientData clientData,
				  Tcl_Interp *interp, 
				  int argc,
				  const char *argv[]);

#endif /* __LIBCOUNTER_H__ */
