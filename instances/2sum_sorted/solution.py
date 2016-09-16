#!/usr/bin/python3

data=[2**x for x in range(10)]

def sums_to_target(data, k):
        data.sort()
        lhs=0
        rhs=len(data)-1
        while lhs < rhs:
            sum=data[lhs]+data[rhs]
            if sum==k:
                return True
            elif sum<k:
                lhs+=1
            else:
                rhs-=1
        return False

print(data)
for i in range(10):
    print(i, sums_to_target(data, i))
