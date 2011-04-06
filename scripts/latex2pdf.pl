#!/usr/bin/perl -w

use strict;
use diagnostics;
use File::Spec qw();
use File::Basename qw();

=head

This is a script that runs pdflatex for us.
Why do we need this script ?
- to remove the output before we run pdflatex so that we will be sure that we start clean.
if pdflatex finds a file it will * reprocess * it and we don't want that, do we ?
- we need to run pdflatex twice to create indexes and more.
- pdf latex is way too verbose - we want to remove that output and only show it if there is
an error.
- in case we fail we want to make sure we remove the output.

Maybe more reasons will follow...

=cut

#parameters
# do you want debugging...
my($debug)=1;
# remove the tmp file for output at the end of the run? (this should be yes
# unless you want junk files hanging around in /tmp...)
my($remove_tmp)=1;

# print to stdout a file content
sub printout($) {
	my($filename)=@_;
	open(FILE,$filename) || die('unable to open ['.$filename.']');
	my($line);
	while($line=<FILE>) {
		print $line;
	}
	close(FILE) || die('unable to close ['.$filename.']');
}
# this is a function that removes a file and can optionally die if there is a problem
sub unlink_check($$) {
	my($file,$check)=@_;
	if($debug) {
		print 'unlinking ['.$file.']'."\n";
	}
	my($ret)=unlink($file);
	if($check) {
		if($ret!=1) {
			die('problem unlinking file ['.$file.']');
		}
	}
}
# this is a function that removes a file and can optionally die if there is a problem
sub chmod_check($$) {
	my($file,$check)=@_;
	if($debug) {
		print 'chmodding ['.$file.']'."\n";
	}
	my($ret)=chmod(0444,$file);
	if($check) {
		if($ret!=1) {
			die('problem chmodding file ['.$file.']');
		}
	}
}

# here we go...
my($input)=shift(@ARGV);
my($output)=shift(@ARGV);
my($output_dir)=File::Basename::dirname($output);
# temporary file name to store errors...
my($volume,$directories,$myscript) = File::Spec->splitpath($0);
my($tmp_fname)='/tmp/'.$myscript.$$;
my($cmd)='pdflatex -output-directory '.$output_dir.' '.$input.' > '.$tmp_fname;
if($debug) {
	print 'input is ['.$input.']'."\n";
	print 'output is ['.$output.']'."\n";
	print 'cmd is ['.$cmd.']'."\n";
}
# first remove the output (if it exists)
if(-f $output) {
	unlink_check($output,1);
}
# we need to run the command twice!!! (to generate the index and more)
for(my($i)=0;$i<2;$i++) {
	my($res)=system($cmd);
	if($debug) {
		print 'system returned ['.$res.']'."\n";
	}
	if($res) {
		# error path
		# print the errors
		printout($tmp_fname);
		# remove the tmp file for the errors
		if($remove_tmp) {
			unlink_check($tmp_fname,1);
		}
		# exit with error code of the child...
		exit($res << 8);
	} else {
		# everything is ok
		# remove the tmp file for the errors
		if($remove_tmp) {
			unlink_check($tmp_fname,1);
		}
		# change the output to be unchangble...
		chmod_check($output,1);
	}
}
