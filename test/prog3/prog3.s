	andi	$1 0			
	movi	$2 194
	sb	$1 $2		
	movi	$2 193
	sb	$1 $2		
	movi	$2 195
	movi	$1 31			
	sb	$1 $2		
	movi	$0 197
	movi	$1 128			
	sb	$1 $0		
	movi	$3 128
	lb	$1 $3		
	movi	$2 198
	sb	$1 $2		

outer_while:
	movi	$2 195
	lb 	$1 $2		
	movl	$0 end_outer_while
	andi	$3 0
	cmp	$1 $3
	beq	$0
	movi	$3 1
	sub	$1 $3	
	sb	$1 $2		
	movi	$2 197
	lb	$1 $2		
	movi	$3 1
	add	$1 $3			
	sb	$1 $2
	movi	$1 128		
	lb	$1 $1		
	movi	$2 199
	sb	$1 $2
	andi	$1 0
	movi	$2 200
	sb	$1 $2		
	movi	$1 8			
	movi	$2 196
	sb	$1 $2

inner_while:
	movl	$0 end_inner_while
	andi	$3 0
	cmp	$1 $3
	beq	$0
	movi	$2 198
	lb	$1 $2		
	movi	$2 192
	lb	$3 $2		
	xor	$1 $3			
	movi	$2 240
	and 	$1 $2			
	movl	$0 if_match
	andi	$3 0
	cmp	$1 $3
	beq	$0

not_match:
	movi	$2 198
	lb	$1 $2		
	shli	$1 1			
	movi	$0 199
	lb	$3 $0		
	shri	$3 7			
	or 	$1 $3			
	sb	$1 $2
	lb	$3 $0		
	shli	$3 1			
	sb	$3 $0
	movi	$2 196		
	lb	$1 $2
	movi	$3 1
	sub	$1 $3
	sb	$1 $2
	movl	$0 inner_while
	jmp	$0
	
if_match:
	movi	$2 194
	lb	$1 $2		
	movi	$3 1
	add	$1 $3			
	sb	$1 $2
	movi	$2 196
	lb	$1 $2		
	movi      $2 4
	and	$1 $2
	xor	$1 $2
	movl	$0 if_in_byte
	andi	$3 0
	cmp	$1 $3
	beq	$0
	movl	$0 not_match
	jmp	$0

if_in_byte: 
	movi	$2 200
	movi	$1 1			
	sb	$1 $2
	movl	$0 not_match
	jmp	$0

end_inner_while:
	movi	$2 193		
	lb	$1 $2
	movi	$0 200
	lb	$3 $0		
	add	$1 $3
	sb	$1 $2
	movl	$0 outer_while
	jmp	$0

end_outer_while:
	andi	$1 0
	movi	$2 200
	sb	$1 $2		
	movi	$1 5			
	movi	$2 196
	sb	$1 $2

last_byte_while:
	movl	$0 end_prog
	andi	$3 0
	cmp	$1 $3
	beq	$0
	movi	$2 198
	lb	$1 $2		
	movi	$2 192
	lb	$3 $2		
	xor	$1 $3			
	movi	$2 240	
	and 	$1 $2			
	movl	$0 last_byte_match
	andi	$3 0
	cmp	$1 $3
	beq	$0

last_byte_not_match:
	movi	$2 198
	lb	$1 $2		
	shli	$1 1			
	sb	$1 $2
	movi	$2 196		
	lb	$1 $2
	movi	$3 1
	sub	$1 $3
	sb	$1 $2
	movl	$0 last_byte_while
	jmp	$0
	
last_byte_match:
	movi	$2 194
	lb	$1 $2		
	movi	$3 1
	add	$1 $3			
	sb	$1 $2
	movi	$2 200
	movi	$1 1			
	sb	$1 $2
	movl	$0 last_byte_not_match
	jmp	$0

end_prog:
	movi	$2 193		
	lb	$1 $2
	movi	$0 200
	lb	$3 $0
	add	$1 $3
	sb	$1 $2		
