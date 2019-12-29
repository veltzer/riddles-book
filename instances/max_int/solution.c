#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv, char** envp) {
	unsigned int i=0;
	unsigned int j;
	do {
		j=i;
		i++;
		if(i%10000000==0) {
			printf("i is %u\n", i);
		}
	} while(i!=0);
	printf("the maximal int is %u\n", j);
	return EXIT_SUCCESS;
}
