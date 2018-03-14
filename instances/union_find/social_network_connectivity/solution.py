class Algo:
    def __init__(self, n):
        self.n = n
        # standard union-find stuff
        self.root = [i for i in range(n)]
        # extra data for this exercise
        self.size = [1] * n

    # standard union-find methods
    def find_root(self, i):
        """returns the root"""
        while self.root[i] != i:
            i = self.root[i]
        return i

    def union(self, i, j):
        """returns the new root"""
        ri = self.find_root(i)
        rj = self.find_root(j)
        if ri == rj:
            return
        self.root[ri] = rj
        self.size[rj] = self.size[ri] + self.size[rj]
        if self.size[rj] == self.n:
            print('stop at {0},{1}', i, j)
        return rj


s = Algo(6)
s.union(2, 3)
s.union(3, 4)
s.union(0, 1)
s.union(0, 3)
s.union(5, 2)
s.union(1, 2)
