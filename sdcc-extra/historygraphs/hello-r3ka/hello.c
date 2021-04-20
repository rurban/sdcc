// Source by Philipp Krause under CC0 1.0

// A "Hello, World!"-Program. We use it to make the board
// output something that can not be mistaken for output
// From a benchmark.

// "Hello, world!" on serial port A @ 38400 baud.

#include <stdint.h>
#include <stdio.h>

#include "r3ka.h"

// _sdcc_external_startup, if present, will be called very early, before initalization
// of global objects. This makes it e.g. useful for dealing with watchdogs that might
// otherwise bite if there are many or large global objects that take a long time to initialize.
void _sdcc_external_startup(void)
{
	// Disable watchdog
	WDTTR = 0x51;
	WDTTR = 0x54;

	// normal oscillator, processor and peripheral from main clock, no periodic interrupt
	GCSR = 0x08;
}

int putchar(int c)
{
	while (SASR & 0x04);	// Wait for empty transmitter data register
	SADR = c;
	return c;
}

void main(void)
{
	PCFR = 0x40;	// Use pin PC6 as TXA

	TAT4R = 18 - 1;	// Value in register is one less than the divider used (e.g. a value of 0 will result in clock division by 1).
	TACSR = 0x01;	// Enable timer A

	SACR = 0x00;	// No interrupts, 8-bit async mode

	for (;;) {
		printf("Hello, World!\n");
		printf ("\x04");
	}
}

