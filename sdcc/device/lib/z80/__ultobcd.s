;--------------------------------------------------------------------------
;  __ultobcd.s
;
;  Copyright (C) 2020-2021, Sergey Belyashov
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

	.module __ultobcd
	.optsdcc -mz80 sdcccall(1)

	.area   _CODE

	.globl ___ultobcd
;
; void __ultobcd (unsigned long v, unsigned char bcd[5])
; __ultobcd converts v to BCD representation to the bcd.
; bcd[] will contain BCD value.
;
___ultobcd:
	pop	af
	pop	bc
	push	af
	push	bc
	push	ix
	ld	ix, #0
	add	ix, sp
;	ld	sp, ix		; sp already equals ix
;
	ld	bc, #0x2000
;
;--- begin speed optimization
;
	ld	a, l
	or	a, h
	jr	NZ, 101$
;high 2 bytes are zero
	ld	b, #0x10
	ex	de, hl
101$:
	ld	a, h
	or	a, a
	jr	NZ, 102$
;high byte is zero
	ld	h, l
	ld	l, d
	ld	d, e
	ld	a, #-8
	add	a, b
	ld	b, a
102$:
	push	hl
	push	de
;
;--- end speed optimization
;
	ld	hl, #0x0000
	ld	e, l
	ld	d, h
; (ix+0)..(ix+3) - binary value
; CDEHL - future BCD value
; B - bits count (32)
103$:
	sla	-4 (ix)
	rl	-3 (ix)
	rl	-2 (ix)
	rl	-1 (ix)
	ld	a, l
	adc	a, a
	daa
	ld	l, a
	ld	a, h
	adc	a, a
	daa
	ld	h, a
	ld	a, e
	adc	a, a
	daa
	ld	e, a
	ld	a, d
	adc	a, a
	daa
	ld	d, a
	ld	a, c
	adc	a, a
	daa
	ld	c, a
	djnz	103$
;
	ld	b, l
	ld	a, h
	ld	sp, ix
	pop	ix
	pop	hl
	ld	(hl), b
	inc	hl
	ld	(hl), a
	inc	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), c
;
	ret
