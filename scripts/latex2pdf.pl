#!/usr/bin/perl -w

use strict;
use diagnostics;
use File::Spec qw();
use File::Basename qw();

=head

This is a script that runs latex for us.
Why do we need this script ?
- to remove the output before we run latex so that we will be sure that we start clean.
if latex finds a file it will * reprocess * it and we don't want that, do we ?
- we need to run latex twice to create indexes and more.
- latex is way too verbose - we want to remove that output and only show it if there is
an error.
- in case we fail we want to make sure we remove the output.
- we want to run dvips and ps2pdf after.

Maybe more reasons will follow...

Take note of the argument we pass to latex:
- -interaction=nonstopmode - this means that latex will not stop and enter interactive
mode to ask the user what to do about an error (what is this behaviour anyway ?!?).
- -halt-on-error - this means that latex will stop on error.
- -output-directory - this tells pdflatex where the output folder is.

=cut

#parameters
# do you want debugging...
my($debug)=1;
# remove the tmp file for output at the end of the run? (this should be yes
# unless you want junk files hanging around in /tmp...)
my($remove_tmp)=1;

# print to stdout a file content
# this function is adjusted for the ugly output that pdflatex produces and so it
# only prints the lines between lines starting with '!' (including the actual lines
# starting with '!'). Apparently this is how pdflatex shows errors. Ugrrr...
sub printout($) {
	my($filename)=@_;
	if($debug) {
		print 'printing ['.$filename.']'."\n";
	}
	open(FILE,$filename) || die('unable to open ['.$filename.']');
	my($line);
	my($inerr)=0;
	while($line=<FILE>) {
		if($inerr) {
			print $line;
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
# this wraps calls to system()
sub my_system($) {
	my($cmd)=@_;
	if($debug) {
		print 'system ['.$cmd.']'."\n";
	}
	my($res)=system($cmd);
	if($debug) {
		print 'system returned ['.$res.']'."\n";
	}
	return $res;
}

# here we go...
my($input)=shift(@ARGV);
my($output)=shift(@ARGV);
my($output_dir)=File::Basename::dirname($output);
my($name)=File::Basename::fileparse($output,'.pdf');
my($dvi)=$output_dir.'/'.$name.'.dvi';
my($ps)=$output_dir.'/'.$name.'.ps';
# temporary file name to store errors...
my($volume,$directories,$myscript) = File::Spec->splitpath($0);
my($tmp_fname)='/tmp/'.$myscript.$$;
my($cmd)='latex -interaction=nonstopmode -halt-on-error -output-directory='.$output_dir.' '.$input.' > '.$tmp_fname.' 2> /dev/null';
if($debug) {
	print 'input is ['.$input.']'."\n";
	print 'output is ['.$output.']'."\n";
	print 'cmd is ['.$cmd.']'."\n";
	print 'name is ['.$name.']'."\n";
	print 'dvi is ['.$dvi.']'."\n";
	print 'ps is ['.$ps.']'."\n";
}
# first remove the output (if it exists)
if(-f $output) {
	unlink_check($output,1);
}
if(-f $dvi) {
	unlink_check($dvi,1);
}
if(-f $ps) {
	unlink_check($ps,1);
}
# we need to run the command twice!!! (to generate the table of contents and more)
for(my($i)=0;$i<2;$i++) {
	my($res)=my_system($cmd);
	if($res) {
		# error path
		# print the errors
		printout($tmp_fname);
		# remove the tmp file for the errors
		if($remove_tmp) {
			unlink_check($tmp_fname,1);
		}
		# make sure to the remove the output (we are in the error path)
		if(-f $dvi) {
			unlink_check($dvi,1);
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
		if($i==1) {
			chmod_check($dvi,1);
		}
	}
}
my($cmd2)='dvips '.$dvi.' -o '.$ps.' > '.$tmp_fname;
my($res)=my_system($cmd2);
if($res) {
	# error path
	# print the errors
	printout($tmp_fname);
	# remove the tmp file for the errors
	if($remove_tmp) {
		unlink_check($tmp_fname,1);
	}
	# make sure to the remove the output (we are in the error path)
	if(-f $ps) {
		unlink_check($ps,1);
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
	chmod_check($ps,1);
}
