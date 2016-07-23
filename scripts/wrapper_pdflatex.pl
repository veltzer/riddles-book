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

Take note of the argument we pass to pdflatex:
- -interaction=nonstopmode - this means that latex will not stop and enter interactive
mode to ask the user what to do about an error (what is this behaviour anyway ?!?).
- -halt-on-error - this means that latex will stop on error.
- -output-directory - this tells pdflatex where the output folder is.

=cut

#parameters
# do you want debugging...
my($debug)=0;
# remove the tmp file for output at the end of the run? (this should be yes
# unless you want junk files hanging around in /tmp...)
my($remove_tmp)=1;
# how many times to run 'pdflatex(1)' ?
my($runs)=2;
# do you want to run the 'qpdf' post processing stage?
my($qpdf)=1;

# print to stdout a file content
# this function is adjusted for the ugly output that pdflatex produces and so it
# only prints the lines between lines starting with '!' (including the actual lines
# starting with '!'). Apparently this is how pdflatex shows errors. Ugrrr...
sub printout($) {
	my($filename)=@_;
	if($debug) {
		print STDERR 'printing ['.$filename.']'."\n";
	}
	open(FILE,$filename) || die('unable to open ['.$filename.']');
	my($line);
	my($inerr)=0;
	while($line=<FILE>) {
		if($inerr) {
			print STDERR $line;
			if($line=~/^\!/) {
				$inerr=0;
			}
		} else {
			if($line=~/^\!/) {
				print $line;
				$inerr=1;
			}
		}
	}
	close(FILE) || die('unable to close ['.$filename.']');
}
# this is a function that removes a file and can optionally die if there is a problem
sub unlink_check($$$) {
	my($file,$check,$doit)=@_;
	if($doit) {
		if($debug) {
			print STDERR 'unlinking ['.$file.']'."\n";
		}
		my($ret)=unlink($file);
		if($check) {
			if($ret!=1) {
				die('problem unlinking file ['.$file.']');
			}
		}
	}
}
# this is a function that chmods a file and can optionally die if there is a problem
sub chmod_check($$) {
	my($file,$check)=@_;
	if($debug) {
		print STDERR 'chmodding ['.$file.']'."\n";
	}
	my($ret)=chmod(0444,$file);
	if($check) {
		if($ret!=1) {
			die('problem chmodding file ['.$file.']');
		}
	}
}
# this wraps calls to system()
sub my_system($) {
	my($cmd)=@_;
	if($debug) {
		print STDERR 'my_system ['.$cmd.']'."\n";
	}
	my($res)=system($cmd);
	if($debug) {
		print STDERR 'my_system res is ['.$res.']'."\n";
	}
	return $res;
}
# this is a function that renames a file and dies if there is a problem 
sub my_rename($$$) {
	my($old,$new,$check)=@_;
	if($debug) {
		print STDERR 'my_rename ['.$old.','.$new.']'."\n";
	}
	my($ret)=rename($old,$new);
	if($check) {
		if($ret!=1) {
			die('my_rename problem ['.$old.','.$new.']');
		}
	}
}

# here we go...
my($input)=shift(@ARGV);
my($output)=shift(@ARGV);
my($output_dir)=File::Basename::dirname($output);
# temporary file name to store errors...
my($volume,$directories,$myscript)=File::Spec->splitpath($0);
my($tmp_fname_out)='/tmp/'.$myscript.$$.'.out';
my($tmp_fname_err)='/tmp/'.$myscript.$$.'.err';
#my($tmp_output)='/tmp/'.$myscript.$$.'.pdf';
my($cmd)='pdflatex -interaction=nonstopmode -halt-on-error -output-directory '.$output_dir.' '.$input.' > '.$tmp_fname_out.' 2> '.$tmp_fname_err;
if($debug) {
	print 'input is ['.$input.']'."\n";
	print 'output is ['.$output.']'."\n";
	print 'cmd is ['.$cmd.']'."\n";
}
# first remove the output (if it exists)
unlink_check($output,1,-f $output);
# we need to run the command twice!!! (to generate the index and more)
for(my($i)=0;$i<$runs;$i++) {
	my($res)=my_system($cmd);
	if($res) {
		# error path
		# print the errors
		printout($tmp_fname_out);
		printout($tmp_fname_err);
		# remove the tmp file for the errors
		unlink_check($tmp_fname_out,1,$remove_tmp);
		unlink_check($tmp_fname_err,1,$remove_tmp);
		# make sure to the remove the output (we are in the error path)
		unlink_check($output,1,-f $output);
		# exit with error code of the child...
		exit($res >> 8);
	} else {
		# everything is ok
		# remove the tmp file for the errors
		unlink_check($tmp_fname_out,1,$remove_tmp);
		unlink_check($tmp_fname_err,1,$remove_tmp);
		# change the output to be unchangble (but only in the final run!)
		if($i==$runs-1) {
			chmod_check($output,1);
			my($name,$path,$suffix)=File::Basename::fileparse($output, qw(.pdf));
			my($output_base)=File::Spec->catfile($path,$name);
			unlink_check($output_base.'.log',1,1);
			unlink_check($output_base.'.out',1,1);
			unlink_check($output_base.'.toc',1,1);
			unlink_check($output_base.'.aux',1,1);
		}
	}
}
if($qpdf) {
	# move the output to the new place
	my($tmp_output)=$output.'.pdf';
	my_rename($output,$tmp_output,1);
	# I also had '--force-version=1.5' but it is not needed since I use pdflatex and pdftex with the right version there...
	my($cmd4)='qpdf --linearize '.$tmp_output.' '.$output.' > '.$tmp_fname_out.' 2> '.$tmp_fname_err;
	my($res)=my_system($cmd4);
	if($res) {
		# error path
		# print the errors
		printout($tmp_fname_out);
		printout($tmp_fname_err);
		# remove the tmp file for the errors
		unlink_check($tmp_fname_out,1,$remove_tmp);
		unlink_check($tmp_fname_err,1,$remove_tmp);
		# remove the temporary file...
		unlink_check($tmp_output,1,1);
		# make sure to the remove the output (we are in the error path)
		unlink_check($output,1,-f $output);
		# exit with error code of the child...
		exit($res >> 8);
	} else {
		# everything is ok
		# remove the temporary file...
		unlink_check($tmp_output,1,1);
		# remove the tmp file for the errors
		unlink_check($tmp_fname_out,1,$remove_tmp);
		unlink_check($tmp_fname_err,1,$remove_tmp);
		# change the output to be unchangble (but only in the second time!)
		chmod_check($output,1);
	}
}
