#!/usr/bin/perl -w

use strict;
use diagnostics;
use File::Spec qw();
use File::Basename qw();

=head

This script analyzes latex files and produces dependency information for them.

Current it just scans for lines like:
\input{out/sketch-test.tex}
and outputs dependency information in 'make' like fashion.

=cut

#parameters
# do you want debugging...
my($debug)=0;

# here we go...
my($input)=shift(@ARGV);
my($output)=shift(@ARGV);

my($line);
open(FILE,$input) || die('unable to open input file ['.$input.']');
open(OUT,'> '.$output) || die('unable to open output file ['.$output.']');
my(@list);
print OUT $input.': ';
while($line=<FILE>) {
	if($line=~/^\\input{.+}/) {
		my($file)=($line=~/^\\input{(.+)}/);
		push(@list,$file);
	}
}
print OUT join(' ',@list)."\n";
close(FILE) || die('unable to close input file ['.$input.']');
close(OUT) || die('unable to close output file ['.$output.']');
