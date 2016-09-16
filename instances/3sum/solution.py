#!/usr/bin/python

data=[22,1,7,2,3,19]

def naive(data):
    ''' this is n^3 complexity '''
    results=[]
    for p1, x1 in enumerate(data):
        for p2, x2 in enumerate(data[p1+1:]):
            for x3 in data[p1+p2+2:]: 
                if x1+x2==x3:
                    results.append((x1,x2,x3))
                if x2+x3==x1:
                    results.append((x1,x2,x3))
                if x1+x3==x2:
                    results.append((x1,x2,x3))
    results.sort()
    return results

def binary_search(array, target):
    lower = 0
    upper = len(array)
    while lower < upper:   # use < instead of <=
        x = lower + (upper - lower) // 2
        val = array[x]
        if target == val:
            return x
        elif target > val:
            if lower == x:   # this two are the actual lines
                break        # you're looking for
            lower = x
        elif target < val:
            upper = x

def better(data):
    ''' this is n^2*log(n) complexity '''
    results=[]
    s_data=sorted(data)
    for p1, x1 in enumerate(data):
        for x2 in data[p1+1:]:
            if binary_search(s_data, x1+x2) is not None:
                results.append((x1,x2,x1+x2))
    results.sort()
    return results

print(naive(data))
print(better(data))
