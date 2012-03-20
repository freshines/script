import sys

for line in sys.stdin:
    field = line.strip().split('\t')
    if len(field)<16:
       continue;
    print "%s\t%s\t%s" % (field[2].strip(),field[15].strip(),field[10].strip())
