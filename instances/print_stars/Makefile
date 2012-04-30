PROGRAMS:=main.exe main1.exe main2.exe main3.exe main4.exe

.PHONY: all
all: $(PROGRAMS)

%.exe: %.cc
	$(CXX) $(CXXFLAGS) -o $@ $<

.PHONY: clean
clean:
	-rm -f $(PROGRAMS)
