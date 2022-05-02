##############
# parameters #
##############
# do you want dependency on the makefile itself ?
DO_ALLDEP:=1
# do you want to show the commands executed ?
DO_MKDBG:=0
# do you want to do PDF ?
DO_PDF:=1
# do you want to do HTML ?
DO_HTML:=0
# do you want to do SWF ?
DO_SWF:=0
# do you want to generate dependencies ?
DO_DEP:=0
# do you want to actually include the deps ? (must enable DO_DEP)
DO_INCLUDE:=0
# do you want to validate html?
DO_CHECKHTML:=1

########
# code #
########
ALL:=
# where are the sources ?
SOURCE_DIR:=src
# where is the output folder ?
OUT:=out
# where is the web folder ?
DOCS:=docs
# the primary file
PRIME:=riddling
# the primary pdf file name
PRIME_PDF:=$(DOCS)/$(PRIME).pdf
# the primary swf file name
PRIME_SWF:=$(OUT)/$(PRIME).swf
# the primary html file name
PRIME_HTM:=$(OUT)/$(PRIME)/index.php
# the primary output folder
PRIME_HTM_FOLDER:=$(OUT)/$(PRIME)
# what to export out (to grive and dropbox)?
OUTPUTS_TO_EXPORT:=$(PRIME_PDF)
# what is the name of the project?
PROJECT:=$(notdir $(CURDIR))
# what is the stamp file for the tools?

# tools
TOOL_LATEX2HTML:=latex2html
TOOL_LACHECK:=scripts/wrapper_lacheck.py
TOOL_SKETCH:=sketch
TOOL_PDFLATEX:=pdflatex
USE_LATEX2PDF:=scripts/wrapper_pdflatex.py
# the tag name of the project ?
TAG:=$(shell git tag | tail -1)

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP

SOURCES_TEX:=$(shell find src -name "*.tex")

SOURCES_SK:=$(shell find src -name "*.sk")
OBJECTS_SK:=$(addsuffix .tex,$(addprefix $(OUT)/,$(basename $(SOURCES_SK))))

OBJECTS_PDF:=$(addsuffix .pdf,$(addprefix $(DOCS)/,$(notdir $(basename $(SOURCES_TEX)))))
OBJECTS_SWF:=$(addsuffix .swf,$(addprefix $(OUT)/,$(notdir $(basename $(SOURCES_TEX)))))
OBJECTS_HTM:=$(addsuffix /index.html,$(addprefix $(OUT)/,$(notdir $(basename $(SOURCES_TEX)))))
OBJECTS_DEP:=$(addsuffix .dep,$(addprefix $(OUT)/,$(notdir $(basename $(SOURCES_TEX)))))

ifeq ($(DO_PDF),1)
ALL+=$(OBJECTS_PDF)
endif # DO_PDF

ifeq ($(DO_HTML),1)
ALL+=$(OBJECTS_HTM)
endif # DO_HTML

ifeq ($(DO_SWF),1)
ALL+=$(OBJECTS_SWF)
endif # DO_SWF

ifeq ($(DO_DEP),1)
ALL+=$(OBJECTS_DEP)
endif # DO_DEP

# do not include deps if the target is 'clean'...
ifeq ($(MAKECMDGOALS),clean)
DO_INCLUDE:=0
endif # clean

SOURCES_HTML:=$(DOCS)/index.html
HTMLCHECK:=$(OUT)/html.stamp
ifeq ($(DO_CHECKHTML),1)
ALL+=$(HTMLCHECK)
endif # DO_CHECKHTML

ALL+=$(DOCS)/riddling.pdf

#########
# rules #
#########
# do not touch this rule (see demos-make for explanation of order in makefile)
all: $(ALL)
	@true

.PHONY: check_veltzer_https
check_veltzer_https:
	$(info doing [$@])
	$(Q)wrapper_ok git grep "http:\/\/veltzer.net"
.PHONY: check_all
check_all: check_veltzer_https

.PHONY: deps
deps: $(OBJECTS_DEP)

.PHONY: debug
debug:
	$(info SOURCES_TEX is $(SOURCES_TEX))
	$(info SOURCES_SK is $(SOURCES_SK))
	$(info OBJECTS_SK is $(OBJECTS_SK))
	$(info OBJECTS_PDF is $(OBJECTS_PDF))
	$(info OBJECTS_SWF is $(OBJECTS_SWF))
	$(info OBJECTS_HTM is $(OBJECTS_HTM))
	$(info OBJECTS_DEP is $(OBJECTS_DEP))
	$(info SOURCES_HTML is $(SOURCES_HTML))
	$(info PRIME is $(PRIME))
	$(info PRIME_PDF is $(PRIME_PDF))
	$(info PRIME_HTM is $(PRIME_HTM))
	$(info PRIME_HTM_FOLDER is $(PRIME_HTM_FOLDER))
	$(info TAG is $(TAG))
	$(info ALL is $(ALL))
	$(info OUTPUTS_TO_EXPORT is $(OUTPUTS_TO_EXPORT))
	$(info PROJECT is $(PROJECT))

