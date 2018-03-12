(1 + 2 + ... + n)^2 = (n*(n+1)/2)^2 = n^2 * (n+1)^2 * 1/4
= n^2 * (n^2 + 2*n + 1) * 1/4 = (n^4 + 2*n^3 + n^2) * 1/4
= n^4/4 + n^3/2 + n^2/4

There is a formula as to the sum of the first n natural numbers:
1^2 + 2^2 + ... + n^2 = n * (n+1) * (2n+1) * 1/6 =
n^3/3 + n^2/2 + n/6

so the result is:

n^4/4 + n^3/2 + n^2/4 - ( n^3/3 + n^2/2 + n/6 ) =
n^4/4 + n^3/6 - n^2/4 - n/6

If we want to have the whole calculation done with integers we can rewrite
the formula above as:

(3*n^4 + 2*n^3 - 3*n^2 - 2*n)/12
