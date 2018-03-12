s = 0
for x in primes.yield_primes():
    if x >= 2000000:
        break
    print(x)
    s += x
print(s)
