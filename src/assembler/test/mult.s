  movil $0 9 ; $0 = a = 9
  movil $1 4 ; $1 = b = 4
  ; $2 = i = 0
  ; $3 = product = 0
loop_start:
  add $3 $0
  incr $2
  cmp $1 $2 ; cmp = b == i
  beqil loop_end
  jmpil loop_start
loop_end:
  halt ; product: $3