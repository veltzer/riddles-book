ALL=prisoners.opt prisoners.debug

all: $(ALL)

prisoners.opt: prisoners.cc
	g++ -s -O3 -o $@ $<
prisoners.debug: prisoners.cc
	g++ -g3 -o $@ $<

.PHONY: clean
clean:
	-rm -f $(ALL)
