#include <iostream>

/*
The riddle is to find all valid combinations that look like this:
	abc+de=fgh
That also satisfy:
	hgf=ed+cba
*/

const int max=10;

int num3(int one,int two,int three)
{
	return one*100+two*10+three;
}

int num2(int one,int two)
{
	return one*10+two;
}

void print 
(
        int k0,
        int k1,
        int k2,
        int k3,
        int k4,
        int k5,
        int k6,
        int k7
)
{
	std::cout<<k0<<k1<<k2<<"+"<<k3<<k4<<"="<<k5<<k6<<k7<<"\n";
	std::cout<<k7<<k6<<k5<<"="<<k4<<k3<<"+"<<k2<<k1<<k0<<"\n";
}

bool is_ok
(
	int k0,
	int k1,
	int k2,
	int k3,
	int k4,
	int k5,
	int k6,
	int k7
)
{
	int num00=num3(k0,k1,k2);
	int num01=num2(k3,k4);
	int num02=num3(k5,k6,k7);
	int num10=num3(k7,k6,k5);
	int num11=num2(k4,k3);
	int num12=num3(k2,k1,k0);
	// The following conditionals are to solve 0 cases which are trivial
	if(num00==0) return false;
	if(num01==0) return false;
	if(num02==0) return false;
	if(num10==0) return false;
	if(num11==0) return false;
	if(num12==0) return false;
// The following could be enabled to find only "real" 3 or 2 digit numbers
//	if(num00<100) return false;
//	if(num01<10) return false;
//	if(num02<100) return false;
//	if(num10<100) return false;
//	if(num11<10) return false;
//	if(num12<100) return false;
	if(num00+num01==num02)
	{
		if(num10==num11+num12)
			return true;
		else
			return false;
	}
	else return false;
}

int main()
{
	for(int k0=0;k0<max;k0++)
	for(int k1=0;k1<max;k1++)
	for(int k2=0;k2<max;k2++)
	for(int k3=0;k3<max;k3++)
	for(int k4=0;k4<max;k4++)
	for(int k5=0;k5<max;k5++)
	for(int k6=0;k6<max;k6++)
	for(int k7=0;k7<max;k7++)
	{
		if(is_ok(k0,k1,k2,k3,k4,k5,k6,k7))
			print(k0,k1,k2,k3,k4,k5,k6,k7);
	}
	return(0);
}
