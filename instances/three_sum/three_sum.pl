#!/usr/bin/env perl

use strict;
use diagnostics;

# WARNING: this script takes some time to run (about 20 mins).
# real    19m31.106s
# user    19m13.572s
# sys     0m5.872s
# (and this is on quite a good machine)

# This program tries to find a series of 7 distinct numbers for which the sum is minimal
# and where no 3 of the 7 sum up the same.
# examples of such a series are:
# 	1 2 4 8 16 32 64 = 127
#	0 1 2 4 8 16 32 = 63
#	0 1 2 4 7 13 24 = 51 => the proposed solution: An=An-1+An-2+An-3 (after the begining)

# A discussion of the difference series:
#	our original series followed the rule: An=An-1+An-2+An-3
#	Lets look at the difference series: 1 1 2 3 6  11
#	In formula: An-An-1=An-1+An-2+An-3-(An-2+An-3+An-4)=
#			An-1-An-4=(An-1-An-2)+(An-2-An-3)+(An-3-An-4)
#	So the difference series also has the same rule on it
#	Strange...

#
# The assumption is that the third series is the best one but I cannot prove it.
# lets see if this program proves it.

# note that the number of distinct sums of the sets of 3 is 7 choose 3 which is 7!/3!*4!
# which is 7*6*5/3*2=35. This gives a constraint on the best solutions which should give
# a series of 7 number for which the 3 groups sums range from 0 to 34 (inclusive). This
# is not possible since the smallest sum is 3 (0+1+2) and so the ideal solution will yield
# the sums 3-37 (inclusive).

# Our solution above gives the maximum sum of 7+13+24=44 and is not that far from the ideal.
# But it could be that it is not the ideal. This is what this program is supposed to check.
#
# So, what should the program do? Check all 7 number rising series for which the 3 top values
# add to less than 44 to see if they hold the condition that any 3 sum yields a distinct
# value. If so then we found a better solution than the proposed one. Unfortunately
# as the results of this program show, there is no better solution than the above which
# sums to 51.
#						Mark Veltzer

use Math::Combinatorics;

my($numbers)=30; # from 0 to $number numbers will be selected
my($series_size)=7; # size of the series
my($gurantee_size)=3; # size of group to guarantee is unique in sum

my @n = [0..$numbers];
my $combinat = Math::Combinatorics->new(count => $series_size,
	data => @n,
);

sub sum($) {
	my($arr)=$_[0];
	#print $arr."\n";
	my($sum)=0;
	for(my($i)=0;$i<=$#$arr;$i++) {
		$sum+=$arr->[$i];
	}
	return $sum;
}
#print sum([1,2,3])."\n";
my($counter)=0;
my(%results)=();
while(my @combo = $combinat->next_combination) {
	my $scomb = Math::Combinatorics->new(count => $gurantee_size,
		data => [@combo],
	);
	my(%hash)=();
	my($ok)=1;
	while((my @scombo = $scomb->next_combination) && $ok) {
		$counter++;
		if($counter%1000000==0) {
			print STDERR "done $counter\n";
		}
		#print join(' ', @scombo)."\n";
		my($sum)=sum(\@scombo);
		#print "sum is $sum\n";
		if(exists($hash{$sum})) {
			$ok=0;
		} else {
			$hash{$sum}=defined;
		}
		#print Math::Combinatorics->sum(@scombo)."\n";
	}
	if($ok) {
		#wow - found a groups that has no three sum identical -> print it out
		my($sum)=sum(\@combo);
		my($string)=join(' ', @combo);
		if(exists($results{$sum})) {
			$results{$sum}.="|".$string;
		} else {
			$results{$sum}=$string;
		}
	}
}
my(@rkeys)=keys %results;
my(@array)=sort {$a <=> $b} @rkeys;
for(my($i)=0;$i<10;$i++) {
	my($val)=$array[$i];
	print "value $val and series are $results{$val}\n";
}
