#!/usr/bin/env python

"""
https://en.wikipedia.org/wiki/Birthday_problem
"""

import random
import tqdm

num = 1000000000

stat = 0
for i in range(1):
    s = set()
    found = False
    print("before random")
    birthdays = []
    for _i in tqdm.tqdm(range(num)):
        birthdays.append(random.randint(0, 365))
    # birthdays = [ random.randint(0, 365) for i in range(num)]
    print("after random")
    # print(birthdays)
    count_found = 0
    for birthday in tqdm.tqdm(birthdays):
        if birthday in s:
            count_found += 1
        s.add(birthday)
    #print(f"{count_found}")
    stat +=  count_found
    #input("press any key...")
print(f"{stat}")
