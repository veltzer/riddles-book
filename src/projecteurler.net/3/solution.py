#!/usr/bin/python3

largest = 2
num = 600851475143

loops = 0
while num!=1:
    loops+=1
    if num % largest == 0:
        num/=largest
    else:
        largest+=1
print(largest)
print(loops)
