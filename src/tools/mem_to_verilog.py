import sys
outfile = open(sys.argv[2], 'w')
i = 0
with open(sys.argv[1]) as f:
    for line in f:
        line = line[:-1]
        outfile.write("mem[%d] = 8'b%s;\n" % (i, line))
        i += 1