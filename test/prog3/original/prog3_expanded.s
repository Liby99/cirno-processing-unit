











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

outerwhile:
	
	movi	$2 195
	lb 	$1 $2		
	movl	$0 end_outerwhile
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

innerwhile:
	movl	$0 end_innerwhile
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

	movl	$0 ifmatch
	andi	$3 0
	cmp	$1 $3
	beq	$0

notMatch:
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
	movl	$0 innerwhile
	jmp	$0
	
ifmatch:
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
	movl	$0 ifinbyte
	andi	$3 0
	cmp	$1 $3
	beq	$0
	movl	$0 notMatch
	jmp	$0

ifinbyte: 
	movi	$2 200
	movi	$1 1			
	sb	$1 $2
	movl	$0 notMatch
	jmp	$0

end_innerwhile:
	movi	$2 193		
	lb	$1 $2
	
	movi	$0 200
	lb	$3 $0		

	add	$1 $3
	sb	$1 $2
	movl	$0 outerwhile
	jmp	$0

end_outerwhile:

	andi	$1 0
	movi	$2 200
	sb	$1 $2		

	movi	$1 5			
	movi	$2 196
	sb	$1 $2

lastBytewhile:
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

	movl	$0 lastByteMatch
	andi	$3 0
	cmp	$1 $3
	beq	$0

lastByteNotMatch:
	movi	$2 198
	lb	$1 $2		
	shli	$1 1			
	sb	$1 $2

	movi	$2 196		
	lb	$1 $2
	movi	$3 1
	sub	$1 $3
	sb	$1 $2
	movl	$0 lastBytewhile
	jmp	$0
	
lastByteMatch:
	movi	$2 194
	lb	$1 $2		
	movi	$3 1
	add	$1 $3			
	sb	$1 $2

	movi	$2 200
	movi	$1 1			
	sb	$1 $2

	movl	$0 lastByteNotMatch
	jmp	$0

end_prog:
	movi	$2 193		
	lb	$1 $2
	
	movi	$0 200
	lb	$3 $0		

	add	$1 $3
	sb	$1 $2		
