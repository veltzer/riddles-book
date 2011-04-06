##############
# parameters #
##############

# where are the sources ?
SOURCE_DIR:=src
# where is the output folder ?
OUT_DIR:=out
# do you want dependency on the makefile itself ?!?
DO_ALL_DEPS:=1
# do you want to show the commands executed ?
DO_MKDBG:=0
# the prime file
PRIME:=riddles
# the primary pdf file name
PRIME_PDF:=out/$(PRIME).pdf
# the primary html file name
PRIME_HTM:=out/$(PRIME)/index.html
# the primary output folder
PRIME_FOLDER:=out/$(PRIME)
# where is the web folder?
WEB:=/var/www

#############
# variables #
#############

# dependency on the makefile itself
ifeq ($(DO_ALL_DEPS),1)
ALL_DEPS:=Makefile
else
ALL_DEPS:=
endif

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# silent stuff
SOURCES_GIT:=$(shell git ls-tree HEAD -r --full-name --name-only)
SOURCES_TEX:=$(filter %.tex,$(SOURCES_GIT))
#SOURCES_TEX:=$(shell find $(SOURCE_DIR) -name "*.tex")
#OBJECTS_PDF:=$(addsuffix .pdf,$(basename $(SOURCES_TEX)))
OBJECTS_PDF:=$(addsuffix .pdf,$(addprefix $(OUT_DIR)/,$(notdir $(basename $(SOURCES_TEX)))))
#OBJECTS_HTM:=$(addsuffix .out/index.html,$(basename $(SOURCES_TEX)))
OBJECTS_HTM:=$(addsuffix /index.html,$(addprefix $(OUT_DIR)/,$(notdir $(basename $(SOURCES_TEX)))))

.PHONY: all
all: $(OBJECTS_PDF) $(OBJECTS_HTM)

.PHONY: debug
debug:
	$(info SOURCES_GIT is $(SOURCES_GIT))
	$(info SOURCES_TEX is $(SOURCES_TEX))
	$(info OBJECTS_PDF is $(OBJECTS_PDF))
	$(info OBJECTS_HTM is $(OBJECTS_HTM))
	$(info PRIME is $(PRIME))
	$(info PRIME_PDF is $(PRIME_PDF))
	$(info PRIME_HTM is $(PRIME_HTM))
	$(info PRIME_FOLDER is $(PRIME_FOLDER))

# -x: remove everything not known to git (not only ignore rules).
# -d: remove directories also.
# -f: force.
.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -xdf > /dev/null

# RULES

# rule about how to create .pdf files out of tex files
#$(OBJECTS_PDF): %.pdf: %.tex $(ALL_DEPS)
#	$(info doing [$@])
#	$(Q)pdflatex -output-directory $(dir $@) $<
#	$(Q)pdflatex -output-directory $(dir $@) $<
#	$(Q)cd $(dir $@); thumbpdf $(notdir $@)
#	$(Q)pdflatex -output-directory $(dir $@) $<

# old rule about generating pdf from tex, without thumbnails
# the -rf for rm is in order to make rm not return an error
# code to make if the file is not there (which causes make
# to print an annoying on screen message about disregarding
# the error)
$(OBJECTS_PDF): $(OUT_DIR)/%.pdf: $(SOURCE_DIR)/%.tex $(ALL_DEPS)
	$(info doing [$@])
	$(Q)lacheck $<
	$(Q)scripts/latex2pdf.pl $< $@

$(OBJECTS_HTM): $(OUT_DIR)/%/index.html: $(SOURCE_DIR)/%.tex $(ALL_DEPS)
	$(info doing [$@])
	$(Q)-rm -rf $(dir $@)
	$(Q)mkdir $(dir $@) 2> /dev/null || exit 0
	$(Q)latex2html $< --dir=$(dir $@) > /dev/null 2> /dev/null

# short cut to show the riddles pdf output fast...
.PHONY: view_pdf
view_pdf: $(PRIME_PDF)
	gnome-open $(PRIME_PDF)
# short cut to show the html output fast...
.PHONY: view_htm
view_htm: $(PRIME_HTM)
	gnome-open $(PRIME_HTM)
# make the riddles public on a web folder...
.PHONY: public
public: $(PRIME_HTM)
	-sudo rm -rf $(WEB)/$(PRIME)
	-sudo rm -rf $(WEB)/usr
	sudo cp -r $(PRIME_FOLDER) $(WEB)
	sudo mkdir -p $(WEB)/usr/share/latex2html
	sudo cp -r /usr/share/latex2html/icons $(WEB)/usr/share/latex2html 
