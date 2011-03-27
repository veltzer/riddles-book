char* p="\";\n#include <stdio.h>\nint main(void)\n{\nchar* t;\nprintf(\"char* p=\\\"\");\nt=p;\nwhile(*t!='\\0')\n{\nchar c=*t;\nswitch(c)\n{\ncase '\\n':\nprintf(\"\\\\n\");\nbreak;\ncase '\\t':\nprintf(\"\\\\t\");\nbreak;\ncase '\"':\nprintf(\"\\\\\\\"\");\nbreak;\ncase '\\\\':\nprintf(\"\\\\\\\\\");\nbreak;\ndefault:\nputchar(c);\nbreak;\n}\nt++;\n}\nprintf(p);\nreturn(0);\n}\n";
#include <stdio.h>
int main(void)
{
char* t;
printf("char* p=\"");
t=p;
while(*t!='\0')
{
char c=*t;
switch(c)
{
case '\n':
printf("\\n");
break;
case '\t':
printf("\\t");
break;
case '"':
printf("\\\"");
break;
case '\\':
printf("\\\\");
break;
default:
putchar(c);
break;
}
t++;
}
printf(p);
return(0);
}
