setup:
	movi	$1, 30	; k = 30
	movi	$0, 253 ; ptr = 253
	st	$1, $0		; mem[253] = 30

	clr	$1				; i = 0

while_start:
	ld	$2 $1		; lower = mem[i]
	movil	$0 10  ; ptr = 250
	st	$2 $0		; mem[250] = lower

	incr $1
	ld	$3 $1		; p = upper = mem[i+1]
	incr	$1
	movil	$0 15	; ptr = 255
	st	$1 $0		; mem[255] = i

	;; Calculate p8
	;;   $0: ptr / 7
	;;   $1: j
	;;   $2: t
	;;   $3: p
	shli	$3 4
	shri	$2 4
	or	$3 $2		; p = temp_upper = $3
	movil $0 11 ; ptr = 251
	st	$3 $0		; mem[251] = temp_upper

	mov	$2 $3		; t = p
	shri	$2 1

	clr	$1		  ; j = 0
	movi	$0 7	; temp = 7

p8_while_start:
	xor	$3 $2
	shri	$2 1
	incr	$1
	cmp	$1 $0
	beqil p8_while_end
	jmpil	p8_while_start

p8_while_end:
	shli	$3 4
	movi	$0 250
	ld	$2 $0		; $2 = lower = mem[250]
	andi $2 14  ; $2 &= 14
	or $3 $2    ; p = [x x x p8 b4 b3 b2 0]
	movil	$0 12 ; ptr = 252
	st	$3 $0   ; mem[252] = p

	;; Calculate p4
	movil	$0 11
	ld	$3 $0		; p = temp_upper = mem[251]
	movil	$0 8  ; ptr = 248
	and	$3 $0   ; p &= 248
	movil	$0 10
	ld	$2 $0
	shri	$2 1
	andi	$2 7
	or	$3 $2   ; p = (temp_upper & 248) | ((lower >> 1) & 7)
	mov $2 $3
	shri	$2 1  ; t = p >> 1
	clr	$1      ; j = 0
	movi	$0 7

p4_while_start:
	xor	$3 $2
	shri	$2 1
	incr	$1
	cmp	$1 $0
	beqil p4_while_end
	jmpil	p4_while_start

p4_while_end:
	andi $3 1  ; p &= 1
	movi $0 252  ; ptr = 252
	ld $2 $0 ; parity = mem[252]
	or $2 $3 ; parity |= p4 ; parity = [x x x p8 b4 b3 b2 p4]
	shli $2 1 ; parity <<= 1 ; parity = [x x p8 b4 b3 b2 p4 0]
	movil $0 10 ; ptr = 250
	ld $3 $0 ; $3 = lower = mem[250]
	andi $3 1 ; lower &= 1
	or $2 $3 ; parity |= b1 ; parity = [x x p8 b4 b3 b2 p4 b1]
	shli $2 1 ; parity <<= 1 ; parity = [x p8 b4 b3 b2 p4 b1 0]
	movil $0 12 ; ptr = 252
	st $2 $0 ; mem[252] = parity

	;; Calculate p2
	movil	$0 11  ; ptr = 251
	ld	$3 $0    ; p = temp_upper = mem[251]
	mov $2 $3
	shri	$2 1   ; t = p >> 1
	xor	$3 $2    ; p ^= t
	shri	$2 2   ; t >>= 2
	xor	$3 $2    ; p ^= t
	shri $2 1    ; t >>= 1
	xor $3 $2    ; p ^= t
	movil	$0 10
	ld	$2 $0    ; t = lower = mem[250]
	xor	$3 $2    ; p ^= t
	shri	$2 2   ; t >>= 2
	xor	$3 $2    ; p ^= t
	shri $2 1
	xor $3 $2    ; p ^= t

	andi	$3 1   ; p2 = p & 1
	movil $0 12  ; ptr = 252
	ld $2 $0     ; $1 = parity = mem[252]
	or $2 $3     ; parity |= p2 ; parity = [x p8 b4 b3 b2 p4 b1 p2]
	shli $2 1    ; parity <<= 1 ; parity = [p8 b4 b3 b2 p4 b1 p2 0]
	st	$2 $0    ; mem[252] = parity

	;; Calculate p1
	movil	$0 11   ; ptr = 251
	ld	$3 $0			; p = temp_upper = mem[251]
	mov $2 $3
	shri	$2 2    ; t = p >> 2
	clr	$1				; j = 0
	movi	$0 3    ; temp = 3

p1_while_start:
	xor	$3 $2
	shri	$2 2
	incr	$1
	cmp	$1 $0
	beqil p1_while_end
	jmpil	p1_while_start

p1_while_end:
	movi	$0 250   ; ptr = 250
	ld	$2 $0     ; t = lower = mem[250]
	xor $3 $2     ; p ^= t
	shri	$2 1    ; t >>= 1
	xor	$3 $2     ; p ^= t
	shri	$2 2    ; t >>= 2
	xor	$3 $2     ; p ^= t
	andi	$3 1    ; p1 = p &= 1
	movil	$0 12   ; ptr = 252
	ld	$2 $0     ; $2 = parity = mem[252]
	or	$2 $3     ; parity = [p8 b4 b3 b2 p4 b1 p2 p1]

	;; Writing back to memory
	movil	$0 13   ; ptr = 253
	ld	$1 $0     ; $1 = k
	st $2 $1     ; mem[k] = parity = new_lower
	incr	$1    ; k++
	movil	$0 11  ; ptr = 251
	ld	$3 $0   ; $3 = temp_upper
	st	$3 $1   ; mem[k] = temp_upper
	incr	$1
	movil	$0 13 ; ptr = 253
	st	$1 $0

	;; While Loop End
	movil	$0 15  ; ptr = 255
	ld $1 $0    ; i = mem[255]
	movi	$2 30
	cmp $1 $2
	beqil while_end
	jmpl $3 while_start

while_end:
