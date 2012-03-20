import sys
last=''
lastv=''
for line in sys.stdin:
    x = line.strip().split('\t')
    if last==x[0]:
        if lastv != '':
            print "%s\t%s" % (lastv, last)
            lastv=''
        print "%s\t%s" % (x[1], x[0])
    else:
        last = x[0]
        lastv = x[1]
