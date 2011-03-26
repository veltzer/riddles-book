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
# the primary output name
PRIME_PDF=out/riddles.pdf

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

# -x: remove everything not known to git (not only ignore rules).
# -d: remove directories also.
# -f: force.
.PHONY: clean
clean:
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
$(OBJECTS_PDF): $(OUT_DIR)/%.pdf: $(SOURCE_DIR)/%.tex $(ALL_DEPS)
	$(info doing [$@])
	$(Q)lacheck $<
	$(Q)pdflatex -output-directory $(dir $@) $< > /dev/null
	$(Q)pdflatex -output-directory $(dir $@) $< > /dev/null

$(OBJECTS_HTM): $(OUT_DIR)/%/index.html: $(SOURCE_DIR)/%.tex $(ALL_DEPS)
	$(info doing [$@])
	$(Q)mkdir $(dir $@) 2> /dev/null || exit 0
	$(Q)latex2html $< --dir=$(dir $@)

# Short cuts to make me see the riddles fast...
.PHONY: view
view: $(PRIME_PDF)
	gnome-open $(PRIME_PDF)
