Some solutions discussed taking only the first K digits (12?)
and summing them since the other digits do not effect the first 10 digits.
This is wrong. I wrote 13_wrong.[py|txt] to demonstrate that.

The obvious solution is to use python's arbitrary precision int type and
just do the calculation.

The riddle was obviously written for languages where the limit on the size
of the integet is much lower than 50 digits and in that case a need for
writing a simple summing algorithm is needed. I wrote that too.
