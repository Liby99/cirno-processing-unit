#define addr_i 195
#define addr_j 196
#define addr_pos 197
#define addr_acc1 194
#define addr_acc2 193
#define addr_char1 198
#define addr_char2 199
#define addr_inByte 200
#define addr_pattern 192
#define POS 128

#define $4 $0

#define st sb
#define ld lb
#define mv movi
#define b0 beq
#define jp jmp
#define inc incr
#define mva movi
#define mvb movl

	andi	$1, 0			// $1 = 0
	mva	$2, addr_acc1
	st	$1, [$2]		// acc1 = 0
	mva	$2, addr_acc2
	st	$1, [$2]		// acc2 = 0
	
	mva	$2, addr_i
	mv	$1, 31			// $1 = i
	st	$1, [$2]		// i = 63

	mva	$4, addr_pos
	mv	$1, 128			// $3 = pos
	st	$1, [$4]		// pos = 128

	mva	$3, POS
	ld	$1, [$3]		// $1 = mem[pos]
	mva	$2, addr_char1
	st	$1, [$2]		// char1 = mem[pos]

outerwhile:
	// while(i != 0)
	mva	$2, addr_i
	ld 	$1, [$2]		// $1 = i
	mvb	$4, =end_outerwhile
	andi	$3, 0
	cmp	$1, $3
	b0	$4

	mv	$3, 1
	sub	$1, $3	
	st	$1, [$2]		// i--

	mva	$2, addr_pos
	ld	$1, [$2]		// $1 = pos
	mv	$3, 1
	add	$1, $3			// pos++
	st	$1, [$2]
	mva	$1, POS		

	ld	$1, [$1]		// char2 = mem[pos]
	mva	$2, addr_char2
	st	$1, [$2]

	andi	$1, 0
	mva	$2, addr_inByte
	st	$1, [$2]		// inbyte = 0

	mv	$1, 8			// j = 8;
	mva	$2, addr_j
	st	$1, [$2]

innerwhile:
	mvb	$4, =end_innerwhile
	andi	$3, 0
	cmp	$1, $3
	b0	$4
	mva	$2, addr_char1
	ld	$1, [$2]		// $1 = char1
	mva	$2, addr_pattern
	ld	$3, [$2]		// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	//mv	$2, 0b11110000	
	mv	$2, 240
	and 	$1, $2			// temp $= 0b11110000

	mvb	$4, =ifmatch
	andi	$3, 0
	cmp	$1, $3
	b0	$4

notMatch:
	mva	$2, addr_char1
	ld	$1, [$2]		// $1 = char1
	shli	$1, 1			// char1 = char1 << 1

	mva	$4, addr_char2
	ld	$3, [$4]		// $3 = char2
	shri	$3, 7			// char2 = char2 >> 2
	or 	$1, $3			// char1 |= char2
	st	$1, [$2]

	ld	$3, [$4]		// $3 = char2
	shli	$3, 1			// char2 = char2 << 1
	st	$3, [$4]

	mva	$2, addr_j		// j--
	ld	$1, [$2]
	mv	$3, 1
	sub	$1, $3
	st	$1, [$2]
	mvb	$4, =innerwhile
	jp	$4
	
ifmatch:
	mva	$2, addr_acc1
	ld	$1, [$2]		// $1 = acc1
	mva	$3, 1
	add	$1, $3			// acc1++
	st	$1, [$2]

	mva	$2, addr_j
	ld	$1, [$2]		// $1 = j
	//andi	$1, 0b00000100
	//xor	$1, 0b
	mv      $2, 4
	and	$1, $2
	xor	$1, $2
	mvb	$4, =ifinbyte
	andi	$3, 0
	cmp	$1, $3
	b0	$4
	mvb	$4, =notMatch
	jp	$4

ifinbyte: 
	mva	$2, addr_inByte
	mv	$1, 1			// inByte = 1
	st	$1, [$2]
	mvb	$4, =notMatch
	jp	$4

end_innerwhile:
	mva	$2, addr_acc2		// $1 = acc2
	ld	$1, [$2]
	
	mva	$4, addr_inByte
	ld	$3, [$4]		// $3 = addr_inByte

	add	$1, $3
	st	$1, [$2]
	mvb	$4, =outerwhile
	jp	$4

end_outerwhile:

	andi	$1, 0
	mva	$2, addr_inByte
	st	$1, [$2]		// inbyte = 0

	mv	$1, 5			// j = 5;
	mva	$2, addr_j
	st	$1, [$2]

lastBytewhile:
	mvb	$4, =end_prog
	andi	$3, 0
	cmp	$1, $3
	b0	$4
	mva	$2, addr_char1
	ld	$1, [$2]		// $1 = char1
	mva	$2, addr_pattern
	ld	$3, [$2]		// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	//mv	$2, 0b11110000	
	mv	$2, 240	
	and 	$1, $2			// temp &= 0b11110000

	mvb	$4, =lastByteMatch
	andi	$3, 0
	cmp	$1, $3
	b0	$4

lastByteNotMatch:
	mva	$2, addr_char1
	ld	$1, [$2]		// $1 = char1
	shli	$1, 1			// char1 = char1 << 1
	st	$1, [$2]

	mva	$2, addr_j		// j--
	ld	$1, [$2]
	mv	$3, 1
	sub	$1, $3
	st	$1, [$2]
	mvb	$4, =lastBytewhile
	jp	$4
	
lastByteMatch:
	mva	$2, addr_acc1
	ld	$1, [$2]		// $1 = acc1
	mv	$3, 1
	add	$1, $3			// acc1++
	st	$1, [$2]

	mva	$2, addr_inByte
	mv	$1, 1			// inByte = 1
	st	$1, [$2]

	mvb	$4, =lastByteNotMatch
	jp	$4

end_prog:
	mva	$2, addr_acc2		// $1 = acc2
	ld	$1, [$2]
	
	mva	$4, addr_inByte
	ld	$3, [$4]		// $3 = addr_inByte

	add	$1, $3
	st	$1, [$2]		// acc2 += inByte