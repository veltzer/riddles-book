
const unsigned int MAX_BITS=32;
const bool do_debug=false;
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

const AlgType algType=ALG_ONEBIT;
//const AlgType algType=ALG_GROUPS_OF_N;
//const AlgType algType=ALG_LINEAR;


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

