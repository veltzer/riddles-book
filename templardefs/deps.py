'''
dependencies for this project
'''

def populate(d):
    d.packs=[
        # for lacheck(1)
        'lacheck',
        # for latex2html(1)
        'latex2html',
        # for sketch(1)
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
        'templar',
    ]

def getdeps():
    return [
        __file__, # myself
    ]
