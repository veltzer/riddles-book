"""
This is an example of how to estimate pi according to the statistical solution
of the PI estimation riddle

As you can see it takes quite a long time to get a to a good estimation of PI.
"""

import random  # for uniform
import math  # for hypot

samples = 1000000
good_samples = 0
print_every = 100000
i = 0
while True:
    x = random.uniform(-0.5, 0.5)
    y = random.uniform(-0.5, 0.5)
    if math.hypot(x, y) <= 0.5:
        good_samples += 1
    pi = (float(good_samples) / float(i + 1)) * 4
    if i % print_every == 0:
        print(pi)
    i += 1
