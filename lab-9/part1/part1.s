/* Bubble sort, implemented in Assembly */

.text
.global	_start

_start:
				LDR		R7, =TEST_NUM		// Address of the first word '10'
				MOV		R2, #0					// Whether swapped or not through the list (0 if no swap)
				LDR		R6, =TEST_NUM		// Address of the first word '10'
				MOV 	R1, #0					// Counter initially set to 0

MAIN:
				MOV		R8, #0
				MOV		R11, #0
				LDR		R8, [R6]				// Load the first word (number of items in list)
				SUB		R8, #1					// Number of loops in a list
				CMP		R8, R1					// Compare whether we looped the entire list
				BEQ		CHECK_SWAPPED
				MOV		R11, #4
				MUL		R12, R1, R11		// Multiply 4 by element counter to find address of current element
				ADD		R5, R6, #4			// Address of the first word after word count
				LDR		R0, [R5, R12]		// Access current element
				ADD		R1, #1					// Increase current element counter by 1
				ADD		R0, R7, #4
				B			SWAP
END:
				B			END

/* SWAP Subroutine */
SWAP:
				ADD		R3, R0, #4
				LDR		R8, [R3]
				LDR		R10, [R0]
				CMP		R10, R8					// R0 - R3 >= 0 -> (need swap if false)
				BPL		L_END						// Keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
				STR		R8, [R0]				// Temporary register for the next value
				STR		R10, [R3]				// Swapping R3 and R0
				MOV		R0, #1					// Overwriting R0 = 1 ("Swap is performed") 
				ORR		R2, R0					// Or-ing the swapped status to the general status of the list
				B			S_END
L_END:
				MOV		R0, #0					// "Swap is not performed"
S_END:
				ADD		R7, #4
				MOV		R0, R7
				B			MAIN						// Return back to MAIN

CHECK_SWAPPED:
				CMP		R2, #0					// Check if any elements have been swapped
				BEQ		END							// If yes, stop executing program
				MOV		R2, #0					// Reset swap
				MOV		R1, #0					// Reset current element counter
				MOV		R7, R6
				B			MAIN

TEST_NUM:
				.word 0xC				// Number of words in list
				.word 0x3
				.word 0x578
				.word 0x2d
				.word 0x4
				.word 0x5
				.word 0x2
				.word 0x32
				.word 0x33
				.word 0x34
				.word 0x35 
				.word 0x600
				.word 0x700

.end
