.PHONY: all
all: mendel.exe

.PHONY: clean
clean:
	-rm -f *.exe

# rules
%.exe: %.cc
	$(CXX) $(CXXFLAGS) -o $@ $<

