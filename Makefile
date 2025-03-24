##############
# parameters #
##############
# do you want dependency on the makefile itself ?
DO_ALLDEP:=1
# do you want to show the commands executed ?
DO_MKDBG:=0
# do you want to do PDF?
DO_TEX_PDF:=1
# do you want to convert sk to tex?
DO_SK_TEX:=1
# do you want to validate html?
DO_HTML_CHECK:=1
# do you want to check python scripts?
DO_PY_LINT:=1

########
# code #
########
ALL:=

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

TEX_ALL:=$(shell find src -type f -and -name "*.tex")
TEX_SRC:=$(shell find src/tex -type f -and -name "*.tex")
TEX_PDF:=$(addsuffix .pdf,$(addprefix docs/,$(notdir $(basename $(TEX_SRC)))))
TEX_INC:=$(shell find src/include -type f -and -name "*.tex")

SK_SRC:=$(shell find src -type f -and -name "*.sk")
SK_TEX:=$(addsuffix .tex,$(addprefix out/,$(basename $(SK_SRC))))

HTML_SRC:=$(shell find docs -type f -and -name "*.html")
HTML_CHECK=$(addsuffix .check,$(addprefix out/,$(basename $(HTML_SRC))))

PY_SRC:=$(shell find instances config scripts -type f -and -name "*.py")
PY_LINT:=$(addsuffix .lint,$(addprefix out/,$(basename $(PY_SRC))))

ifeq ($(DO_TEX_PDF),1)
ALL+=$(TEX_PDF)
endif # DO_TEX_PDF

ifeq ($(DO_SK_TEX),1)
ALL+=$(SK_TEX)
endif # DO_SK_TEX

ifeq ($(DO_HTML_CHECK),1)
ALL+=$(HTML_CHECK)
endif # DO_HTML_CHECK

ifeq ($(DO_PY_LINT),1)
ALL+=$(PY_LINT)
endif # DO_PY_LINT

#########
# rules #
#########
# do not touch this rule (see demos-make for explanation of order in makefile)
all: $(ALL)
	@true

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

.PHONY: debug
debug:
	$(info TEX_ALL is $(TEX_ALL))
	$(info TEX_SRC is $(TEX_SRC))
	$(info TEX_PDF is $(TEX_PDF))
	$(info TEX_INC is $(TEX_INC))
	$(info SK_SRC is $(SK_SRC))
	$(info SK_TEX is $(SK_TEX))
	$(info PY_SRC is $(PY_SRC))
	$(info PY_LINT is $(PY_LINT))
	$(info ALL is $(ALL))

############
# patterns #
############
$(TEX_PDF): docs/%.pdf: src/tex/%.tex $(SK_TEX) scripts/wrapper_lacheck.py $(TEX_INC)
	$(info doing [$@])
	$(Q)scripts/wrapper_lacheck.py $<
	$(Q)pymakehelper wrapper_pdflatex --input_file $< --output_file $@
$(SK_TEX): out/%.tex: %.sk scripts/wrapper_sketch.py
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)scripts/wrapper_sketch.py $< $@
$(HTML_CHECK): out/%.check: %.html
	$(info doing [$@])
	$(Q)tidy -errors -q -utf8 $<
	$(Q)pymakehelper only_print_on_error node_modules/.bin/htmlhint $<
	$(Q)pymakehelper touch_mkdir $@
$(PY_LINT): out/%.lint: %.py .pylintrc
	$(info doing [$@])
	$(Q)pylint --reports=n --score=n $<
	$(Q)pymakehelper touch_mkdir $@

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
