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


	andi	$0, 0

	mov	$1, addr_i
	st	$0, $1
	mov $1, addr_j
	st	$0, $1
	mov $1, addr_t
	st	$0, $1
	mov $1, addr_p
	st	$0, $1
	mov $1, addr_p8
	st	$0, $1
	mov $1, addr_p4
	st	$0, $1
	mov $1, addr_p2
	st	$0, $1
	mov $1, addr_p1
	st	$0, $1
	mov $1, addr_lower
	st	$0, $1
	mov	$1, addr_upper
	st	$0, $1
	mov $1, addr_b4to2
	st	$0, $1
	mov $1, addr_b1
	st	$0, $1
	mov $1, addr_temp_lower
	st	$0, $1
	mov $1, addr_temp_upper
	st	$0, $1

	andi	$0, 30
	mov		$1, addr_k
	st		$0, $1

while:
	mov	$1,	addr_i
	ld	$1, $1
	andi	$0, 30
	cmp	$0, $1
	beq	end_while

	mov	$0, addr_lower
	ld	$2, $1					// $2 = mem[i]
	st	$2, $0					// lower = mem[i]????

	incr	$1
	mov	$0, addr_upper
	ld	$2, $1					// $2 = mem[i]
	st	$2, $0					// upper = mem[i]
	incr	$1

	shli	$0, 4
	mov	$2, addr_lower
	shri	$2, 4
	or	$0, $2					// $0 = (upper << 4) | (lower >> 4)
	mov	$2, addr_temp_upper
	st	$0, $2					// temp_upper = $0

p8:
	mov	$2, addr_p
	st	$0, $2
	shri	$0, 1
	mov	$3, addr_t
	st	$0, $3

	andi $0, 0
	mov	$1, addr_j
	st	$0, $1					// j = 0

p8while:
	mov	$1, addr_j
	ld	$1, $1
	andi	$0, 7
	cmp	$0, $1
	beq	p4

	mov	$2, addr_p
	ld	$2, $2					// p
	mov	$3, addr_t
	ld	$3, $3					// t
	xor	$2, $3
	mov	$0, addr_p
	st	$2, $0
	shri	$3, 1
	mov	$0, addr_t
	st	$3, $0
	incr	$1
	mov	$0, addr_j
	st	$1, $0

p4:
	mov	$0, addr_p
	ld	$0, $0
	shli	$0, 7
	andi	$1, 128
	and	$0, $1
	mov	$1, addr_p8
	st	$0, $1

	mov	$0, addr_temp_upper
	ld	$0, $0
	andi	$1, 248
	and	$0, $1					// $0 = (temp_upper & 248)
	mov	$1, addr_lower
	ld	$1, $1
	shri	$1, 1
	andi	$2, 7
	and	$1, $2					// $1 = ((lower >> 1) & 7)
	or	$0, $1
	mov	$1, addr_p
	st	$0, $1
	shri	$0, 1
	mov	$1, addr_t
	st	$0, $1

	andi $0, 0
	mov	$1, addr_j
	st	$0, $1					// j = 0

p4while:
	mov	$1, addr_j
	ld	$1, $1
	andi	$0, 7
	cmp	$0, $1
	beq	p2

	mov	$2, addr_p
	ld	$2, $2					// p
	mov	$3, addr_t
	ld	$3, $3					// t
	xor	$2, $3
	mov	$0, addr_p
	st	$2, $0
	shri	$3, 1
	mov	$0, addr_t
	st	$3, $0
	incr	$1
	mov	$0, addr_j
	st	$1, $0

p2:
	mov	$0, addr_p
	ld	$0, $0
	shli	$0, 3
	andi	$1, 8
	and	$0, $1
	mov	$1, addr_p4
	st	$0, $1

	mov	$0, addr_temp_upper
	ld	$0, $0
	shri	$0, 1
	mov	$1, addr_p
	st	$0, $1
	ld	$2, $1
	shri	$2, 1
	mov	$3, addr_t
	st	$2, $3
	xor	$0, $2
	st	$0, $1
	shri	$2, 2
	st	$2, $3
	xor	$0, $2
	st	$0, $1
	shri	$2, 1
	st	$2, $3
	xor	$0, $2
	st	$0, $1

	mov	$2, addr_lower
	ld	$2, $2
	mov	$3, addr_t
	st	$2, $3
	xor	$0, $2
	st	$0, $1
	shri	$2, 2
	st	$2, $3
	xor	$0, $2
	st	$0, $1
	shri	$2, 1
	st	$2, $3
	xor	$0, $2
	st	$0, $1
	shli	$0, 1
	andi	$2, 2
	and	$0, $2
	mov	$1, addr_p2
	st	$0, $1

p1:
	mov	$0, addr_upper
	ld	$0, $0
	mov	$1, addr_p
	st	$0, $1
	shri	$0, 2
	mov	$2, addr_t
	st	$0, $2

	andi $0, 0
	mov	$1, addr_j
	st	$0, $1					// j = 0

p1while:
	mov	$1, addr_j
	ld	$1, $1
	andi	$0, 3
	cmp	$0, $1
	beq	continue_while

	mov	$2, addr_p
	ld	$2, $2					// p
	mov	$3, addr_t
	ld	$3, $3					// t
	xor	$2, $3
	mov	$0, addr_p
	st	$2, $0
	shri	$3, 2
	mov	$0, addr_t
	st	$3, $0
	incr	$1
	mov	$0, addr_j
	st	$1, $0

continue_while:
	mov	$0, addr_lower
	ld	$0, $0
	mov	$1, addr_t
	st	$0, $1
	mov	$2, addr_p
	ld	$3, $2
	xor	$3, $0
	shri	$0, 1
	xor	$3, $0
	shri	$0, 2
	xor	$3, $0
	andi	$1, 1
	and	$3, $1
	mov	$0, addr_p1
	st	$3, $0

	mov	$0, addr_lower
	ld	$0, $0
	shli	$0, 3
	andi	$1, 112
	and	$0, $1
	mov	$1, addr_b4to2
	st	$0, $1

	mov	$2, addr_lower
	ld	$2, $2
	shli	$2, 2
	andi	$1, 4
	and	$2, $1
	mov	$1, addr_b1
	st	$2, $1

	or	$0, $2
	mov	$1, addr_p8
	ld	$1, $1
	or	$0, $1
	mov	$1, addr_p4
	ld	$1, $1
	or	$0, $1
	mov	$1, addr_p2
	ld	$1, $1
	or	$0, $1
	mov	$1, addr_p1
	ld	$1, $1
	or	$0, $1

	mov	$1, addr_temp_lower
	st	$0, $1

	mov	$2, addr_k
	ld	$3, $2
	st	$0, $3

	incr	$3
	mov	$1, addr_temp_upper
	ld	$1, $1
	st	$1, $3
	incr	$3
	st	$3, $2

end_while:
