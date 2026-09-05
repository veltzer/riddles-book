#ifndef __prisonersimple_hh
#define __prisonersimple_hh

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
		void init(int imynum,int iprisnum) override;
		void nullit(void) override;
		bool wantToEnd(void) override;
		bool doYourThing(bool light) override;
		void output(std::ostream& out) const override;
};

#endif // __prisonersimple_hh
