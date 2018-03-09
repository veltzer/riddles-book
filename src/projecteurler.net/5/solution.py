#!/usr/bin/python3

"""
The idea is very simple, take the prime factors of all the numbers from 1 to 20
and raise each one of them to the power which is the maximum power in which they
appear between 1 and 20.

for example:
    2 appears to the power of 4 in 16 so 2 is to the power of 4
    3 is to the power of 2 (9)
    5 is to the power of 1.
    7 is to the power of 1.
    11 -> 1
    13 -> 1
    17 -> 1
    19 -> 1

so the solution is:
"""

print(2**4*3**2*5*7*11*13*17*19)
