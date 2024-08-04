/*-------------------------------------------------------------------------
  gen.h - header file for code generation for f8

             Written By -  Philipp Krause . pkk@spth.de (2021)

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the
   Free Software Foundation; either version 2, or (at your option) any
   later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
-------------------------------------------------------------------------*/

#ifndef STM8GEN_H
#define STM8GEN_H 1

#include "ralloc.h"

typedef enum
{
  AOP_INVALID,
  /* Is a literal */
  AOP_LIT = 1,
  /* Is partially in registers or on the stack */
  AOP_REGSTK,
  /* Is on the stack */
  AOP_STK,
  /* Is a stack location */
  AOP_STL,
  /* Is an immediate value */
  AOP_IMMD,
  /* Is in direct space */
  AOP_DIR,
  /* Read undefined, discard writes */
  AOP_DUMMY,
  /* Has been optimized out by jumping directly (see ifxForOp) */
  AOP_CND
}
AOP_TYPE;

/* asmop_byte: A type for the location a single byte
   of an operand can be in */
typedef struct asmop_byte
{
  bool in_reg;
  union
  {
    reg_info *reg;    /* Register this byte is in. */
    long int stk; /* Stack offset for this byte. */
  } byteu;
} asmop_byte;

/* asmop: A homogenised type for all the different
   spaces an operand can be in */
typedef struct asmop
{
  AOP_TYPE type;
  short size;
  union
  {
    value *aop_lit;
    struct
      {
        char *immd;
        int immd_off;
      };
    int stk_off;
    char *aop_dir;
    asmop_byte bytes[8];
  } aopu;
  signed char regs[C_IDX + 1]; // Byte of this aop that is in the register. -1 if no byte of this aop is in the reg.
  struct valinfo valinfo;
}
asmop;

void genF8Code (iCode *);
void f8_emitDebuggerSymbol (const char *);

bool f8IsReturned(const char *what);

// Check if what is part of the ith argument (counting from 1) to a function of type ftype.
// If what is 0, just check if hte ith argument is in registers.
bool f8IsRegArg(struct sym_link *ftype, int i, const char *what);

// Check if what is part of the any argument (counting from 1) to a function of type ftype.
bool f8IsParmInCall(sym_link *ftype, const char *what);

extern bool f8_assignment_optimal;
extern long int f8_call_stack_size;
extern bool f8_extend_stack;

#endif

