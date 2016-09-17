#!/usr/bin/python3

def sums_to_target(data, k):
        data.sort()
        lhs=0
        rhs=len(data)-1
        while lhs < rhs:
            current_sum=data[lhs]+data[rhs]
            if current_sum==k:
                return True
            elif current_sum<k:
                lhs+=1
            else:
                rhs-=1
        return False

def all_pairs(data, k):
        data.sort()
        lhs=0
        rhs=len(data)-1
        results=[]
        while lhs < rhs:
            current_sum=data[lhs]+data[rhs]
            if current_sum==k:
                results.append((data[lhs], data[rhs]))
                lhs+=1
                rhs-=1
            elif current_sum<k:
                lhs+=1
            else:
                rhs-=1
        return results

data=[2**x for x in range(10)]
print(data)
for i in range(10):
    print(i, sums_to_target(data, i))

data=[x for x in range(10)]
print(data)
for i in range(10):
    print(i, all_pairs(data, i))
