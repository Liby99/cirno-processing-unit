# In this example, we first move a 1 to the register $0.
# Then we try to jump forward 5 instructions
# Right after the jump there's 5 consecutive increment
# But since there's a jump 5, only the fifth increment should be executed
# Therefore the result should be 1 incremented 1 time which is 2 (0b00000010)

movil $0 1
jmpi 5
incr $0
incr $0
incr $0
incr $0
incr $0
