		.text
		.global 	_start
_start:
		LDR 		R7, =TEST_NUM 	// address of the first word '10'
		MOV		R2, #0			// whether swapped or not through the list (0 if no swap)
		LDR 		R6, =TEST_NUM	// address of the first word '10'
        		MOV 		R1, #0			// counter initially set to 0
		
        
MAIN: 	MOV		R8, #0
		MOV		R11, #0
		LDR		R8, [R6]	// load the first word “10” 
		SUB		R8, #1		// —> num of loops in a list ‘9’
		CMP 		R8, R1		// compare whether we looped the entire list 9 times
		BEQ		CHECK_SWAPPED
		MOV 		R11, #4
        		MUL 		R12, R1, R11	// Multiply 4 by element counter to find address of current element
        		ADD		R5, R6, #4		// address of the first word after word count
       		 LDR 		R0, [R5, R12]	// 
		ADD 		R1, #1			// Increase current element counter by 1
        		ADD 		R0, R7, #4
        		B 		SWAP
END:  		B		END

// SWAP Subroutine
SWAP:	ADD		R3, R0, #4
        		LDR		R8, [R3]
        		LDR 		R10, [R0]
        		CMP 		R10, R8 		// R0 - R3 >= 0 —> (need swap if false)
		BPL		L_END		// keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
        		STR 		R8, [R0] 		// Temporary register for the next value
        		STR 		R10, [R3]		// Swapping R3 and R0
        		MOV 		R0, #1			// Overwriting R0 = 1 (“Swap is performed”) 
		ORR 		R2, R0		// Or-ing the swapped status to the general status of the list
		B		S_END
L_END: 	MOV		R0, #0			// “Swap is not performed”
S_END:	ADD 		R7, #4
        		MOV 		R0, R7
		B		MAIN 			// Return

CHECK_SWAPPED:	CMP 		R2, #0		// Check if any elements have been swapped
				BEQ 		END			// If yes, stop executing program
				MOV 		R2, #0		// Reset swap
				MOV 		R1, #0		// Reset current element counter
				MOV		R7, R6
                			B 		MAIN

TEST_NUM:  	.word 0xa
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
           		//.word 0x600
           		//.word 0x700
    			.end
    




////////////////////////////////////////////////////////////////////////////
		.text
		.global 	_start
