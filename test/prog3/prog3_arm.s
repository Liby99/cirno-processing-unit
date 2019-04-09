







@ Rasberry Pi directives
	.cpu	cortex-a53	@ Version of our Pis
	.syntax unified		@ Modern ARM syntax
	
	.equ	FP_OFFSET, 4	@ Offset from sp to set fp

	.global prog3		@ Specify sum3 as a global symnbol

	.text			@ Switch to Text segament 
	.align 2		@ Align on evenly divisible by 4 byte address;
				@  .align n where 2^n determines alignment

prog3:
@ Standard prologue
	push	{fp, lr}		@ Save registers: fp, lr
	add	fp, sp, FP_OFFSET	@ Set fp to base of saved registers


	and	r1, 0			// r1 = 0
	add	r2, r0, 194
	strb	r1, [r2]		// acc1 = 0
	add	r2, r0, 193
	strb	r1, [r2]		// acc2 = 0
	
	add	r2, r0, 195
	mov	r1, 63			// r1 = i
	strb	r1, [r2]		// i = 63

	add	r4, r0, 197
	mov	r1, 128			// r3 = pos
	strb	r1, [r4]		// pos = 128

	add	r3, r0, r1
	ldrb	r1, [r3]		// r1 = mem[pos]
	add	r2, r0, 198
	strb	r1, [r2]		// char1 = mem[pos]

outerwhile:
	// while(i != 0)
	add	r2, r0, 195
	ldrb 	r1, [r2]		// r1 = i
	ldr	r4, =end_outerwhile
	cmp     r1, 0
	bxeq	r4

	add	r1, -1	
	strb	r1, [r2]		// i--

	add	r2, r0, 197
	ldrb	r1, [r2]		// r1 = pos
	add	r1, 1			// pos++
	strb	r1, [r2]
	add	r1, r0, r1		

	ldrb	r1, [r1]		// char2 = mem[pos]
	add	r2, r0, 199
	strb	r1, [r2]

	and	r1, 0
	add	r2, r0, 200
	strb	r1, [r2]		// inbyte = 0

	mov	r1, 8			// j = 8;
	add	r2, r0, 196
	strb	r1, [r2]

innerwhile:
	ldr	r4, =end_innerwhile
	cmp     r1, 0
	bxeq	r4
	add	r2, r0, 198
	ldrb	r1, [r2]		// r1 = char1
	add	r2, r0, 192
	ldrb	r3, [r2]		// r3 = pattern

	eor	r1, r3			// temp = char1 ^ pattern
	mov	r2, 0b11110000		
	and 	r1, r2			// temp $= 0b11110000

	ldr	r4, =ifmatch
	cmp     r1, 0
	bxeq	r4

notMatch:
	add	r2, r0, 198
	ldrb	r1, [r2]		// r1 = char1
	lsl	r1, 1			// char1 = char1 << 1

	add	r4, r0, 199
	ldrb	r3, [r4]		// r3 = char2
	lsr	r3, 7			// char2 = char2 >> 2
	orr 	r1, r3			// char1 |= char2
	strb	r1, [r2]

	ldrb	r3, [r4]		// r3 = char2
	lsl	r3, 1			// char2 = char2 << 1
	strb	r3, [r4]

	add	r2, r0, 196		// j++
	ldrb	r1, [r2]
	add	r1, -1
	strb	r1, [r2]
	ldr	r4, =innerwhile
	bx	r4
	
ifmatch:
	add	r2, r0, 194
	ldrb	r1, [r2]		// r1 = acc1
	add	r1, 1			// acc1++
	strb	r1, [r2]

	add	r2, r0, 196
	ldrb	r1, [r2]		// r1 = j
	and	r1, 0b00000100
	eor	r1, 0b00000100
	ldr	r4, =ifinbyte
	cmp     r1, 0
	bxeq	r4
	ldr	r4, =notMatch
	bx	r4

ifinbyte: 
	add	r2, r0, 200
	mov	r1, 1			// inByte = 1
	strb	r1, [r2]
	ldr	r4, =notMatch
	bx	r4

end_innerwhile:
	add	r2, r0, 193		// r1 = acc2
	ldrb	r1, [r2]
	
	add	r4, r0, 200
	ldrb	r3, [r4]		// r3 = r0, 200

	add	r1, r3
	strb	r1, [r2]
	ldr	r4, =outerwhile
	bx	r4

end_outerwhile:

	and	r1, 0
	add	r2, r0, 200
	strb	r1, [r2]		// inbyte = 0

	mov	r1, 5			// j = 3;
	add	r2, r0, 196
	strb	r1, [r2]

lastBytewhile:
	ldr	r4, =end_prog
	cmp     r1, 0
	bxeq	r4
	add	r2, r0, 198
	ldrb	r1, [r2]		// r1 = char1
	add	r2, r0, 192
	ldrb	r3, [r2]		// r3 = pattern

	eor	r1, r3			// temp = char1 ^ pattern
	mov	r2, 0b11110000		
	and 	r1, r2			// temp &= 0b11110000

	ldr	r4, =lastByteMatch
	cmp     r1, 0
	bxeq	r4

lastByteNotMatch:
	add	r2, r0, 198
	ldrb	r1, [r2]		// r1 = char1
	lsl	r1, 1			// char1 = char1 << 1
	strb	r1, [r2]

	add	r2, r0, 196		// j++
	ldrb	r1, [r2]
	add	r1, -1
	strb	r1, [r2]
	ldr	r4, =lastBytewhile
	bx	r4
	
lastByteMatch:
	add	r2, r0, 194
	ldrb	r1, [r2]		// r1 = acc1
	add	r1, 1			// acc1++
	strb	r1, [r2]

	add	r2, r0, 200
	mov	r1, 1			// inByte = 1
	strb	r1, [r2]

	ldr	r4, =lastByteNotMatch
	bx	r4

end_prog:
	add	r2, r0, 193		// r1 = acc2
	ldrb	r1, [r2]
	
	add	r4, r0, 200
	ldrb	r3, [r4]		// r3 = r0, 200

	add	r1, r3
	strb	r1, [r2]		// acc2 += inByte
@ Standard epilogue
	sub	sp, fp, FP_OFFSET	@ Set sp to top of saved registers
	pop	{fp,pc}			@ Restore fp; restoer lr into pc for 
