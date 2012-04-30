ALL:=program.exe
OBJECTS:=main.o prisonerfull.o prisonersimple.o
CXXFLAGS:=-g3
#CXXFLAGS:=-s -O3

.PHONY: all
all: $(ALL)

program.exe: $(OBJECTS)
	g++ -o $@ $(OBJECTS)

.PHONY: clean
clean:
	-rm -f $(ALL) $(OBJECTS)
