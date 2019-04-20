setup:
  movi $0 94
  movi $1 251
  st $0 $1 ; mem[251] = k

  movi $0 64 ; i = 64

loop_start:
  ld $2 $0 ; lower = mem[i]
  incr $0 ; i++
  ld $3 $0 ; upper = mem[i]
  incr $0 ; i++
  movi $1 255
  st $0 $1 ; mem[255] = i, $0, $1 free, $2: lower, $3: upper
  movil $1 14
  st $2 $1 ; mem[254] = lower
  movil $1 13
  st $3 $1 ; mem[253] = upper

  ;; First we deal with p8:
  ;;  $0: temp, === 7
  ;;  $1: j, while index
  ;;  $2: p
  ;;  $3: t
  ; t = upper ;; t is $3
  shri $2 7 ; p >>= 7 ;; p is lower is $2
  clr $1 ; j = 0
  movi $0 7 ; temp = 7
p8_while_start:
  xor $2 $3 ; p ^= t
  shri $3 1 ; t >>= 1
  incr $1 ; j++
  cmp $0 $1 ; j == 7 ?
  beqil p8_while_end
  jmpil p8_while_start
p8_while_end:
  andi $2 1 ; p &= 1
  shli $2 1 ; p <<= 1
  movi $0 252
  st $2 $0 ; mem[252] = parity = p

  ;; Then we deal with p4
  ;;  $2: p
  ;;  $3: t
  movil $0 13 ; temp = 253
  ld $3 $0 ; t = mem[253] = upper
  movil $0 8 ; temp = 248
  and $3 $0 ; t &= 248
  movil $0 14 ; temp = 254
  ld $2 $0 ; p = mem[254] = lower
  shri $2 4 ; p >>= 4
  andi $2 7 ; p &= 7
  or $3 $2 ; t |= p
  ld $2 $0 ; p = mem[254] = lower
  shri $2 3 ; p >>= 3
  clr $1 ; j = 0
  movi $0 7 ; temp = 7
p4_while_start:
  xor $2 $3 ; p ^= t
  shri $3 1 ; t >>= 1
  incr $1 ; j++
  cmp $0 $1 ; j == 7 ?
  beqil p4_while_end
  jmpil p4_while_start
p4_while_end:
  andi $2 1 ; p &= 1
  movi $0 252
  ld $1 $0 ; $1 = parity = mem[252]
  or $1 $2 ; parity |= p
  shli $1 1 ; parity <<= 1

  ;; Then we deal with p2
  ;;  $0: temp
  ;;  $1: parity
  ;;  $2: p
  ;;  $3: t
  movil $0 14 ; temp = 254
  ld $2 $0 ; p = mem[254] = mem[temp] = lower
  shri $2 1 ; p >>= 1
  mov $3 $2 ; t = p
  shri $3 1 ; t >>= 1
  xor $2 $3 ; p ^= t
  shri $3 3 ; t >>= 3
  xor $2 $3 ; p ^= t
  shri $3 1 ; t >>= 1
  xor $2 $3 ; p ^= t
  movil $0 13 ; temp = 253
  ld $3 $0 ; t = mem[253] = mem[temp] = upper
  shri $3 1 ; t >>= 1
  xor $2 $3 ; p ^= t
  shri $3 1 ; t >>= 1
  xor $2 $3 ; p ^= t
  shri $3 3 ; t >>= 3
  xor $2 $3 ; p ^= t
  shri $3 1 ; t >>= 1
  xor $2 $3 ; p ^= t
  andi $2 1 ; p &= 1
  or $1 $2 ; parity |= p
  shli $1 1 ; parity <<= 1
  movil $0 12 ; temp = 252
  st $1 $0 ; mem[temp] = parity

  ;; Finally we deal with p1
  clr $1 ; j = 0
  movil $0 14 ; temp = 254
  ld $2 $0 ; p = mem[254] = lower
  mov $3 $2 ; t = p
  shri $3 2 ; t >>= 2
  movi $0 3 ; temp = 3
p1_while1_start:
  xor $2 $3 ; p ^= t
  shri $3 2 ; t >>= 2
  incr $1 ; j++
  cmp $0 $1 ; j == 3 ?
  beqil p1_while1_end
  jmpil p1_while1_start