_start:
		LDR 	R7, =TEST_NUM 	// address of the first word '10'
		MOV		R2, #0			// whether swapped or not through the list (0 if no swap)
		LDR 	R6, =TEST_NUM	// address of the first word '10'
        MOV 	R1, #0			// counter initially set to 0
		//ADD		R7, #4			// incrementing address
		LDR		R0, [R7, #4]		// value of the first element to compare (want it to be 0 until the end to be fully swapped)
        
MAIN: 	MOV		R8, #0
		MOV		R11, #0
		LDR		R8, [R6]	// load the first word “10” 
		SUB		R8, #1		// —> num of loops in a list ‘9’
		CMP 	R8, R1		// compare whether we looped the entire list 9 times
		BEQ		CHECK_SWAPPED
		MOV 	R11, #4
        MUL 	R12, R1, R11	// Multiply 4 by element counter to find address of current element
		//LDR 	R11, [R6, #4]	// stores the first word value after the word count
        //MOV 	R3, #0
        MOV 	R5, #0
        ADD		R5, R6, #4		// address of the first word after word count
        LDR 	R0, [R5, R12]	// 
        //LDR		R0, R3		// adding values to get value of the element
		ADD 	R1, #1			// Increase current element counter by 1
		ADD		R7, #4	// seeing R0
        BL 		SWAP
		B		MAIN
END:  	B		END

// SWAP Subroutine
SWAP:
        LDR 	R3, [R7, #4]	// Getting the next value from the list
		CMP 	R0, R3 		// R0 - R3 >= 0 —> (need swap if false)
		BPL		L_END		// keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
		//MOV		R8, #0
        STR 	R3, [R5] // Temporary register for the next value
		//MOV		R3, #0
        STR 	R0, [R3]	// Swapping R3 and R0
        //MOV 	R11, #0
        ADD		R11, R12, R6
		STR		R5, [R11]				
		MOV 	R0, #1		// Overwriting R0 = 1 (“Swap is performed”) 
		ORR 	R2, R0		// Or-ing the swapped status to the general status of the list
		B		S_END
L_END: 	MOV		R0, #0		// “Swap is not performed”
S_END:	MOV 	PC, LR 		// Return

CHECK_SWAPPED:	CMP 	R2, #0		// Check if any elements have been swapped
				BEQ 	END			// If yes, stop executing program
				MOV 	R2, #0		// Reset swap
				MOV 	R1, #0		// Reset current element counter
				B 		MAIN

TEST_NUM:  .word 0xa
		   .word 0x578
           .word 0x3
           .word 0x2d
           .word 0x4
           .word 0x5
           .word 0x2
           .word 0x32
           .word 0x33
           .word 0x34
           .word 0x35
           
    .end
//.word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33








///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		.text
		.global 	_start
_start:
		LDR 	R7, =TEST_NUM 	// address of the first word '10'
		MOV		R2, #0			// whether swapped or not through the list (0 if no swap)
		LDR 	R6, =TEST_NUM	// address of the first word '10'
        MOV 	R1, #0			// counter initially set to 0
		//ADD		R7, #4			// incrementing address
		LDR		R0, [R7, #4]		// value of the first element to compare (want it to be 0 until the end to be fully swapped)

MAIN: 	LDR		R8, [R6]		// load the first word “10” 
		SUB		R8, #1			// —> num of loops in a list ‘9’
		CMP 	R8, R1		// compare whether we looped the entire list 9 times
		BEQ		CHECK_SWAPPED	
		MOV 	R11, #4
        MUL 	R12, R1, R11		// Multiply 4 by element counter to find address of current element
		ADD		R0, R6, R12		// 
		ADD 	R1, #1			// Increase current element counter by 1
		BL 		SWAP
		B	MAIN
END:  	B	END

// SWAP Subroutine
SWAP:	LDR 	R3, [R7, #4]	// Getting the next value from the list
		CMP 	R0, R3 		// R0 - R3 >= 0 —> (need swap if false)
		BPL		L_END		// keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
		MOV		R8, #0
        STR 	R3, [R8]	// Temporary register for the next value
		STR 	R0, [R3]	// Swapping R3 and R0
        MOV 	R11, #0
        ADD		R11, R12, R6
		STR		R8, [R11]				
		MOV 	R0, #1		// Overwriting R0 = 1 (“Swap is performed”) 
		ORR 	R2, R0		// Or-ing the swapped status to the general status of the list
		B		S_END
L_END: 	MOV		R0, #0			// “Swap is not performed”
S_END:	MOV 	PC, LR 		// Return

CHECK_SWAPPED:	CMP 	R2, #0			// Check if any elements have been swapped
				BEQ 	END			// If yes, stop executing program
				MOV 	R2, #0			// Reset swap
				MOV 	R1, #0			// Reset current element counter
				B 		MAIN

TEST_NUM:  .word 0xa
		   .word 0x578
		   .word 0x2d
           .word 0x3
           .word 0x4
           .word 0x5
           .word 0x2
           .word 0x32
           .word 0x33
           .word 0x34
           .word 0x35
           
    .end



//////////////////////////////////////////////////////////////////////////////////////////////////////////
		.text
		.global 	_start
_start:
		LDR 	R4, =TEST_NUM 	// load the list of numbers into R4 
		LDR		R8, [R4]		// load the first word “10” 
		SUB		R8, #1			// —> num of loops in a list ‘9’
		MOV		R2, #0			// whether swapped or not through the list (0 if no swap)
		LDR 	R6, =TEST_NUM		// Storing address of the first element of the list address ‘1400’
		MOV 	R11, #4	
        MOV 	R1, #1			// counter initially set to 0
		ADD		R4, #4
		LDR		R0, [R4]		// value of the first element to compare (want it to be 0 until the end to be fully swapped)

MAIN: 	CMP 	R8, R1		// compare whether we looped the entire list 9 times
		BEQ		CHECK_SWAPPED	
		MUL 	R12, R1, R11		// Multiply 4 by element counter to find address of current element
		ADD		R0, R6, R12		// 
		ADD 	R1, #1			// Increase current element counter by 1
		BL 		SWAP

END:  	B	END

// SWAP Subroutine
SWAP:	ADD 	R4, #4
		LDR 	R3, [R4]		// Getting the next value from the list
		CMP 	R0, R3 		// R0 - R3 >= 0 —> (need swap if false)
		BPL		L_END		// keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
		STR 	R3, [R7]		// Temporary register for the next value
		STR 	R0, [R3]		// Swapping R3 and R0
		STR		R7, [R6]				
		MOV 	R0, #1			// Overwriting R0 = 1 (“Swap is performed”) 
		ORR 	R2, R0		// Or-ing the swapped status to the general status of the list
		CMP 	R0, #0			// Trying to jump to end
		BPL		S_END		// Go to S_END if R0 - 1 is true
L_END: 	MOV		R0, #0			// “Swap is not performed”
S_END:	MOV 	PC, LR 		// Return

CHECK_SWAPPED:	CMP 	R2, #0			// Check if any elements have been swapped
				BEQ 	END			// If yes, stop executing program
				MOV 	R2, #0			// Reset swap
				MOV 	R1, #0			// Reset current element counter
				B 		MAIN

TEST_NUM:  .word 0xa
		   .word 0x578
		   .word 0x2d
           .word 0x3
           .word 0x4
           .word 0x5
           .word 0x2
           .word 0x32
           .word 0x33
           .word 0x34
           .word 0x35
           
    .end




//////////////////////////////////////////////////////////////////////////////////////////
		.text
		.global 	_start
_start:
		LDR 	R13, =TEST_NUM 	// load the list of numbers into R4 
		LDR		R8, [R13]		// load the first word “10” 
		SUB		R8, #1			// —> num of loops in a list ‘9’
        MOV 	R1, #1			// counter initially set to 0
		ADD		R13, #4
		LDR		R0, [R13]		// value of the first element to compare (want it to be 0 until the end to be fully swapped)
		MOV		R2, #0			// whether swapped or not through the list (0 if no swap)
		LDR 	R6, =TEST_NUM		// Storing address of the first element of the list address ‘1400’
		MOV 	R11, #4	
    
MAIN: 	CMP 	R8, R1		// compare whether we looped the entire list 9 times
		BEQ		CHECK_SWAPPED	
		MUL 	R12, R1, R11		// Multiply 4 by element counter to find address of current element
		ADD		R0, R6, R12		// 
		ADD 	R1, #1			// Increase current element counter by 1
		BL 		SWAP

END:  	B	END

// SWAP Subroutine
SWAP:	ADD 	R13, #4
		LDR 	R3, [R4]		// Getting the next value from the list
		CMP 	R0, R3 		// R0 - R3 >= 0 —> (need swap if false)
		BPL		L_END		// keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
		STR 	R3, [R7]		// Temporary register for the next value
		STR 	R0, [R3]		// Swapping R3 and R0
		STR		R7, [R6]				
		MOV 	R0, #1			// Overwriting R0 = 1 (“Swap is performed”) 
		ORR 	R2, R0		// Or-ing the swapped status to the general status of the list
		CMP 	R0, #0			// Trying to jump to end
		BPL		S_END		// Go to S_END if R0 - 1 is true
L_END: 	MOV		R0, #0			// “Swap is not performed”
S_END:	MOV 	PC, LR 		// Return

CHECK_SWAPPED:	CMP 	R2, #0			// Check if any elements have been swapped
				BEQ 	END			// If yes, stop executing program
				MOV 	R2, #0			// Reset swap
				MOV 	R1, #0			// Reset current element counter
				B 		MAIN

TEST_NUM:  .word 0xa
		   .word 0x578
		   .word 0x2d
           .word 0x3
           .word 0x4
           .word 0x5
           .word 0x2
           .word 0x32
           .word 0x33
           .word 0x34
           .word 0x35
           
    .end





////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		.text
		.global 	_start
_start:
		LDR 	R13, =TEST_NUM 	// load the list of numbers into R4 
		LDR		R5, [R0]		// load the first word “10” 
		SUB		R5, R5, #1			// —> num of loops in a list ‘9’
		MOV 	R1, #0			// counter initially set to 0
		ADD		R13, #4
		LDR		R0, [R13]		// value of the first element to compare (want it to be 0 until the end to be fully swapped)
		MOV		R2, #0			// whether swapped or not through the list (0 if no swap)
		LDR 	R6, =TEST_NUM		// Storing address of the first element of the list address ‘1400’
		MOV 	R11, #4	
    
MAIN: 	CMP 	R5, R1		// compare whether we looped the entire list 9 times
		BEQ		CHECK_SWAPPED	
		MUL 	R12, R1, R11		// Multiply 4 by element counter to find address of current element
		ADD		R0, R6, R12		// 
		ADD 	R1, #1			// Increase current element counter by 1
		BL 		SWAP

END:  	B	END

// SWAP Subroutine
SWAP:	ADD 	R13, #4
		LDR 	R3, [R4]		// Getting the next value from the list
		CMP 	R0, R3 		// R0 - R3 >= 0 —> (need swap if false)
		BPL		L_END		// keep the order of R0 and R3 as is (change R0 to 0 and exit SWAP)
		STR 	R3, [R7]		// Temporary register for the next value
		STR 	R0, [R3]		// Swapping R3 and R0
		STR		R7, [R6]				
		MOV 	R0, #1			// Overwriting R0 = 1 (“Swap is performed”) 
		ORR 	R2, R0		// Or-ing the swapped status to the general status of the list
		CMP 	R0, #0			// Trying to jump to end
		BPL		S_END		// Go to S_END if R0 - 1 is true
L_END: 	MOV		R0, #0			// “Swap is not performed”
S_END:	MOV 	PC, LR 		// Return

CHECK_SWAPPED:	CMP 	R2, #0			// Check if any elements have been swapped
				BEQ 	END			// If yes, stop executing program
				MOV 	R2, #0			// Reset swap
				MOV 	R1, #0			// Reset current element counter
				B 		MAIN

TEST_NUM: 		.word 	10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
