#!/usr/bin/python3

class Tree(object):
	def __init__(self):
		self.left = None
		self.right = None


'''
recursive solution, not very effective since it always scans the entire tree
it's better to scan top to bottom to stop if one of the levels is not full but
this one will scan everything.
returns height, complete, last level full
'''
def complete_tree(t):
	if t is None:
		return (0, True, True)
	else:
		(lh, labl, llll)=complete_tree(t.left) 
		(rh, rabl, rlll)=complete_tree(t.right) 
		if lh<rh:
			return (rh+1, False, False)
		if lh==rh:
			if llll:
				return (rh+1, rabl, rlll)
			else:
				return (rh+1, False, False)
		if lh==rh+1:
			return (lh+1, rlll, False)
		if lh>rh+1:
			return (lh+1, False, False)

t1=Tree()
assert complete_tree(t1)[1]

t2=Tree()
t2.left=Tree()
t2.right=Tree()
assert complete_tree(t2)[1]

t3=Tree()
t3.left=t2
t3.right=t2
assert complete_tree(t3)[1]

t4=Tree()
t4.right=t1
t4.left=Tree()
t4.left.left=t1
assert complete_tree(t4)[1]

t5=Tree()
t5.left=t2
t5.right=Tree()
t5.right.left=t1
assert complete_tree(t5)[1]

t6=Tree()
t6.left=t2
t6.right=Tree()
t6.right.right=t1
assert not complete_tree(t6)[1]

t7=Tree()
t7.left=Tree()
t7.left.left=t1
t7.right=Tree()
t7.right.left=t1
assert not complete_tree(t7)[1]

t8=Tree()
t8.left=t2
assert not complete_tree(t8)[1]