$(OBJECTS_PDF): $(DOCS)/%.pdf: $(SOURCE_DIR)/%.tex $(OBJECTS_SK) $(USE_LATEX2PDF)
	$(info doing [$@])
	$(Q)$(TOOL_LACHECK) $<
	$(Q)$(USE_LATEX2PDF) $< $@

$(OBJECTS_HTM): $(OUT)/%/index.html: $(SOURCE_DIR)/%.tex $(OBJECTS_SK)
	$(info doing [$@])
	$(Q)-rm -rf $(dir $@)
	$(Q)mkdir -p $(dir $@)
	$(Q)$(TOOL_LATEX2HTML) $< --dir=$(dir $@) > /dev/null 2> /dev/null

$(OBJECTS_DEP): $(OUT)/%.dep: $(SOURCE_DIR)/%.tex scripts/latex2dep.pl
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)scripts/latex2dep.pl $< $@

$(OBJECTS_SK): $(OUT)/%.tex: %.sk scripts/wrapper_sketch.pl
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)scripts/wrapper_sketch.pl $< $@

$(OBJECTS_SWF): $(OUT)/%.swf: $(OUT)/%.pdf
	$(info doing [$@])
	$(Q)-rm -f $@
	$(Q)mkdir -p $(dir $@)
	$(Q)pdf2swf -T 9 -f $< $@ 2> /dev/null > /dev/null
	$(Q)chmod 444 $@

# short cut to see meta data about the produced pdf
.PHONY: pdfinfo
pdfinfo: $(PRIME_PDF)
	$(Q)pdfinfo $(PRIME_PDF)
# short cut to show the riddling pdf output fast...
.PHONY: view_pdf
view_pdf: $(PRIME_PDF)
	$(Q)gnome-open $(PRIME_PDF) > /dev/null 2> /dev/null &
# short cut to show the html output fast...
.PHONY: view_htm
view_htm: $(PRIME_HTM)
	$(Q)gnome-open $(PRIME_HTM) > /dev/null 2> /dev/null &
# short cut to show the swf using flex paper fast...
.PHONY: view_swf
view_swf: $(PRIME_SWF)
	$(Q)gnome-open http://www.veltzer.net/riddling/flexpaper/index.html > /dev/null 2> /dev/null &
.PHONY: view_sketch_doc_htm
view_sketch_doc_htm:
	$(Q)gnome-open /usr/share/doc/sketch-doc/sketch/index.html > /dev/null 2> /dev/null &
.PHONY: view_sketch_doc_pdf
view_sketch_doc_pdf:
	$(Q)gnome-open /usr/share/doc/sketch-doc/sketch.pdf.gz > /dev/null 2> /dev/null &
.PHONY: view_pdftex_doc_pdf
view_pdftex_doc_pdf:
	$(Q)gnome-open /usr/share/doc/texlive-doc/pdftex/manual/pdftex-s.pdf > /dev/null 2> /dev/null &
.PHONY: view_luatex_doc_pdf
view_luatex_doc_pdf:
	$(Q)gnome-open /usr/share/doc/texmf/luatex/base/luatexref-t.pdf
.PHONY: view_pgf_doc_pdf
view_pgf_doc_pdf:
	$(Q)gnome-open /usr/share/doc/texmf/pgf/pgfmanual.pdf.gz

.PHONY: grive
grive: $(OUTPUTS_TO_EXPORT)
	$(info doing [$@])
	$(Q)-rm -rf ~/grive/outputs/$(PROJECT)
	$(Q)-mkdir ~/grive/outputs/$(PROJECT)
	$(Q)cp $(OUTPUTS_TO_EXPORT) ~/grive/outputs/$(PROJECT)
	$(Q)cd ~/grive; grive

.PHONY: dropbox
dropbox: $(OUTPUTS_TO_EXPORT)
	$(info doing [$@])
	$(Q)-rm -rf ~/Dropbox/outputs/$(PROJECT)
	$(Q)-mkdir ~/Dropbox/outputs/$(PROJECT)
	$(Q)cp $(OUTPUTS_TO_EXPORT) ~/Dropbox/outputs/$(PROJECT)

ifeq ($(DO_INCLUDE),1)
# include the deps files (no warnings)
-include $(OBJECTS_DEP)
endif # DO_INCLUDE

$(HTMLCHECK): $(SOURCES_HTML)
	$(info doing [$@])
	$(Q)tidy -errors -q -utf8 $(SOURCES_HTML)
	$(Q)node_modules/htmlhint/bin/htmlhint $(SOURCES_HTML) > /dev/null
	$(Q)mkdir -p $(dir $@)
	$(Q)touch $@

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd
