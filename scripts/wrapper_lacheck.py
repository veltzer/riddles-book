#!/usr/bin/env python

"""
This is a wrapper to run the lacheck(1) tool from the "lacheck" package.

Why do we need this wrapper?
- lacheck does NOT report in its exit status whether it had warnings or not.
- it is too verbose when there are no warnings.
"""

import sys
import subprocess


def main():
    out = subprocess.check_output([
        "lacheck",
        sys.argv[1],
    ]).decode()
    errors = False
    remember = None
    printed_remember = False
    for line in out.split("\n"):
        if line.startswith("**"):
            remember = line
            printed_remember = False
            continue
        if line == "":
            continue
        # this is a warning or error
        errors = True
        if not printed_remember:
            print(remember)
            printed_remember = True
        print(line)
    if errors:
        sys.exit(1)


if __name__ == "__main__":
    main()
