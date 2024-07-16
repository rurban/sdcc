;--------------------------------------------------------------------------
;  memmove.s
;
;  Copyright (C) 2008-2021, Philipp Klaus Krause, Marco Bodrato
;
;  This library is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by the
;  Free Software Foundation; either version 2, or (at your option) any
;  later version.
;
;  This library is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this library; see the file COPYING. If not, write to the
;  Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
;   MA 02110-1301, USA.
;
;  As a special exception, if you link this library with other files,
;  some of which are compiled with SDCC, to produce an executable,
;  this library does not by itself cause the resulting executable to
;  be covered by the GNU General Public License. This exception does
;  not however invalidate any other reasons why the executable file
;   might be covered by the GNU General Public License.
;--------------------------------------------------------------------------

	.module memmove
	.optsdcc -mz80 sdcccall(1)

        .area   _CODE

	.globl _memmove

; The Z80 has the ldir and lddr instructions, which are perfect for implementing memmove().

_memmove:
	pop	iy
	pop	bc
	ld	a, c
	or	a, b
	ex	de, hl
	jr	Z, end
	ex	de, hl
	push	hl
	sbc	hl, de		; or above cleared carry.
	add	hl, de		; same carry as the line before
	jr	C, memmove_up
memmove_down:
	dec	bc
	add	hl, bc
	ex      de, hl
	add	hl, bc
	inc	bc
	lddr
	pop	de
end:
	jp	(iy)
memmove_up:
	ex      de, hl
	ldir
	pop	de
	jp	(iy)

