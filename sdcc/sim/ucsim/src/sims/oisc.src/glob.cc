/*
 * Simulator of microcontrollers (glob.cc)
 *
 * Copyright (C) 2022 Drotos Daniel, Talker Bt.
 * 
 * To contact author send email to drdani@mazsola.iit.uni-miskolc.hu
 *
 */

/* This file is part of microcontroller simulator: ucsim.

UCSIM is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

UCSIM is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with UCSIM; see the file COPYING.  If not, write to the Free
Software Foundation, 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA. */
/*@1@*/

#include <stdio.h>

#include "glob.h"

struct cpu_entry cpus_oisc[]=
  {
    {"OISC"	, CPU_OISC, 0		, "OISC", ""},
    {"URISC"	, CPU_URISC, 0		, "USISC", ""},
    {"U"	, CPU_URISC, 0		, "USISC", ""},
    {"MISC16"	, CPU_MISC16, 0		, "MISC16", ""},
    {"M"	, CPU_MISC16, 0		, "MISC16", ""},
    {"EM"	, CPU_EM, 0		, "EM", ""},
    {"E"	, CPU_EM, 0		, "EM", ""},

    {NULL, CPU_NONE, 0, "", ""}
  };

/* End of oisc.src/glob.cc */
