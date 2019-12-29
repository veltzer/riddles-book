#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

char number_of_bits_in_uint(unsigned int uvalue) {
	char bits=0;
	while(uvalue!=0) {
		if(uvalue & 1) {
			bits+=1;
		}
		uvalue>>=1;
	}
	return bits;
}

char number_of_bits_in_int_wrong(int value) {
	char bits=0;
	while(value!=0) {
		printf("value is %d\n", value);
		if(value & 1) {
			bits+=1;
		}
		value>>=1;
	}
	return bits;
}

char number_of_bits_in_int(int value) {
	unsigned int uvalue=*(unsigned int*)&value;
	if(value<0) {
		return 32-number_of_bits_in_uint(uvalue);
	} else {
		return number_of_bits_in_uint(uvalue);
	}
}

int main(int argc, char** argv, char** envp) {
	assert(4==number_of_bits_in_uint(23));
	assert(1==number_of_bits_in_uint(64));
	assert(2==number_of_bits_in_uint(40));
	assert(2==number_of_bits_in_int(20));
	assert(3==number_of_bits_in_int(-20));
	printf("-1>>1 is %d\n", -1 >> 1);
	printf("-10 casted to unsigned int is %u\n", (unsigned int)-10);
	return EXIT_SUCCESS;
}
