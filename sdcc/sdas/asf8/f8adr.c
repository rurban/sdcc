/* f8adr.c */

/*
 *  Copyright (C) 2010  Alan R. Baldwin
 *  Copyright (C) 2022  Philipp K. Krause
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Alan R. Baldwin
 * 721 Berkeley St.
 * Kent, Ohio  44240
 * 
 */

#include "asxxxx.h"
#include "f8.h"

/*
 * Read an address specifier. Pack the
 * address information into the supplied
 * `expr' structure. Return the mode of
 * the address.
 *
 * This addr(esp) routine performs the following addressing decoding:
 *
 *	address		mode		flag	addr	base	mode
 * Direct Modes:
 *	REG		S_REG+rcode	0	0	NULL	0000   0
 *	*label		S_BYTE		----	s_addr	s_area	0001   1
 *	label		S_WORD		----	s_addr	s_area	0010   2
 *	#n		S_IMMED		0	n	NULL	0011   3
 *
 * Indexed Modes:
 *	(offset,REG)	S_IXO+rcode	----	s_addr	s_area	0100   4
 *	(offset,REG).b	S_IXBO+rcode	----	s_addr	s_area	0101   5
 *	(offset,REG).w	S_IXWO+rcode	----	s_addr	s_area	0110   6
 *	(REG)		S_IX+rcode	0	0	NULL	0111   7
 *
 * Indirect Modes:
 *	[label]		S_IN		----	s_addr	s_area	1000   8
 *	[*label]	S_INB		----	s_addr	s_area	1001   9
 *	[label].b	S_INB		----	s_addr	s_area	1001   9
 *	[label].w	S_INW		----	s_addr	s_area	1010  10
 *
 * Indexed with Indirect Offset Modes:
 *	([label],REG)	S_IXIN+rcode	----	s_addr	s_area	1100  12
 *	([*label],REG)	S_IXINB+rcode	----	s_addr	s_area	1101  13
 *	([label],REG).b	S_IXINB+rcode	----	s_addr	s_area	1101  13
 *	([label],REG).w	S_IXINW+rcode	----	s_addr	s_area	1110  14
 */

int rcode;

int
addr(esp)
struct expr *esp;
{
	int c;

	rcode = 0;
	if ((c = getnb()) == '#') {
		expr(esp, 0);
		esp->e_mode = S_IMM;
	} else
	if (c == '(') {
		int d;
		if ((rcode = admode(REG)) != 0) {
		    if ((rcode & 0xff) != Y && (rcode & 0xff) != Z && (rcode & 0xff) != X)
		      aerr ();
			rcode = rcode & 0xff;
			esp->e_mode = S_IX;
			if (getnb() != ')')
				aerr();
		} else if((d = getnb()) == '(') {
			expr(esp, 0);
			comma(1);
			rcode = admode(REG);
			if (rcode & 0xff != SP)
		      aerr ();
			rcode = rcode & 0xff;
			esp->e_mode = S_ISPREL;
			addrsl(esp);
			if (getnb() != ')' || getnb() != ')')
				aerr();
		} else { // Relative addressing
			unget(d);
			expr(esp, 0);
			comma(1);
			if ((rcode = admode(REG)) != 0) {
				rcode = rcode & 0xFF;
			} else {
				aerr();
			}
			if (getnb() != ')') {
				aerr();
			}
			if (rcode == SP)
				esp->e_mode = S_SPREL;
			else if (rcode == Z)
				esp->e_mode = S_ZREL;
			else if (rcode == Y)
				esp->e_mode = S_YREL;
			else
				aerr();
			addrsl(esp);
		}
	} else {
		unget(c);
		if ((rcode = admode(REG)) != 0) {
			rcode = rcode & 0xFF;
			esp->e_mode = S_REG;
		} else {
			expr(esp, 0);
			esp->e_mode = S_DIR;
		}
	}
	return (esp->e_mode);
}

int
addrsl(esp)
struct expr *esp;
{
	int c, d;

	if ((c = getnb()) == '.') {
		d = getnb();
		switch(ccase[d & 0x7F]) {
		case 'b':	esp->e_mode = esp->e_mode | S_SHORT;	break;
		case 'w':	esp->e_mode = esp->e_mode | S_LONG;	break;
		default:	unget(d);	unget(c);		break;
		}
	} else {
		unget(c);
	}
	return (esp->e_mode);
}

/*
 * Enter admode() to search a specific addressing mode table
 * for a match. Return the addressing value on a match or
 * zero for no match.
 */
int
admode(sp)
struct adsym *sp;
{
	char *ptr;
	int i;
	char *ips;

	ips = ip;
	unget(getnb());

	i = 0;
	while ( *(ptr = &sp[i].a_str[0]) ) {
		if (srch(ptr)) {
			return(sp[i].a_val);
		}
		i++;
	}
	ip = ips;
	return(0);
}

/*
 *      srch --- does string match ?
 */
int
srch(str)
char *str;
{
	char *ptr;
	ptr = ip;

	while (*ptr && *str) {
		if (ccase[*ptr & 0x007F] != ccase[*str & 0x007F])
			break;
		ptr++;
		str++;
	}
	if (ccase[*ptr & 0x007F] == ccase[*str & 0x007F]) {
		ip = ptr;
		return(1);
	}

	if (!*str) {
		if (!(ctype[*ptr & 0x007F] & LTR16)) {
			ip = ptr;
			return(1);
		}
	}
	return(0);
}

/*
 * Registers
 */

struct	adsym	REG[] = {
    {	"xl",	XL|0400	},
    {	"xh",	XH|0400	},
    {	"yl",	YL|0400	},
    {	"yh",	YH|0400	},
    {	"zl",	ZL|0400	},
    {	"zh",	ZH|0400	},
    {	"f",	F|0400	},
    {	"sp",	SP|0400	},
    {	"x",	X|0400	},
    {	"y",	Y|0400	},
    {	"z",	Z|0400	},
    {	"",	0000	}
};


