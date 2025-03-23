.global _main
.align 2

_main:

	bl draw

exit:
	// Exit the program 
	mov X0, #0  // Exit status 0
	mov X16, #1
	svc #0x80

draw:
	// Clear console
	mov x0, #1
	adr x1, clear_sequence
	mov x2, #7
	mov X16, #4 // System call for write
	svc #0x80 // Make the system call

	// TODO: Keep width and height in registers
	mov x0, #40

	bl draw_horizontal_border
	// bl draw_middle_rows
	// bl draw_horizontal_border

	ret

// x2 - row buffer
// x3 - column counter
// x4 - current char
draw_horizontal_border:
	adrp x2, row_buffer@PAGE
	add x2, x2, row_buffer@PAGEOFF
	mov x3, #0
draw_horizontal_loop:
	cmp x3, x0 // Compare current column with width
	bge draw_horizontal_end

	; ldr x4, horizontal_wall
	mov x4, #'-'
	str x4, [x2, x3]

	add x3, x3, #1

	b draw_horizontal_loop

draw_horizontal_end:
	; ldr x4, newline
	mov x4, #'\n'
	str x4, [x2, x3]

	bl draw_buffer

	b exit

draw_middle_rows:

// TODO: Keep row_buffer link in the registers
draw_buffer:
	mov x0, #1
	adrp x1, row_buffer@PAGE
	add x1, x1, row_buffer@PAGEOFF
	mov x2, #41
	mov x16, #4 // System call for write
	svc #0x80

	ret

clear_sequence: .asciz "\x1b[2J\x1b[H" // ANSI sequence to clear screen and move cursor to the top-left corner
horizontal_wall: .asciz "—"
vertical_wall: .asciz "|"
newline: .asciz "\n"



.data
message: .asciz "Hello ASM!\n"
row_buffer: .space 41