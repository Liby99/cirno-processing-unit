def printresult(num, acc, bool):
    if (bool):
        print("prog3 test%d acc%d SUCCEEDED" % (num, acc))
    else:
        print("prog3 test%d acc%d FAILED" % (num, acc))

with open('result/prog3_result1.mem', 'r+') as f:
    for line in f:
        if line.startswith('193'):
            printresult(1,2,line == '193 00000000\n')
        if line.startswith('194'):
            printresult(1,1,line == '194 00111111\n')

with open('result/prog3_result2.mem', 'r+') as f:
    for line in f:
        if line.startswith('193'):
            printresult(1,2,line == '193 01000000\n')
        if line.startswith('194'):
            printresult(1,1,line == '194 01111111\n')

with open('result/prog3_result3.mem', 'r+') as f:
    for line in f:
        if line.startswith('193'):
            printresult(1,2,line == '193 01000000\n')
        if line.startswith('194'):
            printresult(1,1,line == '194 10000000\n')
        