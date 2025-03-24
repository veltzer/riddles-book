#!/usr/bin/env python

"""
Solutiib
"""

for to in [10, 100, 1000, 10000]:
    i = 0
    total = 0
    while i < to:
        s = str(i)
        for x in s.split("0"):
            if x != "":
                total += int(x)
        i += 1
    print(total)
