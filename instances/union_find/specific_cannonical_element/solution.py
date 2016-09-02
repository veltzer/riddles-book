#!/usr/bin/python3

class Algo:
    def __init__(self, n):
        self.n=n
        # standard union-find stuff
        self.root=[i for i in range(n)]
        # extra data for this exercise
        self.largest=[i for i in range(n)]
    # standard union-find methods
    def find_root(self, i):
        'returns the root'
        while self.root[i]!=i:
            i=self.root[i]
        return i
    def union(self, i, j):
        'returns the new root'
        ri=self.find_root(i)
        rj=self.find_root(j)
        self.root[ri]=rj
        self.largest[rj]=max(self.largest[ri], self.largest[rj])
        return rj
    # methods for this exercise
    def find(self, i):
        r=self.find_root(i)
        return self.largest[r]
    def print(self):
        print('================================')
        print([self.find_root(i) for i in range(self.n)])
        print([self.find(i) for i in range(self.n)])
        print('================================')


s=Algo(15)
s.print()
s.union(10,11)
s.print()
s.union(11,12)
s.print()
s.union(12,13)
s.print()
s.union(13,14)
s.print()
s.union(2,5)
s.union(5,8)
s.print()
