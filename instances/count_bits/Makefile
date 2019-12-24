.PHONY: all
all: brute_force memoize memoize2

brute_force: brute_force.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<
memoize: memoize.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<
memoize2: memoize2.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<

.PHONY: timing
timing: brute_force memoize memoize2
	@bash -c "time ./brute_force"
	@bash -c "time ./memoize"
	@bash -c "time ./memoize2"
