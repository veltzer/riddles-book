#!/usr/bin/perl -w

use strict;
use diagnostics;

# This shows how to find in a constant number of arithmetic operations
# whether a number has exactly one bit turned on.

for(my($i)=0;$i<1024;$i++) {
	my($is_one_bit)=$i>0?!(($i-1)&$i):0;
	if($is_one_bit) {
		print "found $i\n";
	}
}
