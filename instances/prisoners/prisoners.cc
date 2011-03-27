#include<stdio.h>
#include<stdlib.h>

const unsigned int NUM_PRIS=300;
const unsigned int MAX_BITS=32;
const bool do_debug=true;
const unsigned int DEBUG_INTERVAL=100;
const unsigned int DEBUG_PRINT=100000000;
const unsigned int N=4;
const unsigned int N_START=800000;

typedef enum _AlgType {
	ALG_AWFUL_POWER,
	ALG_ONEBIT,
	ALG_GROUPS_OF_N,
	ALG_LINEAR,
	ALG_DYNAMIC_NUMBERS,
} AlgType;

//const AlgType algType=ALG_ONEBIT;
const AlgType algType=ALG_GROUPS_OF_N;
//const AlgType algType=ALG_LINEAR;

class PrisonersKnowledge {
	private:
		bool bits[NUM_PRIS];
		unsigned int numBits;
		unsigned mynum;
	public:
		inline void nullit(void) {
			numBits=0;
			for(unsigned int i=0;i<NUM_PRIS;i++) {
				bits[i]=false;
			}
			updateBit(mynum);
		}
		inline PrisonersKnowledge(unsigned int imynum) {
			mynum=imynum;
			nullit();
		}
		inline bool isFull(void) {
			return numBits==NUM_PRIS;
		}
		inline bool hasBit(unsigned int bit) {
			return bits[bit];
		}
		inline unsigned int getNumBits(void) {
			return numBits;
		}
		inline void updateBit(unsigned int bit) {
			if(bits[bit]==false) {
				bits[bit]=true;
				numBits++;
			}
		}
		inline void print(void) {
			printf("prisoner #%d (%d): ",mynum,numBits);
			for(unsigned int i=0;i<NUM_PRIS;i++) {
				printf("%d",bits[i]);
			}
			printf("\n");
		}
};

class Experiment {
	private:
		bool bits[NUM_PRIS];
		unsigned int numBits;
		unsigned int day;

	public:

		inline Experiment(void) {
			numBits=0;
			day=0;
			for(unsigned int i=0;i<NUM_PRIS;i++) {
				bits[i]=false;
			}
		}
		inline void incDay(void) {
			day++;
		}
		inline unsigned int getDay(void) {
			return day;
		}

		inline void print(void) {
			printf("day is %d\n",day);
			printf("numBits is %d\n",numBits);
			for(unsigned int i=0;i<NUM_PRIS;i++) {
				printf("%d",bits[i]);
			}
			printf("\n");
		}
		inline void updateBit(unsigned int bit) {
			if(bits[bit]==false) {
				bits[bit]=true;
				numBits++;
			}
		}
};

PrisonersKnowledge* know[NUM_PRIS];

void print_stats(void) {
	for(unsigned int i=0;i<NUM_PRIS;i++) {
		know[i]->print();
	}
}

/**
 * Allocate all prisoners knowledge and give each one it's own number
 */
void alloc_pris(void) {
	for(unsigned int i=0;i<NUM_PRIS;i++) {
		know[i]=new PrisonersKnowledge(i);
	}
}

/**
 * Prisoners don't know anything at the begining...
 */
void null_pris_knowledge(void) {
	for(unsigned int i=0;i<NUM_PRIS;i++) {
		know[i]->nullit();
	}
}

/**
 * This method should update the bit vector of a prisoner on the assumption
 * that on the day 'day' the light is on...
 */
