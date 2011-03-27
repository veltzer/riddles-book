#!/usr/bin/perl

# this tests the solution to the hats riddle

my($num_people)=4;
my($cycles)=1;

#my($a)=-1;
#my($b)=4;
#print ($a%$b)."\n";

for(my($cycle)=0;$cycle<$cycles;$cycle++) {
	# put hats on people (with repetitions of colors)
	my(@hats)=[];
	my($sum)=0;
	for(my($i)=0;$i<$num_people;$i++) {
		#my($curr_hat)=int(rand($num_people));
		my($curr_hat)=$i;
		$hats[$i]=$curr_hat;
		$sum+=$curr_hat;
	}
	# print the hats
	print join(' ',@hats)."\n";
	# make guesses
	my(@guess)=[];
	for(my($i)=0;$i<$num_people;$i++) {
		my($curr_guess)=($i-($sum-$hats[$i]))%$num_people;
		$guess[$i]=$curr_guess;
	}
	# print the guesses
	print join(' ',@guess)."\n";
	# count number of successful guesses
	my($succ)=0;
	for(my($i)=0;$i<$num_people;$i++) {
		if($guess[$i]==$hats[$i]) {
			$succ++;
		}
	}
	# closeness
	my(@close)=[];
	for(my($i)=0;$i<$num_people;$i++) {
		$close[$i]=$guess[$i]-$hats[$i];
		if($close[$i]<0) {
			$close[$i]+=$num_people;
		}
	}
	print join(' ',@close)."\n";
	# print number of successes
	print "$cycle: $succ\n";
	if($succ!=1) {
		die("bad success");
	}
}
