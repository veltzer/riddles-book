#!/usr/bin/env python

"""
Solution better
"""

size=77050
arr = [None] * size

max_value=-1
max_position=-1
for i in range(1, size):
    if i%1000==0:
        print("got to", i)
    count = 0
    series=[]
    n = i
    while n!=1:
        if n>len(arr):
            diff=n-len(arr)+1
            extra_array=[None]*diff
            arr.extend(extra_array)
            print("extended to", len(arr))
        if arr[n] is not None:
            count = arr[n]+len(series)
            for k in series:
                arr[k]=count
                count-=1
            break
        series.append(n)
        if n%2==0:
            n=n/2
        else:
            n=n*3+1
        count +=1
    if count>max_value:
        max_position=i
        max_value=count
print("max_position", max_position)
print("max_value", max_value)
