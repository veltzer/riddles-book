def yield_primes():
    n = 2
    primes = []
    while True:
        for p in primes:
            if n%p==0:
                break
        else:
            primes.append(n)
            yield n
        n += 1
