#!/usr/bin/perl -w

use strict;
use diagnostics;

# This shows how to find in a constant number of arithmetic operations
# whether a number has exactly one bit turned on.
# the idea is that a number $i has only one bit iff it does not have any
# bits in common with its predecessor $i-1.
# 0 is an exception as it has no bits in common with it's predecessor (11...1)
# but also does not have a single bit lit.
# what is the reason for this?
# the predecessor of a number which only has one bit has all ones.
# a number has only one bit iff it's predecessor has all ones.
# lets assume that a number does not have all ones. That means that if
# we add one to it, it will not elongate. That means that it will not turn
# into a number with just one bit. This means that some of it ones will
# NOT change into zeros. This in turn means that it will have at least one
# bit in common with its successor.

for(my($i)=0;$i<1024;$i++) {
	# this version handles both 0 and other numbers
	my($is_one_bit)=$i>0?!(($i-1)&$i):0;
	# the next line is ok only if $i>0...
	#my($is_one_bit)=!(($i-1)&$i);
	if($is_one_bit) {
		print "found $i\n";
	}
}
