from projecteuler.lib.primes import yield_primes

"""
$ time py_run projecteuler/10.py
142913828922                   
real    7m22.610s              
user    7m22.589s              
sys     0m0.008s
"""

s = 0
for x in yield_primes():
    if x >= 2000000:
        break
    s += x
print(s)
