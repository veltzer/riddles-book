given two lists of values:
	A = [1,2,3,4]
	B = [1,2,3,4]

produce a partial order on their combinations like so:

[(1, 1)]
[(1, 2), (2, 1)]
[(1, 3), (2, 2), (3, 1)]
[(1, 4), (2, 3), (3, 2), (4, 1)]
[(2, 4), (3, 3), (4, 2)]
[(3, 4), (4, 3)]
[(4, 4)]

* Thanks to Iddo Lev for this puzzle
