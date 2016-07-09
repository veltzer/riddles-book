definition: A complete tree is binary tree which is full in all of its levels
with the possible exception of the last level. If the last level is not full
then all of it's nodes must be to the left side of the tree.

Examples of complete trees:

	O		O		O
      O   O	      O   O	      O   O
     O O O O	    O		     O O O

Example of incomplete trees:

	O		O		O
      O   O	      O   O	      O
     O O   O	    O    O	     O O

Write down an algorithm that receives the root of the tree and returns true/false
according to whether the tree is complete or not.
The API of the tree is simple: you get a node n and you have n.left() and n.right()
that return the left and right nodes coming out of that node. If there is no
left or right node then the methods return 'null'.
Offer several options for the algorithm and analyze it's performance.
