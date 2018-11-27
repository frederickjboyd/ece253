.include "address_map_arm.s"
/* 
 * This program demonstrates the use of interrupts using the KEY and timer ports. It
 * 	1. displays a sweeping red light on LEDR, which moves left and right
 * 	2. stops/starts the sweeping motion if KEY3 is presse
 * Both the timer and KEYs are handled via interrupts
*/
.text
.global _start

_start:
			/* Initializing IRQ stack pointer */
			MOV	R0, #0b10010					// Load IRQ mode value into R0
			MSR	CPSR, R0							// Change mode to IRQ
			LDR	SP, =0xFFFFFFFC				// Set stack pointer
			/* Initializing SVC stack pointer */
			MOV	R0, #0b10011					// Load SVC mode value into R0
			MSR	CPSR, R0							// Change mode to SVC
			LDR	SP, =0x3FFFFFFC				// Set stack pointer

			// Configuring GIC, timer, KEYS
			BL	CONFIG_GIC						// Configure the ARM generic interrupt controller
			BL	CONFIG_PRIV_TIMER			// Configure the MPCore private timer
			BL	CONFIG_KEYS						// Configure the pushbutton KEYs
			
			/* Enable ARM processor interrupts */
			MSR	CPSR, #0b00010011			// Change 7th bit to 0 in SVC mode to enable interrupts

			LDR	R6, =0xFF200000				// Red LED base address

MAIN:
			LDR	R4, LEDR_PATTERN			// LEDR pattern; modified by timer ISR
			STR	R4, [R6]							// Write to red LEDs
			B		MAIN

/* Configure the MPCore private timer to create interrupts every 1/10 second */
CONFIG_PRIV_TIMER:
			LDR	R0, =0xFFFEC600				// Timer base address
			LDR	R1, =20000000					// Set timer to 0.1s
			STR	R1, [R0]							// Specify number to count down from
			MOV	R1, #0b111						// I = 1 (enable interrupts), A = 1 (auto-reload), E (start timer)
			STR	R1, [R0, #8]					// Write to control address
			MOV	PC, LR								// Return

/* Configure the KEYS to generate an interrupt */
CONFIG_KEYS:
			LDR	R0, =0xFF200050				// KEYs base address
			MOV	R1, #0b1000						// Look for when KEY3 is pressed
			STR	R1, [R0, #0x8]				// Store in interrupt mask register
			MOV	PC, LR						// Return

			.global	LEDR_DIRECTION
LEDR_DIRECTION:
			.word	0										// 0 for left, 1 for right

			.global	LEDR_PATTERN
LEDR_PATTERN:
			.word	0x1									// Illuminate right-most LED
