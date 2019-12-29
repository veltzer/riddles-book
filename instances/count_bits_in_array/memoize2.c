#include <stdio.h>
#include <stdlib.h>

/*
	return how many bits are turned on in the integer
	whose value is 'value'
*/
int int_to_bits(int value) {
	unsigned int uvalue=*(unsigned*)&value;
	unsigned int p=1;
	int bits=0;
	while(p!=0) {
		if(p & uvalue) {
			bits+=1;
		}
		p<<=1;
	}
	return bits;
}

int int_to_bits_alt(int value) {
	unsigned int uvalue=*(unsigned*)&value;
	int bits=0;
	while(uvalue!=0) {
		if(uvalue & 1) {
			bits+=1;
		}
		uvalue>>=1;
	}
	return bits;
}

int main(int argc, char** argv, char** envp) {
	char table[256*256];
	for(int i=0;i<256*256;i++) {
		table[i]=int_to_bits_alt(i);
		//printf("table at point %d is %d\n", i, table[i]);
	}
	int max=1000000;
	int bits=0;
	for(int i=0;i<max;i++) {
		unsigned short* p=(unsigned short*)&i;
		bits+=table[(int)*p];
		p++;
		bits+=table[(int)*p];
	}
	printf("bits is %d\n", bits);
	return EXIT_SUCCESS;
}
