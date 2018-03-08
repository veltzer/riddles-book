#!/usr/bin/python3

# it means that we are looking at 3 different series here:
# 3, 6, 9, ..., 999
# and
# 5, 10, 15, ..., 995
# these are arithmetic series.
# the problem is that some number (like 15) can be divided
# by both 3 and 5.
# and this means that we need to subtract all numbers that
# are divisible by 15 which are:
# 15, 30, 45, ..., 990
# the sum of an arithmetic series of jumps of the form:
# q, 2*q, ..., n*q is q*(1 + 2 + 3 + n) = q*n*(n+1)/2
# and so our some is:
# 3*333*334/2 + 5*199*200/2 - 15*66*67/2
# which is:
# 166833+99500-33165
# 233168
# below is a testing program:


sum = 0
for r in range(3, 1002, 3):
    sum += r
for r in range(5, 1000, 5):
    sum += r
for r in range(15, 1005, 15):
    sum -= r
assert sum==233168
