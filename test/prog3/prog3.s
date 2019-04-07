	// TODO clear acc1 and acc2 if memory is not 0 at start
	mv	$2, addr_i
	mv	$1, 0b11000001		// $1 = i
	st	$1, $2			// i = 0b11000001

	mv	$4, addr_pos
	mv	$3, 128			// $3 = pos
	st	$3, $4			// pos = 128

	ld	$1, $3			// $1 = mem[pos]
	mv	$2, addr_char1
	st	$1, $2			// char1 = mem[pos]


outerwhile:
	// while(i != 0)
	mv	$2, addr_i
	ld 	$1, $2			// $1 = i
	b0	$1, end_outerwhile

	inc	$1			
	mv	$2, addr_i
	st	$1, $2			// i++

	mv	$2, addr_pos
	ld	$1, $2			// $1 = pos
	inc	$1			// pos++
	st	$1, $2

	ld	$1, $1			// char2 = mem[pos]
	mv	$2, addr_char2
	st	$1, $2

	clr	$1,
	mv	$2, addr_inByte
	st	$1, $2			// inbyte = 0

	//
	mv	$1, 0b11111000		// j = 0b11111000;
	mv	$2, addr_j
	st	$1, $2

innerwhile:
	b0	$1, end_innerwhile
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	mv	$2, addr_pattern
	ld	$3, $2			// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	mv	$2, 0b11110000		
	and 	$1, $2			// temp $= 0b11110000

	b0	$1, ifmatch

notMatch:
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	ls	$1, 1			// char1 = char1 << 1

	mv	$4, addr_char2
	ld	$3, $4			// $3 = char2
	rs	$3, 7			// char2 = char2 >> 2
	or 	$1, $3			// char1 |= char2
	st	$1, $2

	ld	$3, $4			// $3 = char2
	ls	$3, 1			// char2 = char2 << 1
	st	$3, $4

	mv	$2, addr_j		// j++
	ld	$1, $2
	inc	$1
	st	$1, $2
	jp	innerwhile
	
ifmatch:
	mv	$2, addr_acc1
	ld	$1, $2			// $1 = acc1
	inc	$1			// acc1++
	st	$1, $2

	mv	$2, addr_j
	ld	$1, $2			// $1 = j
	and	$1, 0b00000100
	b0	ifinbyte
	jp	notMatch

ifinbyte: 
	mv	$2, addr_inByte
	mv	$1, $2			// inByte = 1
	st	$1, $2
	jp	notMatch

end_innerwhile:
	mv	$2, addr_acc2		// $1 = acc2
	ld	$1, $2
	
	mv	$4, addr_inByte
	ld	$3, $4			// $3 = addr_inByte

	add	$1, $3
	st	$1, $2
	jp	outerwhile

end_outerwhile:

	clr	$1,
	mv	$2, addr_inByte
	st	$1, $2			// inbyte = 0

	mv	$1, 0b1111011		// j = 3;
	mv	$2, addr_j
	st	$1, $2

lastBytewhile:
	b0	$1, end_prog
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	mv	$2, addr_pattern
	ld	$3, $2			// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	mv	$2, 0b11110000		
	and 	$1, $2			// temp &= 0b11110000

	b0	$1, lastByteMatch

lastByteNotMatch:
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	ls	$1, 1			// char1 = char1 << 1
	st	$1, $2

	mv	$2, addr_j		// j++
	ld	$1, $2
	inc	$1
	st	$1, $2
	jp	lastBytewhile
	
lastByteMatch:
	mv	$2, addr_acc1
	ld	$1, $2			// $1 = acc1
	inc	$1			// acc1++
	st	$1, $2

	mv	$2, addr_inByte
	mv	$1, $2			// inByte = 1
	st	$1, $2

	jp	lastByteNotMatch

end_prog
	mv	$2, addr_acc2		// $1 = acc2
	ld	$1, $2
	
	mv	$4, addr_inByte
	ld	$3, $4			// $3 = addr_inByte

	add	$1, $3
	st	$1, $2			// acc2 += inByte