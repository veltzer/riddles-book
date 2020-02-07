#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv, char** envp) {
	long best_count=-1;
	long best_value;
	long max=1000000;
	long current = 1;
	long max_value=-1;
	while(current<max) {
		int count=1;
		long n=current;
		while(n!=1) {
			if(n>max_value) {
				max_value=n;
			}
			if(n%2==0) {
				n=n/2;
			} else {
				n=n*3+1;
			}
			count++;
		}
		if(count>best_count) {
			best_count=count;
			best_value=current;
		}
		current++;
	}
	printf("best_count is %ld\n", best_count);
	printf("best_value is %ld\n", best_value);
	printf("max_value is %ld\n", max_value);
	return EXIT_SUCCESS;
}
