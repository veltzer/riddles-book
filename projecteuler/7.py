primes = []

n = 2

while True:
    for p in primes:
        if n%p==0:
            break
    else:
        primes.append(n)
        if len(primes)==10001:
            break
    n += 1

print(primes[-1])
