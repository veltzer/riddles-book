#!/usr/bin/python3

"""
Solution to the midgets riddle in python3

	Mark Veltzer <mark@veltzer.net>
"""

import random
# for deterministic behaviour
#random.seed(7)

atfound=0
for x in range(1000):
	l=list(range(100))
	random.shuffle(l)
	# number of midgets finding their number
	found=0
	for m in range(100):
		tries=0
		pos=m
		while tries<50 and l[pos]!=m:
			pos=l[pos]
			tries+=1
		if l[pos]==m:
			found+=1
	if found==100:
		atfound+=1
	#print(found)
print(atfound)
