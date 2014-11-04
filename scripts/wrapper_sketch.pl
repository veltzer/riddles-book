#!/usr/bin/perl -w

use strict;
use diagnostics;
use File::Spec qw();
use File::Basename qw();

=head

This is a script that wraps the execution of 'sketch'.

Why?
- too noisy on the command line when everything is right.
- does not cleanly separate warning and errors (stdout vs stderr).

=cut

#parameters
# do you want debugging...
my($debug)=0;
# remove the tmp file for output at the end of the run? (this should be yes
# unless you want junk files hanging around in /tmp...)
my($remove_tmp)=1;

# print to stderr a file content
sub printout($) {
	my($filename)=@_;
	if($debug) {
		print 'printing ['.$filename.']'."\n";
	}
	open(FILE,$filename) || die('unable to open ['.$filename.']');
	my($line);
	while($line=<FILE>) {
		print STDERR $line;
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
my($cmd)='sketch '.$input.' -o '.$output.' 2> '.$tmp_fname.' > /dev/null';
if($debug) {
	print 'input is ['.$input.']'."\n";
	print 'output is ['.$output.']'."\n";
	print 'cmd is ['.$cmd.']'."\n";
}
# first remove the output (if it exists)
if(-f $output) {
	unlink_check($output,1);
}
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
	# make sure to the remove the output (we are in the error path)
	if(-f $output) {
		unlink_check($output,1);
	}
	# exit with error code of the child...
	exit($res >> 8);
} else {
	# everything is ok
	# remove the tmp file for the errors
	if($remove_tmp) {
		unlink_check($tmp_fname,1);
	}
	# change the output to be unchangble (but only in the second time!)
	chmod_check($output,1);
}
