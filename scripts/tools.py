#!/usr/bin/python3

'''
this script will install all the required packages that you need on
ubuntu to compile and work with this package.
'''

###########
# imports #
###########
import subprocess # for check_call

##############
# parameters #
##############
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
	'tex4ht',

	# my own
	'templar',
]
node_packs=[
	'htmlhint',
	'gh-pages',
]

########
# code #
########
for pack in packs:
	print('getting ubuntu package for [{0}]'.format(pack))
	subprocess.check_call([
		'sudo',
		'apt-get',
		'install',
		'--assume-yes',
		pack
	], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

for node_pack in node_packs:
	print('getting npm for [{0}]'.format(node_pack))
	subprocess.check_call([
		'npm',
		'--silent',
		'install',
		node_pack,
	], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
