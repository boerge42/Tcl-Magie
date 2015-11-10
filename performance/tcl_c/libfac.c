/* *********************************************************************
 * 
 *   factorial Tcl-Extention
 *   =======================
 *       Uwe Berger; 2015
 * 
 * 
 * Tcl-Syntax:
 * -----------
 * factorial <number>
 * 
 * 10! = 3628800
 * 
 * -->  puts [factorial 10]
 * -->  3628800
 * 
 * 
 * ---------
 * Have fun!
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

#include <tcl.h>
#include "libfac.h"


/* *************************************************** */
unsigned long long int factorial (int n) 
{
	if (n <= 1) {
		return n;
	} else {
		return n * factorial(n-1);
	}
}


/* *************************************************** */
/* *************************************************** */
/* *************************************************** */
/* Erweiterung initialisieren */
int Fac_Init (Tcl_Interp *interp) {

#ifdef USE_TCL_STUBS
	if (Tcl_InitStubs(interp, TCL_VERSION, 0) == 0L) {
		return TCL_ERROR;
	}
#endif

	/* factorial-Kommando erzeugen */
	Tcl_CreateObjCommand (interp, "factorial", Fac_cmd, NULL, NULL);
	return TCL_OK;
}

/* *************************************************** */
/* *************************************************** */
/* *************************************************** */
/* factorial-Kommando */
int Fac_cmd (ClientData cdata,
				  Tcl_Interp *interp, 
				  int objc,
				  Tcl_Obj * CONST objv[]) {
					  
	int fac;
	Tcl_Obj** buf;
					  	
	// Parameter ueberpruefen...
	// ...genau ein Parameter (factorial <number>)
	if (objc != 2) {
		Tcl_WrongNumArgs (interp, 1, objv, "<number>\"");
		return TCL_ERROR;
	}
	// ...Parameter muss eine Zahl sein
	if (Tcl_GetIntFromObj(interp, objv[1], &fac) != TCL_OK) {
		Tcl_Obj *retval = Tcl_NewStringObj("factorial: argument must be a number", -1);
		Tcl_SetObjResult (interp, retval);
		return TCL_ERROR;	
	}
	// ...Parameter muss groesser/gleich 0 sein
	if (fac < 0) {
		Tcl_Obj *retval = Tcl_NewStringObj("factorial: argument must be >= 0", -1);
		Tcl_SetObjResult (interp, retval);
		return TCL_ERROR;			
	}
	// ...Parameter muss kleiner/gleich 20 sein 
	if (fac > 20) {
		Tcl_Obj *retval = Tcl_NewStringObj("factorial: argument must be <= 20", -1);
		Tcl_SetObjResult (interp, retval);
		return TCL_ERROR;			
	}
	
	// Berechnungs ausfuehren und Ergebnis zurueckgeben
	Tcl_Obj* retval = Tcl_NewWideIntObj((Tcl_WideInt)factorial(fac));
	Tcl_SetObjResult (interp, retval);

	return TCL_OK;
}
