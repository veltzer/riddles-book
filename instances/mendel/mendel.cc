#include<iostream>
#include<stdlib.h>
#include<assert.h>

inline unsigned int rand_int(unsigned int lim) {
	return (unsigned int)(drand48()*double(lim));
}

class Individual {
	protected:
		bool a;
		bool b;
	public:
		// constructor
		inline Individual(void) {
		}
		// get the A gene
		inline bool getA(void) {
			return a;
		}
		inline void setA(bool val) {
			a=val;
		}
		// get the B gene
		inline bool getB(void) {
			return b;
		}
		inline void setB(bool val) {
			b=val;
		}
		inline bool getPheno(void) {
			return a || b;
		}
};

class Selector {
	protected:
		unsigned int* arr;
		unsigned int size;
		unsigned int num;
	public:
		inline Selector(unsigned int isize) {
			size=isize;
			arr=new unsigned int[size];
		}
		// this is the method that does all the work.
		// next method are just accesors to the results.
		inline void select(unsigned int inum) {
			num=inum;
			for(unsigned int i=0;i<size;i++) {
				arr[i]=i;
			}
			unsigned int limit=size;
			for(unsigned int i=0;i<num;i++) {
				unsigned int current_index=rand_int(limit);
				unsigned int current_val=arr[current_index];
				if(current_index<limit-1) {
					unsigned int tmp=arr[limit-1];
					arr[limit-1]=current_val;
					arr[current_index]=tmp;
				}
				limit--;
			}
		}
		inline unsigned int getSelection(unsigned int order) {
			assert(order<num);
			return arr[num-order];
		}
};

const unsigned int population=100; // this should be divisible by two
const unsigned int num=10;
const unsigned int cycles=300;
Individual* all;
Individual* nextall;

inline void stats(unsigned int& a,unsigned int& b,unsigned int& pheno) {
	a=0;
	b=0;
	pheno=0;
	for(unsigned int i=0;i<population;i++) {
		if(all[i].getPheno()) {
			pheno++;
		}
		if(all[i].getA()) {
			a++;
		}
		if(all[i].getB()) {
			b++;
		}
	}
}

inline void inherit(Individual& parent1,Individual& parent2,Individual& child) {
	if(drand48()<0.5) {
		child.setA(parent1.getA());
	} else {
		child.setA(parent2.getA());
	}
	if(drand48()<0.5) {
		child.setB(parent1.getB());
	} else {
		child.setB(parent2.getB());
	}
}

int main(int argc,char** argv,char** envp) {
	assert(population%2==0);
	std::cout << "Starting..." << std::endl;
	// allocate the population
	all=new Individual[population];
	nextall=new Individual[population];
	// initialize all to have AA genes
	for(unsigned int i=0;i<population;i++) {
		all[i].setA(false);
		all[i].setB(false);
	}
	// set num individuals to have one 'true' value gene
	// select the individuals by random.
	// select whether the A or the B gene will be true by random
	Selector* s=new Selector(population);
	s->select(num);
	for(unsigned int i=0;i<num;i++) {
		unsigned int elem=s->getSelection(i);
		if(drand48()<0.5) {
			all[elem].setA(true);
		} else {
			all[elem].setB(true);
		}
	}
	// now start running cycles
	// do it again
	for(unsigned int i=0;i<cycles;i++) {
		// count how many in the population have Pheno and print it
		unsigned int a,b,pheno;
		stats(a,b,pheno);
		std::cout << "Stats (a,b,pheno) are " << a << "," << b << "," << pheno << std::endl;
		// at every cycle pair off 50 and 50 (do the pairings random).
		// create two children in the outgoing population
		for(unsigned int j=0;j<population;j+=2) {
			s->select(population);
			inherit(all[j],all[j+1],nextall[s->getSelection(j)]);
			inherit(all[j],all[j+1],nextall[s->getSelection(j+1)]);
		}
		// swap the populations...
		Individual* tmp=all;
		all=nextall;
		nextall=tmp;
	}
	std::cout << "Ending..." << std::endl;
	return 0;
}
