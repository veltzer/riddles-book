#!/usr/bin/python

import math
import sys

n=77031
for i in range(2,int(math.sqrt(n))):
	if n%i==0:
		print "no", i
		sys.exit(0)
print "yes"
