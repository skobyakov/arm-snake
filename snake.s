.global _main
.align 2

_main:
	mov X0, #1
	adrp X1, message@PAGE
	add X1, X1, message@PAGEOFF
	mov X2, 11
	mov X16, #4
	svc #0x80

	mov X0, #0  // Exit status 0
	mov X16, #1
	svc #0x80

.data
message: .asciz "Hello ASM!\n"