start:
	andi	$1 0		// $1 = 0
	movi	$2 194
	sb	$1 $2		// acc1 = 0
	movi	$2 193
	sb	$1 $2		// acc2 = 0
	
	movi	$2 195
	movi	$1 63		// $1 = i
	sb	$1 $2		// i = 63

	movi	$0 197
	movi	$1 128		// $3 = pos
	sb	$1 $0		// pos = 128

	movi	$3 128
	lb	$1 $3		// $1 = mempos
	movi	$2 198
	sb	$1 $2		// char1 = mempos

outerwhile:
	// while(i != 0)
	movi	$2 195
	lb 	$1 $2		// $1 = i
	movl	$0 =end_outerwhile
	andi	$3 0
	cmp	$1 $3		// if i == 0
	beq	$0

	movi	$3 1
	sub	$1 $3	
	sb	$1 $2		// i--

	movi	$2 197
	lb	$1 $2		// $1 = pos
	movi	$3 1
	add	$1 $3		// pos++
	sb	$1 $2
	movi	$1 128		

	lb	$1 $1		// char2 = mempos
	movi	$2 199
	sb	$1 $2

	andi	$1 0
	movi	$2 200
	sb	$1 $2		// inbyte = 0

	movi	$1 8		// j = 8;
	movi	$2 196
	sb	$1 $2

innerwhile:
	movl	$0 =end_innerwhile
	andi	$3 0
	cmp	$1 $3		/ if j == 0
	beq	$0
	movi	$2 198
	lb	$1 $2		// $1 = char1
	movi	$2 192
	lb	$3 $2		// $3 = pattern

	xor	$1 $3		// temp = char1 ^ pattern
	//movi	$2 0b11110000	
	movi	$2 240
	and 	$1 $2		// temp $= 0b11110000

	movl	$0 =ifmatch
	andi	$3 0
	cmp	$1 $3
	beq	$0

notMatch:
	movi	$2 198
	lb	$1 $2		// $1 = char1
	shli	$1 1		// char1 = char1 << 1

	movi	$0 199
	lb	$3 $0		// $3 = char2
	shri	$3 7		// char2 = char2 >> 2
	or 	$1 $3		// char1 |= char2
	sb	$1 $2

	lb	$3 $0		// $3 = char2
	shli	$3 1		// char2 = char2 << 1
	sb	$3 $0

	movi	$2 196		// j--
	lb	$1 $2
	movi	$3 1
	sub	$1 $3
	sb	$1 $2
	movl	$0 =innerwhile
	jmp	$0
	
ifmatch:
	movi	$2 194
	lb	$1 $2		// $1 = acc1
	movi	$3 1
	add	$1 $3		// acc1++
	sb	$1 $2

	movi	$2 196
	lb	$1 $2		// $1 = j
	movi    $2 4
	and	$1 $2
	xor	$1 $2		// if j > 4
	movl	$0 =ifinbyte
	andi	$3 0
	cmp	$1 $3
	beq	$0
	movl	$0 =notMatch
	jmp	$0

ifinbyte: 
	movi	$2 200
	movi	$1 1		// inByte = 1
	sb	$1 $2
	movl	$0 =notMatch
	jmp	$0

end_innerwhile:
	movi	$2 193		// $1 = acc2
	lb	$1 $2
	
	movi	$0 200
	lb	$3 $0		// $3 = 200

	add	$1 $3
	sb	$1 $2
	movl	$0 =outerwhile
	jmp	$0

end_outerwhile:

	andi	$1 0
	movi	$2 200
	sb	$1 $2		// inbyte = 0

	movi	$1 5		// j = 5;
	movi	$2 196
	sb	$1 $2

lastBytewhile:
	movl	$0 =end_prog
	andi	$3 0
	cmp	$1 $3		// if j == 8
	beq	$0
	movi	$2 198
	lb	$1 $2		// $1 = char1
	movi	$2 192
	lb	$3 $2		// $3 = pattern

	xor	$1 $3		// temp = char1 ^ pattern
	//movi	$2 0b11110000	
	movi	$2 240	
	and 	$1 $2		// temp &= 0b11110000

	movl	$0 =lastByteMatch
	andi	$3 0
	cmp	$1 $3
	beq	$0

lastByteNotMatch:
	movi	$2 198
	lb	$1 $2		// $1 = char1
	shli	$1 1		// char1 = char1 << 1
	sb	$1 $2

	movi	$2 196		// j--
	lb	$1 $2
	movi	$3 1
	sub	$1 $3
	sb	$1 $2
	movl	$0 =lastBytewhile
	jmp	$0
	
lastByteMatch:
	movi	$2 194
	lb	$1 $2		// $1 = acc1
	movi	$3 1
	add	$1 $3		// acc1++
	sb	$1 $2

	movi	$2 200
	movi	$1 1		// inByte = 1
	sb	$1 $2

	movl	$0 =lastByteNotMatch
	jmp	$0

end_prog:
	movi	$2 193		// $1 = acc2
	lb	$1 $2
	
	movi	$0 200
	lb	$3 $0		// $3 = 200

	add	$1 $3
	sb	$1 $2		// acc2 += inByte
