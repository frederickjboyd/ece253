/***************************************************************************************
 * Pushbutton - Interrupt Service Routine                                
 *                                                                          
 * This routine checks which KEY has been pressed.  If KEY3 it stops/starts the timer.
****************************************************************************************/
.global	KEY_ISR
.include "address_map_arm.s"

KEY_ISR:
					LDR		R0, =KEY_BASE						// Base address of KEYs parallel port
					LDR		R1, [R0, #0xC]					// Read edge capture register
					STR		R1, [R0, #0xC]					// Clear the interrupt

CHK_KEY3:
					TST		R1, #0b1000							// Check if KEY3 has been pressed
					BEQ		END_KEY_ISR							// If equal, then KEY3 has not been pressed

START_STOP:
					LDR		R0, =MPCORE_PRIV_TIMER	// Timer base address
					LDR		R1, [R0, #0x8]					// Read timer control register
					MOV		R2, #1									// Move 1 into R3
					EOR		R1, R2									// EOR the enable bit with 1 to flip it
					STR		R1, [R0, #0x8]					// Store enable bit to control register 
																				// to start/stop the timer (E)

END_KEY_ISR:
					MOV		PC, LR

.end
