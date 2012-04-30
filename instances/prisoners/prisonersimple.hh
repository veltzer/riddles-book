#ifndef __prisonersimple_hh
#define __priosnerfull_hh

#include "prisoner.hh"

class PrisonerSimple:public Prisoner {
	private:
		// what type of prisoner am I
		bool type;
		// for the special prisoner
		unsigned int counter;
		// for the special prisoner
		unsigned int prisnum;
		// for all the other prisoners
		bool didILightItOn;
	public:
		PrisonerSimple();
		~PrisonerSimple();
		void init(int imynum,int iprisnum);
		void nullit(void);
		bool wantToEnd(void);
		bool doYourThing(bool light);
		void output(std::ostream& out) const;
};

#endif // __prisonersimple_hh
