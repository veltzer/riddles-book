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

TODO:
- add signal handling and cleanup nicely after myself.

=cut

#parameters
# do you want debugging...
my($debug)=0;
# remove the tmp file for output at the end of the run? (this should be yes
# unless you want junk files hanging around in /tmp...)
my($remove_tmp)=1;
# how many times to run 'latex(1)' ?
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
# this is a function that removes a file and can optionally die if there is a problem
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
		print STDERR 'system ['.$cmd.']'."\n";
	}
	my($res)=system($cmd);
	if($debug) {
		print STDERR 'system returned ['.$res.']'."\n";
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
my($tmp_fname)='/tmp/'.$myscript.$$.'.err';
my($tmp_output)='/tmp/'.$myscript.$$.'.pdf';
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
unlink_check($output,1,-f $output);
unlink_check($dvi,1,-f $dvi);
unlink_check($ps,1,-f $ps);
# we need to run the command twice!!! (to generate the table of contents and more)
for(my($i)=0;$i<$runs;$i++) {
	my($res)=my_system($cmd);
	if($res) {
		# error path
		# print the errors
		printout($tmp_fname);
		# remove the tmp file for the errors
		unlink_check($tmp_fname,1,$remove_tmp);
		# make sure to the remove the output (we are in the error path)
		unlink_check($dvi,1,-f $dvi);
		# exit with error code of the child...
		exit($res >> 8);
	} else {
		# everything is ok
		# remove the tmp file for the errors
		unlink_check($tmp_fname,1,$remove_tmp);
		# change the output to be unchangble (but only in the final run!)
		if($i==$runs-1) {
			chmod_check($dvi,1);
		}
	}
}
my($cmd2)='dvips '.$dvi.' -o '.$ps.' > '.$tmp_fname.' 2> /dev/null';
my($res)=my_system($cmd2);
if($res) {
	# error path
	# print the errors
	printout($tmp_fname);
	# remove the tmp file for the errors
	unlink_check($tmp_fname,1,$remove_tmp);
	# make sure to the remove the output (we are in the error path)
	unlink_check($ps,1,-f $ps);
	# exit with error code of the child...
	exit($res >> 8);
} else {
	# everything is ok
	# remove the tmp file for the errors
	unlink_check($tmp_fname,1,$remove_tmp);
	# change the output to be unchangble
	chmod_check($ps,1);
}
my($out_file);
if($qpdf) {
	$out_file=$tmp_output;
} else {
	$out_file=$output;
}
my($cmd3)='ps2pdf '.$ps.' '.$out_file.' > '.$tmp_fname;
$res=my_system($cmd3);
if($res) {
	# error path
	# print the errors
	printout($tmp_fname);
	# remove the tmp file for the errors
	unlink_check($tmp_fname,1,$remove_tmp);
	# make sure to the remove the output (we are in the error path)
	unlink_check($out_file,1,-f $out_file);
	# exit with error code of the child...
	exit($res >> 8);
} else {
	# everything is ok
	# remove the tmp file for the errors
	unlink_check($tmp_fname,1,$remove_tmp);
}
if($qpdf) {
	my($cmd4)='qpdf --linearize --force-version=1.5 '.$tmp_output.' '.$output.' > '.$tmp_fname.' 2> /dev/null';
	$res=my_system($cmd4);
	if($res) {
		# error path
		# print the errors
		printout($tmp_fname);
		# remove the tmp file for the errors
		unlink_check($tmp_fname,1,$remove_tmp);
		# make sure to the remove the output (we are in the error path)
		unlink_check($output,1,-f $output);
		# exit with error code of the child...
		exit($res >> 8);
	} else {
		# everything is ok
		# remove the tmp file for the errors
		unlink_check($tmp_fname,1,$remove_tmp);
		# change the output to be unchangble (but only in the second time!)
		chmod_check($output,1);
	}
}
