"""
Solution to the midgets riddle in python3

    Mark Veltzer <mark@veltzer.net>
"""

import random

# for deterministic behaviour
# random.seed(7)

atfound = 0
for x in range(1000):
    my_list = list(range(100))
    random.shuffle(my_list)
    # number of midgets finding their number
    found = 0
    for m in range(100):
        tries = 0
        pos = m
        while tries < 50 and my_list[pos] != m:
            pos = my_list[pos]
            tries += 1
        if my_list[pos] == m:
            found += 1
    if found == 100:
        atfound += 1
    # print(found)
print(atfound)
