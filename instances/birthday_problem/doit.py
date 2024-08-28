#!/usr/bin/env python3

# https://en.wikipedia.org/wiki/Birthday_problem

import random

stat = 0
for i in range(1000000):
    p = random.randint(0, 1)
    #print(p)
    count = 1
    while p != 1:
        p = random.randint(0, 1)
        count += 1
        #print(p)
    # print(f"count is {count}")
    stat += count
print(f"average is {stat/1000000}")
