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
	sb	$0, $1
	mov $1, addr_j
	sb	$0, $1
	mov $1, addr_t
	sb	$0, $1
	mov $1, addr_p
	sb	$0, $1
	mov $1, addr_p8
	sb	$0, $1
	mov $1, addr_p4
	sb	$0, $1
	mov $1, addr_p2
	sb	$0, $1
	mov $1, addr_p1
	sb	$0, $1
	mov $1, addr_lower
	sb	$0, $1
	mov	$1, addr_upper
	sb	$0, $1
	mov $1, addr_b4to2
	sb	$0, $1
	mov $1, addr_b1
	sb	$0, $1
	mov $1, addr_temp_lower
	sb	$0, $1
	mov $1, addr_temp_upper
	sb	$0, $1

	andi	$0, 30
	mov		$1, addr_k
	sb		$0, $1

while:
	mov	$1,	addr_i
	lb	$1, $1
	andi	$0, 30
	sub	$0, $1
	br	$0, end_while

	mov	$0, addr_lower
	lb	$2, $1					// $2 = mem[i]
	sb	$2, $0					// lower = mem[i]????

	incr	$1
	mov	$0, addr_upper
	lb	$2, $1					// $2 = mem[i]
	sb	$2, $0					// upper = mem[i]
	incr $1

	shli	$0, 4
	mov	$2, addr_lower
	shri	$2, 4
	or	$0, $2					// $0 = (upper << 4) | (lower >> 4)
	mov	$2, addr_temp_upper
	sb	$0, $2					// temp_upper = $0

p8:
	andi	$0, 0
	mov $3, addr_p8
	sb	$0, $3
	mov	$0, addr_temp_upper
	lb	$2, $0
	mov	$0, addr_p
	sb	$2, $0
	mov	$5, addr_temp_upper
	lb	$2, $5
	shri	$2, 1
	mov $5, addr_t
	sb	$2, $5

p8while:
	mov $2, addr_j
	lb	$2, $2
	andi	$6, 7
	sub	$6, $2
	br	$6, p4



p4:

p2:

p1:



p4while:

p1while:


end_while:
