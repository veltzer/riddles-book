##############
# parameters #
##############

# directories
SOURCE_DIR:=tex
# do you want dependency on the makefile itself ?!?
DO_ALL_DEPS:=1
# do you want to show the commands executed ?
DO_MKDBG:=1

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
SOURCES_TEX:=$(shell find $(SOURCE_DIR) -name "*.tex")
OBJECTS_PDF:=$(addsuffix .pdf,$(basename $(SOURCES_TEX)))

.PHONY: all
all: $(OBJECTS_PDF)

.PHONY: debug
debug:
	$(info SOURCES_TEX is $(SOURCES_TEX))
	$(info OBJECTS_PDF is $(OBJECTS_PDF))

# -x: remove everything not known to git (not only ignore rules).
# -d: remove directories also.
# -f: force.
.PHONY: clean_git
clean_git:
	@git clean -xdf

# RULES

# rule about how to create .pdf files out of tex files
#$(OBJECTS_PDF): %.pdf: %.tex $(ALL_DEPS)
#	$(info doing [$@])
#	$(Q)pdflatex -output-directory $(dir $@) $<
#	$(Q)pdflatex -output-directory $(dir $@) $<
#	$(Q)cd $(dir $@); thumbpdf $(notdir $@)
#	$(Q)pdflatex -output-directory $(dir $@) $<

# old rule about generating pdf from tex, without thumbnails
$(OBJECTS_PDF): %.pdf: %.tex $(ALL_DEPS)
	$(info doing [$@])
	$(Q)pdflatex -output-directory $(dir $@) $<
	$(Q)pdflatex -output-directory $(dir $@) $<
