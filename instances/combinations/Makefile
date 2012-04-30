CXXFLAGS:=-O2 -s -Wall

.PHONY: all
all: combinations.exe

%.exe: %.cc
	$(CXX) $(CXXFLAGS) -o $@ $<

.PHONY: clean
clean:
	-rm combinations
