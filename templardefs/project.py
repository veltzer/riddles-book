'''
project definitions for riddling
'''

def populate(d):
	d.project_github_username='veltzer'
	d.project_name='riddling'
	d.project_website='https://{project_github_username}.github.io/{project_name}'.format(**d)
	d.project_website_source='https://github.com/{project_github_username}/{project_name}'.format(**d)
	d.project_website_git='git://github.com/{project_github_username}/{project_name}.git'.format(**d)
	d.project_paypal_donate_button_id='ASPRXR59H2NTQ'
	d.project_google_analytics_tracking_id='UA-56436979-1'
	d.project_long_description='A riddle collection done with open source tools'
	# keywords to put on html pages or for search, dont put the name of the project or my details
	# as they will be added automatically...
	d.project_keywords=[
		'riddles',
		'riddling',
		'collection',
	]
	d.project_license='GPLV3'
	d.project_year_started='2011'
	d.project_description='''This is the riddling project

The idea is to create a collection of many riddles for your enjoyment.

Tools include: make, pdflatex, lacheck, latex, dvips, ps2pdf, latex2html, perl, sketch, git,
        flexpaper, pdf2swf, qpdf, pdfinfo, pdftex, pdftohtml, luatex, xetex and possibly more.

If you want to see the result checkout:
https://veltzer.net/blog/riddling/

If you want to compile this package then:
- install all required packages.
        Ubuntu users you are in luck: just run 'scripts/ubuntu_install.sh'...
- make
All the output is in the 'out' folder.

        Mark Veltzer, 2011-2014
'''.format(**d)

	# deb
	d.deb_package=False

def getdeps():
	return [
		__file__, # myself
	]
