The idea of this algorithm is to find a path from (x1,y1) to (x2,y2)
on a grid with boundaries where the path is of a given length.

How do we solve this ?

first we solve the single dimentional problem.

The data for the single dimentional problem is n,h1,h2 and at each
step we could either climb +1,-1 or 0 (stay at the same height).

First we need to make sure that n>=|h2-h1| (otherwise we have no
chance in making it).

Then, if we can only use +1 and -1, we need to make sure that 

			n-|h2-h1|

is an even number (otherwise we will not be able to balance each
+1 with an opposite direction -1).

Now we create an array of size n and fill it out this way:

+1, +1, ... ,+1,-1,-1, ... ,-1, +1,-1, +1,-1, +1,-1, ... ,+1,-1

	n-|h2-h1|			|h2-h1|

Now will mix the array up (need an efficient algorithm to do that).

Now well sum up the partial sums starting with h1 and that will be
the path.

Solving the same problem with height limitations is exactly the
same only after the mixing of the array will will run over the
partial sums and every time we see that we will pass the limits
we will run ONLY FORWARD and find a +1 or -1 to reverse the action
that we are about to take. We are guaranteed that we will find one
since the end result (h2) is within the limits. Then we will just
swap the current +1 or -1 with that +1 or -1 (which is of the
opposite sign). Now we will be safe. Doing this for the entire
array will create a path which is within the limits.

* problem - maybe in this way we are biasing the path to be more
"controlled" towards the end. I haven't found a way to get over that.

The 2 dimentional problem

Date: (x1,y1), (x2,y2), n, (maxx,maxy), (minx,miny).

We will create a path for x separetely using the 1 dimentional
algorithm and the same goes for y (with the right bounds).

Combining them will give us the right path.

Problems:

1) If we allow 0 in both x and y then it may happen that at some
point in the path both x and y will move by zero and so the point
will not change. We don't want that effect. Right now I don't
have a solution for this one but using swapping it could be made
to work (this is not a critical problem).

2) A deeper problem: The path could "step" over itself. This means
that it will revisit (x,y) locations that are already in its past.
I don't see any easy solution for this one.
