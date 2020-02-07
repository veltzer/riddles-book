consider the function:
	N is the input
	If N is even then return N/2
	If N is odd then return N*3+1

If we start with 3 then we get:
	3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1 END

If we start with 7 then we get:
	7 -> 22 -> 11 -> 34 -> 17 -> 52 -> 26 -> 13 ->
	40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1 END

I guarantee to you that applying the function again and again will *always
lead to a 1*.

You need to calculate the number between 1 and 1000000 which generates
the longest series of this kind.
