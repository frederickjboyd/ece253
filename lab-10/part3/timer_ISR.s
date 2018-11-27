.include	"address_map_arm.s"
.extern		LEDR_DIRECTION
.extern		LEDR_PATTERN

/*****************************************************************************
 * MPCORE Private Timer - Interrupt Service Routine
 *
 * Shifts the pattern being displayed on the LEDR
 * 
******************************************************************************/
.global PRIV_TIMER_ISR
PRIV_TIMER_ISR:
				LDR		R0, =MPCORE_PRIV_TIMER	// Base address of timer
				MOV		R1, #1
				STR		R1, [R0, #0xC]					// Write 1 to F bit to reset it and clear 
																			// the interrupt

/*
 * Rotate the LEDR bits either to the left or right. Reverses direction when hitting 
 * position 9 on the left, or position 0 on the right
 */
SWEEP:
				LDR		R0, =LEDR_DIRECTION			// Put shifting direction into R2
				LDR		R2, [R0]
				LDR		R1, =LEDR_PATTERN				// Put LEDR pattern into R3
				LDR		R3, [R1]
				CMP		R2, #0									// Checks if direction if left
				BEQ		SHIFTL									// If left, branch to left subroutine
				B			SHIFTR									// Otherwise, branch to right subroutine

SHIFTL:
				ROR	R3, #31										// Shift left (shift right 31 bits)
				CMP	R3, #0x200								// Check if left-most LED is lit up
				BNE	DONE_SWEEP								// If left-most LED is not lit up, start to wrap up
L_R:
				MOV	R2, #1										// change direction to right
				B		DONE_SWEEP

SHIFTR:	ROR	R3, #1										// Shift right (shift right 1 bit)
				CMP	R3, #0x1									// Check if right-most LED is lit up
				BNE	DONE_SWEEP
R_L:
				MOV	R2, #0										// Change direction to left
				B		DONE_SWEEP

DONE_SWEEP:
				STR		R2, [R0]								// Put shifting direction back into memory
				STR		R3, [R1]								// Put LEDR pattern back onto stack
	
END_TIMER_ISR:
				MOV		PC, LR
