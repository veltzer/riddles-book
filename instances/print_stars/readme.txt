The following code was supposed to print 20 star (*) characters but it
doesn't work, fix it using just one change in the code,
changes are legal only if they involve placing the cursor somewhere in the
code (just placing it, no marking of large code blocks) with the mouse and
pressing one key on the keyboard (insert can be on or off) which in short
means you can delete, add or replace one character in the code (replace
means replacing with a new character not with another character from the
code of course)

this is the malfunctioning program:

int main(int argc,char **argv, char ** envp)
{
    int i;
    int n = 20;

    for (int i = 0; i < n; --i)
    {
        printf("*");
    }

    return 1;
}

There are three possible solutions, can you find all three?

Also, can u see a change (as before) that will print 21 stars?
