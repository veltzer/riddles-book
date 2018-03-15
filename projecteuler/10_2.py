"""
solve using a sieve. much faster. 5 seconds instead of 7 minutes.

time py_run projecteuler/10_2.py  
142913828922

real    0m5.759s
user    0m5.758s
sys     0m0.001s
"""
from BitVector import BitVector
from math import sqrt
limit = 2000000
# limit = 100
to = int(sqrt(limit))
b=BitVector(size=limit)

n = 2
while n < to:
    if b[n] == 0:
        k = n*n
        while k < limit:
            b[k]=1
            k+=n
    n += 1
"""
for x in range(limit):
    if b[x] == 0:
        print(x)
"""
# calculate sum of the primes
s = 0
for n in range(2, limit):
    if b[n] == 0:
        s += n
print(s)
