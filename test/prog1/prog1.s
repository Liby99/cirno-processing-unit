#define addr_i 195
#define addr_j 196
#define addr_k 197
#define addr_t 198
#define addr_p 199
#define addr_p8 200
#define addr_p4 201
#define addr_p2 202
#define addr_p1 203
#define addr_lower 204
#define addr_upper 205
#define addr_b4to2 206
#define addr_b1 207
#define addr_temp_lower 208
#define addr_temp_upper 209

prog_start:
	andi	$0, 0
	movi	$1, addr_i
	st	$0, $1
	movi $1, addr_lower
	st	$0, $1
	movi	$1, addr_upper
	st	$0, $1
	movi $1, addr_temp_lower
	st	$0, $1
	movi $1, addr_temp_upper
	st	$0, $1

	andi	$0, 30
	movi		$1, addr_k
	st		$0, $1

while:
	movi	$1,	addr_i
	ld	$1, $1
	andi	$0, 30
	cmp	$0, $1
	beqil	end_while

	movi	$0, addr_lower
	ld	$2, $1					// $2(lower) = mem[i]
	st	$2, $0

	incr	$1
	ld	$3, $1					// $3(upper) = mem[i]
	incr	$1
	movi	$0, addr_i
	st	$1, $0

	shli	$3, 4
	shri	$2, 4
	or	$3, $2					// $3 = (upper << 4) | (lower >> 4)
	movi	$2, addr_temp_upper
	st	$3, $2					// $3(temp_upper) = mem[$2]

p8:
	mov	$0, $3					// $0 = p
	mov	$1, $0
	shri	$1, 1					// $1 = t
	clr	$2							// $2(j) = 0
	movi	$3, 7					// $3 = 7

p8while:
	xor	$0, $1
	shri	$1, 1
	incr	$2
	cmp	$3, $2
	beqil p4
	jmpil	p8while

p4:
	shli	$0, 7					// p << 7
	andi	$0, 128
	movi	$1, addr_p8
	st	$0, $1

	movi	$0, addr_temp_upper
	ld	$0, $0
	andi	$0, 248				// $0 = (temp_upper & 248)
	movi	$1, addr_lower
	ld	$1, $1
	shri	$1, 1
	andi	$1, 7					// $1 = ((lower >> 1) & 7)
	or	$0, $1					// $0 = p
	mov	$1, $0
	shri	$1, 1					// $1 = t
	clr	$2							// j = 0
	movi	$3, 7					// $3 = 7

p4while:
	xor	$0, $1
	shri	$1, 1
	incr	$2
	cmp	$3, $2
	beqil p2
	jmpil	p4while

p2:
	shli	$0, 3
	andi	$0, 8
	movi	$1, addr_p4
	st	$0, $1

	movi	$0, addr_temp_upper
	ld	$0, $0
	shri	$0, 1					// $0 = p
	mov	$1, $0
	shri	$1, 1					// $1 = t
	xor	$0, $1
	shri	$1, 2
	xor	$0, $1
	shri	$1, 1
	xor	$0, $1

	movi	$2, addr_lower
	ld	$2, $2
	mov	$1, $2
	xor	$0, $1
	shri	$1, 2
	xor	$0, $1
	shri	$1, 1
	xor	$0, $1
	shli	$0, 1
	andi	$0, 2
	movi	$1, addr_p2
	st	$0, $1

p1:
	movi	$0, addr_temp_upper
	ld	$0, $0					// $0 = p
	mov	$1, $0
	shri	$1, 2					// $1 = t
	clr	$2
	movi	$3, 3

p1while:
	movi	$1, addr_j
	ld	$1, $1
	andi	$0, 3
	cmp	$0, $1
	beq	continue_while

	xor	$0, $1
	shri	$1, 2
	incr	$2
	cmp	$3, $2
	beqil continue_while
	jmpil	p1while

continue_while:
	movi	$1, addr_lower
	ld	$1, $1
	xor	$0, $1
	shri	$1, 1
	xor	$0, $1
	shri	$1, 2
	xor	$0, $1
	andi	$0, 1
	movi	$1, addr_p1
	st	$0, $1

	movi	$0, addr_lower
	ld	$0, $0
	shli	$0, 3
	andi	$0, 112

	movi	$2, addr_lower
	ld	$2, $2
	shli	$2, 2
	andi	$2, 4

	or	$0, $2
	movi	$1, addr_p8
	ld	$1, $1
	or	$0, $1
	movi	$1, addr_p4
	ld	$1, $1
	or	$0, $1
	movi	$1, addr_p2
	ld	$1, $1
	or	$0, $1
	movi	$1, addr_p1
	ld	$1, $1
	or	$0, $1

	movi	$2, addr_k
	ld	$3, $2
	st	$0, $3
	incr	$3
	movi	$1, addr_temp_upper
	ld	$1, $1
	st	$1, $3
	incr	$3
	st	$3, $2

end_while:
