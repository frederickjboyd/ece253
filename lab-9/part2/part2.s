.text
.global _start

_start:			LDR		R1, =0xFF200000 // LEDR port
				LDR		R2, =0xFF200050 // KEYS
				LDR		R8, =0xFFFEC600 // Points to timer
            	LDR		R0, =200000000	// Delay
            	MOV		R3, #0			// Keeps track of direction (0 is left, 1 is right)
            	STR		R0, [R8]		// Load values =R0
            	MOV		R0, #0b011		// A = 1, E = 1, I = 0
            	STR		R0, [R8, #8]	// Set control values
				MOV		R6, #0x00000001 // Initial pattern - LED0 lit up
            	MOV		R5, #0x00000001	// 0 - pause, 1 - play
			
DISPLAY:		STR		R6, [R1]		// Display R6 on LEDs

ROTATE:			CMP		R3, #0			// Check direction
				BLEQ	ROT_LEFT		// Branch if left rotation
				CMP		R3, #0			// Check direction again
            	BLNE	ROT_RIGHT		// Branch if right direction
ROT_LEFT:		CMP		R6, #0x00000100	// Check if left most LED is lit up
				MOVEQ	R3, #1			// If left most LED is lit, change direction
            	LSL		R6, #1			// Rotate left
            	B		DELAY_1
ROT_RIGHT:		CMP		R6, #0x00000002	// Check if right most LED is lit up
				MOVEQ	R3, #0			// If right most LED is lit, change direction
            	ROR		R6, #1			// Rotate right
            	B		DELAY_1

DELAY_1:		LDR		R7, [R2]		// Read KEYS
				CMP 	R7, #0x00000008	// Check if KEY3 is pressed
            	BEQ		KEY_PRESS_1		// Branch to KEY_PRESS_1
DELAY_2:		LDR		R0, [R8, #0xC]	// R0 = interrupt status register
				CMP		R0, #0			// Check F == 0
            	BEQ		DELAY_1			// Keep delaying if F is not 0
            	STR		R0, [R8, #0xC]	// Writing to interrupt status register to reset it
            	B		DISPLAY
/* FIRST BUTTON PRESS - PAUSES LEDS */
KEY_PRESS_1:	LDR		R7, [R2]		// Read KEYS
				CMP		R7, #0x00000000	// Check if KEYS have been released
            	BEQ		KEY_RELEASE_1	// If yes, branch to KEY_RELEASE_1
                B		KEY_PRESS_1		// Keep looping if KEYS have not been released
KEY_RELEASE_1:	LDR		R7, [R2]		// Read KEYS
				CMP		R7, #0x00000008	// Check if KEY3 has been pressed
                BEQ		KEY_PRESS_2		// If yes, branch to KEY_PRESS_2
                B		KEY_RELEASE_1	// Keep looping if KEY3 has not been released
/* SECOND BUTTON PRESS - PLAYS LEDS */
KEY_PRESS_2:	LDR		R7, [R2]		// Read KEYS
				CMP		R7, #0x00000000 // Check if KEYS have been released
                BEQ		DELAY_2			// If yes, jump back to original delay block
                B		KEY_PRESS_2		// Keep looping if KEYS have not been released
