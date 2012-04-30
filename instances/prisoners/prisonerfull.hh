#ifndef __prisonerfull_hh
#define __priosnerfull_hh

#include "prisoner.hh"

class PrisonerFull:public Prisoner {
	private:
		bool* bits;
		unsigned int numBits;
		unsigned int mynum;
		unsigned int prisnum;
	public:
		void init(int imynum,int iprisnum);
		void nullit(void);
		PrisonerFull();
		~PrisonerFull();
		bool wantToEnd(void);
		bool hasBit(unsigned int bit);
		unsigned int getNumBits(void);
		void updateBit(unsigned int bit);
		std::ostream& operator<<(std::ostream& out);
		bool doYourThing(bool light);
};

#endif // __prisonerfull_hh
