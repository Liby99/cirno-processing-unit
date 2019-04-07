#define addr_i 195
#define addr_j 196
#define addr_pos 197
#define addr_acc1 194
#define addr_acc2 193
#define addr_char1 198
#define addr_char2 199
#define addr_inByte 200
#define addr_pattern 192

#define st sb
#define ld lb
#define mv movi
#define b0 br
#define jp jmpr
#define inc incr

	andi	$1, 0			// $1 = 0
	mv	$2, addr_acc1
	st	$1, $2			// acc1 = 0
	mv	$2, addr_acc2
	st	$1, $2			// acc2 = 0
	
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
	mv	$4, end_outerwhile
	b0	$1, $4

	inc	$1	
	st	$1, $2			// i++

	mv	$2, addr_pos
	ld	$1, $2			// $1 = pos
	inc	$1			// pos++
	st	$1, $2

	ld	$1, $1			// char2 = mem[pos]
	mv	$2, addr_char2
	st	$1, $2

	andi	$1, 0
	mv	$2, addr_inByte
	st	$1, $2			// inbyte = 0

	mv	$1, 0b11111000		// j = 0b11111000;
	mv	$2, addr_j
	st	$1, $2

innerwhile:
	mv	$4, end_innerwhile
	b0	$1, $4
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	mv	$2, addr_pattern
	ld	$3, $2			// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	mv	$2, 0b11110000		
	and 	$1, $2			// temp $= 0b11110000

	mv	$4, ifmatch
	b0	$1, $4

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
	mv	$4, innerwhile
	jp	$4
	
ifmatch:
	mv	$2, addr_acc1
	ld	$1, $2			// $1 = acc1
	inc	$1			// acc1++
	st	$1, $2

	mv	$2, addr_j
	ld	$1, $2			// $1 = j
	and	$1, 0b00000100
	mv	$4, ifinbyte
	b0	$1, $4
	mv	$4, notMatch
	jp	notMatch

ifinbyte: 
	mv	$2, addr_inByte
	mv	$1, 1			// inByte = 1
	st	$1, $2
	mv	$4, notMatch
	jp	$4

end_innerwhile:
	mv	$2, addr_acc2		// $1 = acc2
	ld	$1, $2
	
	mv	$4, addr_inByte
	ld	$3, $4			// $3 = addr_inByte

	add	$1, $3
	st	$1, $2
	mv	$4, outerwhile
	jp	$4

end_outerwhile:

	andi	$1, 0
	mv	$2, addr_inByte
	st	$1, $2			// inbyte = 0

	mv	$1, 0b1111011		// j = 3;
	mv	$2, addr_j
	st	$1, $2

lastBytewhile:
	mv	$4, end_prog
	b0	$1, $4
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	mv	$2, addr_pattern
	ld	$3, $2			// $3 = pattern

	xor	$1, $3			// temp = char1 ^ pattern
	mv	$2, 0b11110000		
	and 	$1, $2			// temp &= 0b11110000

	mv	$4, lastByteMatch
	b0	$1, $4

lastByteNotMatch:
	mv	$2, addr_char1
	ld	$1, $2			// $1 = char1
	ls	$1, 1			// char1 = char1 << 1
	st	$1, $2

	mv	$2, addr_j		// j++
	ld	$1, $2
	inc	$1
	st	$1, $2
	mv	$4, lastBytewhile
	jp	$4
	
lastByteMatch:
	mv	$2, addr_acc1
	ld	$1, $2			// $1 = acc1
	inc	$1			// acc1++
	st	$1, $2

	mv	$2, addr_inByte
	mv	$1, 1			// inByte = 1
	st	$1, $2

	mv	$4, lastBytewhile
	jp	$4

end_prog
	mv	$2, addr_acc2		// $1 = acc2
	ld	$1, $2
	
	mv	$4, addr_inByte
	ld	$3, $4			// $3 = addr_inByte

	add	$1, $3
	st	$1, $2			// acc2 += inByte