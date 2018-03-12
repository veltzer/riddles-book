import sys

def palindrom(i: int):
    s = str(i)
    return s==s[::-1]


top = 999

to_scan = 0
loops = 0
try:
    while True:
        for i in range(to_scan+1):
            for a,b in zip(range(top, top-to_scan-1, -1), range(top-to_scan, top+1, 1)):
                loops += 1
                if palindrom(a*b):
                    print(a*b, a, b, loops)
                    raise ValueError("over")
        to_scan += 1
except ValueError as e:
    pass

# a different approach

for i in range(999*999, 1, -1):
    if palindrom(i):
        # check that it is not a prime
        for j in range(100, 999):
            if i%j==0 and i//j< 1000:
                print(i, j, i//j, loops)
                sys.exit(0)
            loops+=1
    else:
        loops += 1