void update_prisoner_knowledge(unsigned int pris,unsigned int day) {
	if(algType==ALG_AWFUL_POWER) {
		for(unsigned int bit=0;bit<MAX_BITS;bit++) {
			if(day & (1<<bit)) {
				know[pris]->updateBit(bit);
			}
		}
	}
	if(algType==ALG_ONEBIT) {
		know[pris]->updateBit(day%NUM_PRIS);
	}
	if(algType==ALG_GROUPS_OF_N) {
		if(day>N_START) {
			if((day%NUM_PRIS)%N==0 && day%NUM_PRIS>0) {
				unsigned int u=day%NUM_PRIS;
				for(unsigned int i=u;i<u+N;i++) {
					know[pris]->updateBit(i);
				}
			} else {
				know[pris]->updateBit(day%NUM_PRIS);
			}
		} else {
			know[pris]->updateBit(day%NUM_PRIS);
		}
	}
	if(algType==ALG_LINEAR) {
		for(unsigned int i=0;i<day%NUM_PRIS;i++) {
			know[pris]->updateBit(i);
		}
	}
}

/**
 * Does the prisoner think that everyone has been seen ?
 */
bool prisoner_knowledge_full(unsigned int pris) {
	return know[pris]->isFull();
}

/**
 * Does a new number match what the prisoner knows ?
 */

bool should_prisoner_light_on(unsigned int pris,unsigned int day) {
	if(algType==ALG_AWFUL_POWER) {
		for(unsigned int bit=0;bit<MAX_BITS;bit++) {
			if(day & (1<<bit)) {
				if(know[pris]->hasBit(bit)) {
					return false;
				}
			}
		}
		return true;
	}
	if(algType==ALG_ONEBIT) {
		return know[pris]->hasBit(day%NUM_PRIS);
	}
	if(algType==ALG_GROUPS_OF_N) {
		if(day>N_START) {
			if((day%NUM_PRIS)%N==0 && day%NUM_PRIS>0) {
				bool res=true;
				unsigned int u=day%NUM_PRIS;
				for(unsigned int i=u;i<u+N;i++) {
					if(!(know[pris]->hasBit(i))) {
						res=false;
						break;
					}
				}
				return res;
			} else {
				return know[pris]->hasBit(day%NUM_PRIS);
			}
		} else {
			return know[pris]->hasBit(day%NUM_PRIS);
		}
	}
	if(algType==ALG_LINEAR) {
		bool res=true;
		for(unsigned int i=0;i<day%NUM_PRIS;i++) {
			if(!(know[pris]->hasBit(i))) {
				res=false;
				break;
			}
		}
		return res;
	}
}

/*
 * return the next prisoner to visit the room.
 * Technically: a random number from 0 to NUM_PRIS-1
 * I'm not sure that this is the best way to pick a number from 0 to NUM_PRIS-1
 * since rand() returns a random number between 0 and MAX_RAND-1.
 */
unsigned int pick_prisoner(void) {
	return rand()%NUM_PRIS;
}

Experiment* run_experiment(void) {
	Experiment* e=new Experiment();
	// all prisoners have not visited the room
	null_pris_knowledge();
	bool over=false;
	bool light=false;
	while(!over) {
		int curr_pris=pick_prisoner();
		e->updateBit(curr_pris);
		if(light==true) {
			update_prisoner_knowledge(curr_pris,e->getDay());
			if(prisoner_knowledge_full(curr_pris)) {
				know[curr_pris]->print();
				over=true;
			}
			// turn off the light
			light=false;
		}
		e->incDay();
		if(should_prisoner_light_on(curr_pris,e->getDay())) {
			light=true;
		}
		if(do_debug) {
			if(e->getDay()%DEBUG_INTERVAL==0) {
				unsigned int allBits=0;
				for(unsigned int i=0;i<NUM_PRIS;i++) {
					allBits+=know[i]->getNumBits();
				}
				printf("day is %d, all bits %d\r",e->getDay(),allBits);
				fflush(stdout);
			}
			if(e->getDay()%DEBUG_PRINT==0) {
				print_stats();
			}
		}
	}
	return e;
}

int main(int argc,char** argv,char** envp) {
	alloc_pris();
	while(true) {
		Experiment* e=run_experiment();
		e->print();
		delete e;
	}
	return 0;
}
