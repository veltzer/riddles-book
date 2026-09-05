const char* p="\";\n#include <stdio.h>\nint main(void)\n{\nconst char* t;\nprintf(\"const char* p=\\\"\");\nt=p;\nwhile(*t!='\\0')\n{\nchar c=*t;\nswitch(c)\n{\ncase '\\n':\nprintf(\"\\\\n\");\nbreak;\ncase '\\t':\nprintf(\"\\\\t\");\nbreak;\ncase '\"':\nprintf(\"\\\\\\\"\");\nbreak;\ncase '\\\\':\nprintf(\"\\\\\\\\\");\nbreak;\ndefault:\nputchar(c);\nbreak;\n}\nt++;\n}\nprintf(p);\nreturn(0);\n}\n";
#include <stdio.h>
int main(void)
{
const char* t;
printf("const char* p=\"");
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
