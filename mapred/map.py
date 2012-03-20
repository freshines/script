#!/usr/bin/python
import sys

for line in sys.stdin:
    field = line.strip().split('\t')
    if len(field)<2:
       continue;
    print "%s\t1" % (field[1].strip())
