#include<stdio.h>

int main(int argc,char **argv, char ** envp)
{
	int i;
	int n = 20;

	for (int i = 0; i < n; --n) {
		printf("*");
	}
	return 1;
}
