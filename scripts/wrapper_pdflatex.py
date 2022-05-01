#!/usr/bin/env python

import sys
import os
import os.path
import subprocess

"""
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

This python script is a rewrite of a similar script in perl.
"""

#parameters
# do you want debugging...
debug = False 
# remove the tmp file for output at the end of the run? (this should be yes
# unless you want junk files hanging around in /tmp...)
remove_tmp = True
# how many times to run 'pdflatex(1)' ?
runs = 2
# do you want to run the 'qpdf' post processing stage?
qpdf = True


def printout(filename: str):
    """
    print to stdout a file content
    this function is adjusted for the ugly output that pdflatex produces and so it
    only prints the lines between lines starting with '!' (including the actual lines
    starting with '!'). Apparently this is how pdflatex shows errors. Ugrrr...
    """
    if debug:
        print(f"printing [{filename}]", file=sys.stderr)
    with open(filename):
        inerr = False
        for line in file:
            if inerr:
                print(line, file=sys.stderr)
                inerr = False
            else:
                if line.startswith("!"):
                    print(line, file=sys.stderr)
                    inerr = True


def unlink_check(filename: str, check: bool, doit: bool):
    """
    this is a function that removes a file and can optionally die if there is a problem
    """
    if doit:
        if debug:
            print(f"unlinking [{filename}]", file=sys.stderr)
        if check:
            os.unlink(filename)
        else:
            try:
                os.unlink(filename)
            except:
                pass


def chmod_check(filename:str, check: bool):
    """
    this is a function that chmods a file and can optionally die if there is a problem
    """
    if debug:
        print(f"chmodding [{filename}]", file=sys.stderr)
    if check:
        os.chmod(filename, 0o444)
    else:
        try:
            os.chmod(filename, 0o444)
        except:
            pass


def my_call(args):
    if debug:
        print(f"my_call args are [{args}]", file=sys.stderr)
    res = subprocess.check_call(
        args,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
    if debug:
        print(f"my_call res is [{res}]", file=sys.stderr)
    return res


def my_rename(old_filename: str, new_filename: str, check: bool):
    """
    this is a function that renames a file and dies if there is a problem 
    """
    if debug:
        print(f"my_rename [{old_filename, new_filename}]", file=sys.stderr)
    if check:
        os.rename(old_filename, new_filename)
    else:
        try:
            os.rename(old_filename, new_filename)
        except:
            pass

# here we go...
filename_input = sys.argv[1]
filename_output = sys.argv[2]
output_dir = os.path.dirname(filename_output)
output_base = os.path.splitext(filename_output)[0]

args = [
    "pdflatex",
    "-interaction=nonstopmode",
    "-halt-on-error",
    "-output-directory",
    output_dir,
    filename_input,
]
if debug:
    print(f"input is [{filename_input}]")
    print(f"output is [{filename_output}")
    print(f"cmd is [{args}")
# first remove the output (if it exists)
unlink_check(
    filename_output,
    True,
    os.path.isfile(filename_output),
)
# we need to run the command twice!!! (to generate the index and more)
for _ in range(runs):
    my_call(args)
    unlink_check(output_base+'.log', True, True)
    unlink_check(output_base+'.out', True, True)
    unlink_check(output_base+'.toc', True, True)
    unlink_check(output_base+'.aux', True, True)
    unlink_check(output_base+'.nav', False, True)
    unlink_check(output_base+'.snm', False, True)
    unlink_check(output_base+'.vrb', False, True)

if qpdf:
    # move the output to the new place
    tmp_output = filename_output+'.tmp'
    my_rename(filename_output, tmp_output, True)
    # I also had '--force-version=1.5' but it is not needed since I use pdflatex and pdftex with the right version there...
    args = [
        "qpdf",
        "--deterministic-id",
        "--linearize",
        tmp_output,
        filename_output,
    ]
    my_call(args)
    unlink_check(tmp_output, True, True)
