all: main1.res main2.res main3.res main4.res 
	diff main1.c main1.res
	diff main2.c main2.res
	diff main3.c main3.res
	diff main4.c main4.res
# the "-include stdio.h" in the next line is to make the compiler shut up
# about printf
CFLAGS=-include stdio.h -O2 -s
main1.res: main1
	./main1 > main1.res
main2.res: main2
	./main2 > main2.res
main3.res: main3
	./main3 > main3.res
main4.res: main4
	./main4 > main4.res
remove_newlines:
	tr -d '\n' < main2.c > out.tmp
	mv out.tmp main2.c
	tr -d '\n' < main3.c > out.tmp
	mv out.tmp main3.c
clean:
	-rm *.res main? 
