.global _main
.align 2

_main:
	mov X0, #1
	adr X1, message
	mov X2, 11
	mov X16, #4

	svc #0x80

	mov X0, #0  // Exit status 0
	mov X16, #1
	svc #0x80

message: .ascii "Hello ASM!\n"