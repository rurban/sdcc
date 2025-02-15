;-------------------------------------------------------------------------
;   div.s - implementation on std C library div
;
;   Copyright (C) 2025, Gabriele Gorla
;
;   This library is free software; you can redistribute it and/or modify it
;   under the terms of the GNU General Public License as published by the
;   Free Software Foundation; either version 2, or (at your option) any
;   later version.
;
;   This library is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this library; see the file COPYING. If not, write to the
;   Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
;   MA 02110-1301, USA.
;
;   As a special exception, if you link this library with other files,
;   some of which are compiled with SDCC, to produce an executable,
;   this library does not by itself cause the resulting executable to
;   be covered by the GNU General Public License. This exception does
;   not however invalidate any other reasons why the executable file
;   might be covered by the GNU General Public License.
;-------------------------------------------------------------------------

	.module div
	
;--------------------------------------------------------
; exported symbols
;--------------------------------------------------------
	.globl _div

;--------------------------------------------------------
; local aliases
;--------------------------------------------------------
	.define res "___SDCC_m6502_ret0"
	.define rem "___SDCC_m6502_ret2"
	.define s1  "___SDCC_m6502_ret4"
	.define s2  "___SDCC_m6502_ret5"

;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
	
_div:
	jsr	___sdivmod16
	ldy	*s1
	bpl	rempos
	lda	*rem+0
	ldx	*rem+1
	jsr 	___negax
	sta *rem+0
	stx *rem+1
rempos:
	lda	*res+0
	ldx	*res+1
	pha
	lda	*s1
	eor	*s2
	bpl	pos
	pla
	jmp 	___negax
pos:
	pla
	rts
