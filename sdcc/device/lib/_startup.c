/*-------------------------------------------------------------------------
   _startup.c - startup routine for sdcc

   Copyright (C) 1999, Sandeep Dutta . sandeep.dutta@usa.net

   This library is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this library; see the file COPYING. If not, write to the
   Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.

   As a special exception, if you link this library with other files,
   some of which are compiled with SDCC, to produce an executable,
   this library does not by itself cause the resulting executable to
   be covered by the GNU General Public License. This exception does
   not however invalidate any other reasons why the executable file
   might be covered by the GNU General Public License.
-------------------------------------------------------------------------*/

/* External startup code can be written in C
   here .. Special usage if this routine
   returns a non-zero value then global &
   static variable initialisation will be skipped.
   Beware not to use initialized variables as they
   are not initialized yet nor to use pdata/xdata
   variables if external data memory needs to be
   enabled first. */

#if defined(__SDCC_ds390) || defined(__SDCC_ds400)

/* Disable "ISO C forbids an empty source file" warning message */
#pragma disable_warning 190

#elif defined(__SDCC_mcs51) || defined(__SDCC_z80)

unsigned char __sdcc_external_startup (void) __nonbanked
{
    return 0;
}

#else

unsigned char __sdcc_external_startup (void)
{
    return 0;
}

#endif

