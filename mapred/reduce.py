import sys
dict = {}
for line in sys.stdin:
    x = line.strip().split('\t')
    if x[0] not in dict:
        dict[x[0]] = int(x[1])
    else:
        dict[x[0]] += int(x[1])
for key in dict.keys():
    print key, '\t', dict[key]
