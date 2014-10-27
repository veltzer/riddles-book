#!/usr/bin/python3

'''
this script will install all the required packages that you need on
ubuntu to compile and work with this package.
'''

import subprocess # for check_call

packs=[
	'lacheck',
	'latex2html',
	'sketch',
	'texlive-latex-base',
	'texlive-binaries',
	'texlive-pictures',
	'ghostscript',
	'qpdf',
	'sketch-doc',
	'poppler-utils',
	'luatex',
	'pgf',
	'tex4ht',

	# my own
	'templar',
]

args=['sudo','apt-get','install','--assume-yes']
args.extend(packs)
subprocess.check_call(args)
