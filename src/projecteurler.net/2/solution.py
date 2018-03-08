#!/usr/bin/python3

(a,b) = 1,1
sum = 0
while b<4000000:
    (a,b) = (b, a+b)
    if b % 2==0:
        sum += b
print(sum)
