from projecteuler.lib.primes import yield_primes

s = 0
for x in yield_primes():
    if x >= 2000000:
        break
    print(x)
    s += x
print(s)
