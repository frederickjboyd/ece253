.include	"address_map_arm.s"
.include	"defines.s"
.include	"interrupt_ID.s"

/* 
 * This file:
 * 1. defines exception vectors for the A9 processor
 * 2. provides code that initializes the generic interrupt controller
 */

/*********************************************************************************
 * Initialize the exception vector table
 ********************************************************************************/
.section .vectors, "ax"

				B				_start						// Reset vector
				B				SERVICE_UND				// Undefined instruction vector
				B				SERVICE_SVC				// Software interrrupt vector
				B				SERVICE_ABT_INST	// aborted prefetch vector
				B				SERVICE_ABT_DATA	// aborted data vector
				.word		0									// Unused vector
				B				SERVICE_IRQ				// IRQ interrupt vector
				B				SERVICE_FIQ				// FIQ interrupt vector

.text
/*--- IRQ ---------------------------------------------------------------------*/
.global	SERVICE_IRQ

SERVICE_IRQ:
/*
 * Save R0-R3, because subroutines called from here might modify
 * these registers without saving/restoring them. Save R4, R5
 * because we modify them in this subroutine
 */
					PUSH		{R0-R5, LR}
					/* Read the ICCIAR from the CPU interface */
					LDR			R4,	=MPCORE_GIC_CPUIF
					LDR			R5,	[R4, #ICCIAR]						// Read the interrupt ID - stores 
																							// ID of device that caused interrupt

PRIV_TIMER_CHECK:
					CMP			R5, #MPCORE_PRIV_TIMER_IRQ	// Compare interrupt ID to 29
					BNE			KEYS_CHECK									// If timer didn't cause interrupt, check keys
					BL			PRIV_TIMER_ISR							// If timer, go to timer ISR
					B				EXIT_IRQ

KEYS_CHECK:
					CMP			R5, #KEYS_IRQ
UNEXPECTED:
					BNE			UNEXPECTED
					BL			KEY_ISR

EXIT_IRQ:
					/* Write to the End of Interrupt Register (ICCEOIR) */
					// Lets processor know when it has completed handling the interrupt
					STR			R5, [R4, #ICCEOIR]
					POP			{R0-R5, LR}
					SUBS		PC, LR, #4									// Return from interrupt


/*--- Undefined instructions --------------------------------------------------*/
.global SERVICE_UND
SERVICE_UND:
					B				SERVICE_UND
 
/*--- Software interrupts -----------------------------------------------------*/
.global SERVICE_SVC
SERVICE_SVC:
					B				SERVICE_SVC 

/*--- Aborted data reads ------------------------------------------------------*/
.global SERVICE_ABT_DATA
SERVICE_ABT_DATA:
					B				SERVICE_ABT_DATA 

/*--- Aborted instruction fetch -----------------------------------------------*/
				.global	SERVICE_ABT_INST
SERVICE_ABT_INST:
					B				SERVICE_ABT_INST 
 
/*--- FIQ ---------------------------------------------------------------------*/
.global SERVICE_FIQ
SERVICE_FIQ:
					B				SERVICE_FIQ 

/* 
 * Configure the Generic Interrupt Controller (GIC)
 */
.global CONFIG_GIC
CONFIG_GIC:
					PUSH		{LR}
					/* 
					 * Configure the A9 Private Timer interrupt and FPGA KEYs
					 * CONFIG_INTERRUPT (int_ID (R0), CPU_target (R1));
					 */
					MOV			R0, #MPCORE_PRIV_TIMER_IRQ
					MOV			R1, #CPU0
					BL			CONFIG_INTERRUPT
					MOV			R0, #KEYS_IRQ
					MOV			R1, #CPU0
					BL			CONFIG_INTERRUPT

					/* Configure the GIC CPU interface */
					LDR			R0, =0xFFFEC100		// Base address of CPU interface
					/* Set Interrupt Priority Mask Register (ICCPMR) */
					LDR			R1, =0xFFFF				// Enable interrupts of all priorities levels
					STR			R1, [R0, #0x04]
					/* 
					 * Set the enable bit in the CPU Interface Control Register (ICCICR). 
					 * This bit allows interrupts to be forwarded to the CPU(s)
					 */
					MOV			R1, #1
					STR			R1, [R0]

					/* 
					 * Set the enable bit in the Distributor Control Register (ICDDCR). This bit
					 * allows the distributor to forward interrupts to the CPU interface(s)
					 */
					LDR			R0, =0xFFFED000
					STR			R1, [R0]

					POP			{PC}
/* 
 * Configure registers in the GIC for an individual interrupt ID
 * We configure only the Interrupt Set Enable Registers (ICDISERn) and Interrupt 
 * Processor Target Registers (ICDIPTRn). The default (reset) values are used for 
 * other registers in the GIC
 * Arguments: R0 = interrupt ID, N
 *            R1 = CPU target
 */
CONFIG_INTERRUPT:
					PUSH		{R4-R5, LR}

					/* 
					 * Configure Interrupt Set-Enable Registers (ICDISERn). 
					 * reg_offset = (integer_div(N / 32) * 4
					 * value = 1 << (N mod 32)
					 */
					LSR			R4, R0, #3				// Calculate reg_offset
					BIC			R4, R4, #3				// R4 = reg_offset
					LDR			R2, =0xFFFED100
					ADD			R4, R2, R4				// R4 = address of ICDISER

					AND			R2, R0, #0x1F			// N mod 32
					MOV			R5, #1						// Enable
					LSL			R2, R5, R2				// R2 = value

					/* now that we have the register address (R4) and value (R2), we need to set the
					 * correct bit in the GIC register */
					LDR		R3, [R4]						// read current register value
					ORR		R3, R3, R2					// set the enable bit
					STR		R3, [R4]						// store the new register value

					/* 
					 * Configure Interrupt Processor Targets Register (ICDIPTRn)
					 * reg_offset = integer_div(N / 4) * 4
					 * index = N mod 4
					 */
					BIC			R4, R0, #3				// R4 = reg_offset
					LDR			R2, =0xFFFED800
					ADD			R4, R2, R4				// R4 = word address of ICDIPTR
					AND			R2, R0, #0x3			// N mod 4
					ADD			R4, R2, R4				// R4 = byte address in ICDIPTR

					/* 
					 * Now that we have the register address (R4) and value (R2), write to (only)
					 * the appropriate byte
					 */
					STRB		R1, [R4]
					POP			{R4-R5, PC}

.end
