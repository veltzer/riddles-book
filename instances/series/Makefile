.PHONY: all
all: brute_force memoize

brute_force: brute_force.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<
memoize: memoize.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<

.PHONY: timing
timing:
	bash -c "time ./brute_force"
	bash -c "time ./memoize"
	bash -c "time ./solution_better_better.py"
