/* Program that counts consecutive 1’s */
.text
.global _start
_start:   LDR R4, =TEST_NUM // Load the data word into R1
          MOV R5, #0 // R0 will hold the result

MAIN:     LDR R1, [R4]
          ADD R4, #4
          CMP R1, #0
          BEQ MAIN_END
          BL ONES
          CMP R5, R0
          MOVLT R5, R0
          B MAIN

MAIN_END: B MAIN_END

ONES:     MOV R0, #0
L_LOOP:   CMP R1, #0
          BEQ L_END
          LSR R2, R1, #1
          AND R1, R2, R1
          ADD R0, #1
          B L_LOOP
L_END:    MOV PC, LR // Return

TEST_NUM: .word 0x103fe00f // 0001 0000 0011 1111 1110 0000 0000 1111
          .word 0x12345678 // 0001 0010 0011 0100 0101 0110 0111 1000
          .word 0x89ABCDEF // 1000 1001 1010 1011 1100 1101 1110 1111
          .word 0x122d9561 // 0001 0010 0010 1101 1001 0101 0110 0001
          .word 0xca526d2a // 1100 1010 0101 0010 0110 1101 0010 1010
          .word 0x9f0cb7f4 // 1001 1111 0000 1100 1011 0111 1111 0100
          .word 0xbb437342 // 1011 1011 0100 0011 0111 0011 0100 0010
          .word 0xFFFFFFFF // 1111 1111 1111 1111 1111 1111 1111 1111
          .word 0x00000000 // 0000

.end
