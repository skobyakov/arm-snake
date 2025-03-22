.global _main
.align 2

_main:
	// Clear console
	mov x0, #1
	adr x1, clear_sequence
	mov x2, #7
	mov X16, #4 // System call for write
	svc #0x80 // Make the system call


	// Print the message
	mov X0, #1
	adrp X1, message@PAGE
	add X1, X1, message@PAGEOFF
	mov X2, #11
	mov X16, #4 // System call for write
	svc #0x80

	// Exit the program 
	mov X0, #0  // Exit status 0
	mov X16, #1
	svc #0x80

clear_sequence:
	.asciz "\x1b[2J\x1b[H" // ANSI sequence to clear screen and move cursor to the top-left corner

.data
message:
	.asciz "Hello ASM!\n"