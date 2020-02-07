.PHONY: all
all: solution

solution: solution.c
	gcc -Wall -Werror -pedantic -O2 -o $@ $<

.PHONY: timing
timing: solution
	@bash -c "time ./solution"

.PHONY: clean
clean:
	rm -f solution
