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
		PrisonerFull();
		~PrisonerFull();
		void init(int imynum,int iprisnum);
		void nullit(void);
		bool wantToEnd(void);
		bool doYourThing(bool light);
		void output(std::ostream& out) const;

		bool hasBit(unsigned int bit);
		unsigned int getNumBits(void);
		void updateBit(unsigned int bit);
};

#endif // __prisonerfull_hh
