given an integer x and a sorted array a[] of n distinct integers, design a linear-time algorithm to determine if there exists two distinct indices i and j such that a[i]+a[j]==x.
What happens if the array is not sorted?
What happens if you need to return all the pairs which add to x?

The idea of the solution is to advance from both the top of the array and the bottom.
lets assume the higher numbers are at the top.
When we see that the sum is bigger than x we reduce it by moving the top pointer lower (this decreases the sum).
When we see that the sum is smaller than x we increase it by moving the bottom pointer up (this increases the sum). 
If the pointeres meet we stop.
If we see the sum we stop.

Why is this correct?
Assume that the real answer is i and j.
We arrive at either i or j with one of our pointers. Why is this true? Well if not then we stop searching
outside the range but the sum outside the range is larger than the sum in the range. Contradiction.
So we arrive at either i or j with one of our pointers. Lets call say that the first pointer to arrive is i 
(without loosing generality). At the moment of it's arrival the sum is larger than the required. and will
continue to be so until the other pointer joins at j. The same for the reverse.

And now for the more general question:
given an array of n numbers, can you determine if there are two elements in the array that sum to x?

- brute force (double iteration) will be n^2.

- hashing: hash all elements of the array (n*log(n))
	then for every element e look for x-e in the hash
	that will be n*log(n) too.
	Expected time will be O(n).

- sorting and binary search
	sort the array (n*log(n)).
	now for each element e search for x-e using binary search (n*log(n)).
	all in all: n*log(n)

- sorting and using the above solution.

References:
https://web.stanford.edu/class/cs9/lectures/06/TwoSum.pdf
