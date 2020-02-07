.PHONY: all
all: simple

simple: simple.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<

.PHONY: timing
timing: simple
	@bash -c "time ./simple"
