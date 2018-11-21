/* Program that finds longest string of 1s, 0s, and alternating 1s & 0s */
.text
.global _start

_start:     LDR R4, =TEST_NUM // Load the data word into R1
            MOV R5, #0 // Result for counting 1s
            MOV R6, #0 // Result for counting 0s
            MOV R7, #0 // Result for counting alternating 1s and 0s
            MOV R11, #0 // Initializing R11 to 0

MAIN:       LDR R1, [R4] // Test numbers for 1s
            LDR R3, [R4] // Test numbers for 0s
            LDR R10, [R4] // Test numbers for alternating 1s and 0s
            LDR R11, =0xAAAAAAAA
            ADD R4, #4
            CMP R1, #0
            BEQ MAIN_END
            BL ONES
            CMP R5, R0 // Final count for 1s
            MOVLT R5, R0 // Replace R5 if R0 > R5
            BL ZEROS
            CMP R6, R0 // Final count for 0s
            MOVLT R6, R0 // Replace R6 if R0 > R6
            BL ALTERNATE
            CMP R7, R12 // Final count for alternate
            MOVLT R7, R12 // Replace R6 if R0 > R7
            B MAIN
MAIN_END:   B MAIN_END

ONES:       MOV R0, #0
L1_LOOP:    CMP R1, #0
            BEQ L1_END
            LSR R2, R1, #1
            AND R1, R2, R1
            ADD R0, #1
            B L1_LOOP
L1_END:     MOV PC, LR // Return

ZEROS:      MOV R0, #0
L2_LOOP:    CMP R3, #0xFFFFFFFF
            BEQ L2_END
            LSR R2, R3, #1
            ADD R2, #0x80000000
            ORR R3, R2, R3
            ADD R0, #1
            B L2_LOOP
L2_END:     MOV PC, LR // Return

ALTERNATE:  MOV R0, #0 // Initialize 1s counter to 0
            EOR R1, R10, R11 // XOR for 1s
            EOR R3, R10, R11 // XOR for 0s
ONES_LOOP:  CMP R1, #0
            BEQ MIDPOINT
            LSR R2, R1, #1
            AND R1, R2, R1
            ADD R0, #1
            B ONES_LOOP
MIDPOINT:   MOV R12, R0 // Return
            MOV R0, #0 // Reset R0
ZEROS_LOOP: CMP R3, #0xFFFFFFFF
            BEQ COMPARE
            LSR R2, R3, #1
            ADD R2, #0x80000000
            ORR R3, R2, R3
            ADD R0, #1
            B ZEROS_LOOP
COMPARE:    CMP R12, R0 // Compare longest 1s with longest 0s
            MOVLT R12, R0 // Replace R12 with R0 if R0 > R12
            MOV PC, LR

TEST_NUM:   .word 0x00000AAA // 0000 0000 0000 0000 0000 1010 1010 1010
            .word 0x0000000F // 0000 0000 0000 0000 0000 0000 0000 1111
            .word 0x00000000 // 0000 0000 0000 0000 0000 0000 0000 0000

.end
