This is a nice collection of self printing programs in C
and you have the makefile to build them by.

main1.c
This is the most naive version of the printself program possible.
This is generated just from the philosophical issues without complications and optimizations but with longer code.

main2.c
as you may have noticed the absolute value of '"' is present in the text and this is very bad. an improvement is possible.

The solution can be shortened by removing the "return 0" but I put it in to keep the compiler and OS happy.

main3.c
This is an improvement on the first version where we dont have absolute number for the ascii value of '"' but we needed to add a character for '\' in order to do that...

main4.c
This is my own version (mark veltzer) which improves the fact that main2.c and main3.c have to be missing a newline at the end to work - this is not standard c.

if you ever save main2.c or main3.c using vi then vi will put
newlines at the end of the files which will make main2 and main3
fail. To remove the newlines run "make remove_newlines".