p1_while1_end:
  movi $0 253
  ld $3 $0 ; t = mem[253] = upper
  clr $1 ; j = 0
  movi $0 4 ; temp = 4
p1_while2_start:
  xor $2 $3 ; p ^= t
  shri $3 2 ; t >>= 2
  incr $1 ; j++
  cmp $0 $1 ; j == 4 ?
  beqil p1_while2_end
  jmpil p1_while2_start
p1_while2_end:
  andi $2 1 ; p &= 1
  movi $0 252 ; temp = 252
  ld $1 $0 ; $1 = parity = mem[252]
  or $1 $2

  ;; Correcting Parity Step
  ;;  $0: temp
  ;;  $1: parity
  ;;  $2: parity's copy, p
  ;;  $3: t
  clr $0 ; temp = 0
  clr $3 ; t = 0
  mov $2 $1 ; p = parity
  ;; ??? How to get if $2 > 8: ($2[0] or $2[1] or $2[2]) and $2[3]
  mov $0 $1 ; temp = parity
  shri $0 1 ; temp >>= 1
  or $2 $0 ; p |= temp ($2[1] or $2[0])
  shri $0 1 ; temp >>= 1
  or $2 $0 ; p |= temp ($2[2] or $2[1] or $2[0])
  shri $0 1 ; temp >>= 1
  and $2 $0 ; p |= temp ($2 > 8)
  andi $2 1 ; p &= 1
  incr $3 ; t = 1 (t++ from t = 0)
  cmp $2 $3 ; p == 0 -> p > 8
  beqil correct_parity_upper ; TODO
  jmpil check_correct_parity_lower
correct_parity_upper:
  movil $0 9 ; temp = 9
  sub $1 $0 ; parity -= temp
  sh $3 $1 ; t <<= parity
  movi $0 253
  ld $2 $0 ; $2 = upper = mem[253]
  xor $2 $3 ; upper ^= t
  st $2 $0 ; mem[253] = $2
  jmpil correct_parity_end
check_correct_parity_lower:
  clr $0
  cmp $1 $0 ; parity == 0
  beqil correct_parity_directly_to_end
  jmpil correct_parity_lower
correct_parity_directly_to_end:
  jmpil correct_parity_end
correct_parity_lower:
  incr $0 ; temp = 1 (temp++)
  sub $1 $0 ; parity -= 1
  sh $0 $1 ; temp <<= parity
  movi $1 254 ; temp = 254
  ld $2 $1 ; lower = mem[temp]
  xor $2 $0 ; lower ^= temp
  st $2 $1 ; mem[temp] = lower
correct_parity_end:

  ;; Writing back to memory
  movi $3 251 ; pointer = 251
  ld $0 $3 ; k = mem[pointer]
  movil $3 13 ; pointer = 253
  ld $1 $3 ; t = mem[pointer] ;; t = upper
  shli $1 4 ; t <<= 4
  movil $3 14 ; pointer = 254
  ld $2 $3 ; p = mem[pointer] ;; p = lower
  shri $2 2 ; p >>= 2
  andi $2 1 ; p &= 1
  or $1 $2 ; t |= p
  ld $2 $3 ; p = mem[pointer] ;; p = lower
  shri $2 3 ; p >>= 3
  andi $2 14 ; p &= 14
  or $1 $2 ; t |= p
  st $1 $0 ; mem[k] = t

  incr $0 ; k++
  movil $3 13 ; pointer = 253 ;; pointer -> upper
  ld $1 $3 ; t = mem[pointer] ;; t = upper
  shri $1 4 ; t >>= 4
  st $1 $0 ; mem[k] = t
  incr $0 ; k++
  movil $3 11 ; pointer = 251
  st $0 $3 ; mem[pointer] = k

  movil $3 15
  ld $0 $3 ; i = mem[255]
  movi $3 94 ; temp = 94
  cmp $0 $3 ; $cmp = temp == i
  beqil loop_end ; branch loop_end if i == 94
  jmpl $1 loop_start

loop_end:
  halt