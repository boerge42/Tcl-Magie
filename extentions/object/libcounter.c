/* *********************************************************************
 * 
 *   counter Tcl-Extention
 *   =====================
 *     Uwe Berger; 2015
 * 
 * 
 * Beispiel aus: "Tcl und Tk"; John K. Ousterhout; Kapitel 30 ff.:
 * 
 * Erzeugen eines von "Befehls-Objekten" mit jeweils eigenen 
 * Datenbereich.
 * 
 * Tcl-Syntax:
 * -----------
 * % counter
 * ctr0
 * % counter
 * ctr1
 * % ctr0 next
 * % ctr0 get
 * 1
 * % ctr1 get
 * 0
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
#include "libcounter.h"


/* *************************************************** */
void DeleteCounter (ClientData clientData) {
	// Daten-Bereich des entsprechenden Kommandos loeschen
	free ((char *) clientData);
}

/* *************************************************** */
int ObjectCmd (ClientData clientData, 
				Tcl_Interp *interp,
				int argc,
				const char *argv[]) {
					
	char str_value[10];
	
	// Daten-Pointer auf Datenbereich des entsprechenden Kommandos setzen
	Counter *counterPtr = (Counter *) clientData;
	// Anzahl Parameter pruefen
	if (argc != 2) {
		Tcl_AppendResult(interp, 
		                 "wrong # args: should be \"",
		                 argv[0],
		                 " <next|get>\"",
						 (char *) NULL);
		return TCL_ERROR;
	}	
	// Objekt-Befehl abarbeiten (oder auch nicht)
	if (strcmp(argv[1], "get") == 0) {
		sprintf(str_value, "%d", counterPtr->value);
		Tcl_AppendResult(interp, str_value, (char *) NULL);
	} else if (strcmp(argv[1], "next") == 0) {
		counterPtr->value++;
	} else {
		Tcl_AppendResult(interp, 
		                 "bad counter command \"",
						 argv[1], 
						 "\": should be get or next",
						 (char *) NULL);
		return TCL_ERROR;
	}
	return TCL_OK;	
}

/* *************************************************** */
int CounterCmd (ClientData clientData,
				  Tcl_Interp *interp, 
				  int argc,
				  const char *argv[]) {
					  
	Counter *counterPtr;
	static int id = 0;
	char cmd_name[10];
	
	// Anzahl Parameter pruefen
	if (argc != 1) {
		Tcl_AppendResult(interp, 
		                 "wrong # args: should be \"counter\"",
						 (char *) NULL);
		return TCL_ERROR;
	}	
	// Daten des neuen Kommandos erzeugen und initialisieren
	counterPtr = (Counter *) malloc (sizeof (Counter));
	counterPtr-> value = 0;
	// Name des neuen Kommandos erzeugen, dem Interpreter bekannt
	// machen und als Ergebnis zurueck geben
	sprintf(cmd_name, "ctr%d", id);
	id++;
	Tcl_CreateCommand(interp, cmd_name, ObjectCmd,
	                  (ClientData) counterPtr, DeleteCounter);
	Tcl_AppendResult(interp, cmd_name, (char *) NULL);
	return TCL_OK;
}


/* Erweiterung initialisieren */
int Counter_Init (Tcl_Interp *interp) {
	/* counter-Kommando erzeugen */
	Tcl_CreateCommand (interp, "counter", CounterCmd, NULL, NULL);
	return TCL_OK;
}
