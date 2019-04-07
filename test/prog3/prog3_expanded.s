







	andi	$1, 0			// $1 = 0
	movi	$2, 194
	sb	$1, $2			// acc1 = 0
	movi	$2, 193
	sb	$1, $2			// acc2 = 0
	
	movi	$2, 195
	movi	$1, 0b11000001		// $1 = i
	sb	$1, $2			// i = 0b11000001

	movi	$4, 197
	movi	$3, 128			// $3 = pos
	sb	$3, $4			// pos = 128

	lb	$1, $3			// $1 = mem[pos]
	movi	$2, 198
	sb	$1, $2			// char1 = mem[pos]

outerwhile:
	// while(i != 0)
	movi	$2, 195
	lb 	$1, $2			// $1 = i
	br	$1, end_outerwhile

	incr	$1	
	sb	$1, $2			// i++

	movi	$2, 197
	lb	$1, $2			// $1 = pos
	incr	$1			// pos++
	sb	$1, $2

	lb	$1, $1			// char2 = mem[pos]
	movi	$2, 199
	sb	$1, $2

	andi	$1, 0
	movi	$2, 200
	sb	$1, $2			// inbyte = 0

	movi	$1, 0b11111000		// j = 0b11111000;
	movi	$2, 196
	sb	$1, $2

innerwhile:
	br	$1, end_innerwhile
	movi	$2, 198
	lb	$1, $2			// $1 = char1
	movi	$2, 192
	lb	$3, $2			// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	movi	$2, 0b11110000		
	and 	$1, $2			// temp $= 0b11110000

	br	$1, ifmatch

notMatch:
	movi	$2, 198
	lb	$1, $2			// $1 = char1
	ls	$1, 1			// char1 = char1 << 1

	movi	$4, 199
	lb	$3, $4			// $3 = char2
	rs	$3, 7			// char2 = char2 >> 2
	or 	$1, $3			// char1 |= char2
	sb	$1, $2

	lb	$3, $4			// $3 = char2
	ls	$3, 1			// char2 = char2 << 1
	sb	$3, $4

	movi	$2, 196		// j++
	lb	$1, $2
	incr	$1
	sb	$1, $2
	jmpr	innerwhile
	
ifmatch:
	movi	$2, 194
	lb	$1, $2			// $1 = acc1
	incr	$1			// acc1++
	sb	$1, $2

	movi	$2, 196
	lb	$1, $2			// $1 = j
	and	$1, 0b00000100
	br	$1, ifinbyte
	jmpr	notMatch

ifinbyte: 
	movi	$2, 200
	movi	$1, 1			// inByte = 1
	sb	$1, $2
	jmpr	notMatch

end_innerwhile:
	movi	$2, 193		// $1 = acc2
	lb	$1, $2
	
	movi	$4, 200
	lb	$3, $4			// $3 = 200

	add	$1, $3
	sb	$1, $2
	jmpr	outerwhile

end_outerwhile:

	andi	$1, 0
	movi	$2, 200
	sb	$1, $2			// inbyte = 0

	movi	$1, 0b1111011		// j = 3;
	movi	$2, 196
	sb	$1, $2

lastBytewhile:
	br	$1, end_prog
	movi	$2, 198
	lb	$1, $2			// $1 = char1
	movi	$2, 192
	lb	$3, $2			// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	movi	$2, 0b11110000		
	and 	$1, $2			// temp &= 0b11110000

	br	$1, lastByteMatch

lastByteNotMatch:
	movi	$2, 198
	lb	$1, $2			// $1 = char1
	ls	$1, 1			// char1 = char1 << 1
	sb	$1, $2

	movi	$2, 196		// j++
	lb	$1, $2
	incr	$1
	sb	$1, $2
	jmpr	lastBytewhile
	
lastByteMatch:
	movi	$2, 194
	lb	$1, $2			// $1 = acc1
	incr	$1			// acc1++
	sb	$1, $2

	movi	$2, 200
	movi	$1, 1			// inByte = 1
	sb	$1, $2

	jmpr	lastByteNotMatch

end_prog
	movi	$2, 193		// $1 = acc2
	lb	$1, $2
	
	movi	$4, 200
	lb	$3, $4			// $3 = 200

	add	$1, $3
	sb	$1, $2			// acc2 += inByte
