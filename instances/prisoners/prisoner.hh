#ifndef __prisoner_hh
#define __prisoner_hh

#include<ostream> // for std::ostream

class Prisoner {
	public:
		virtual void init(int imynum,int iprisnum)=0;
		virtual void nullit()=0;
		virtual bool wantToEnd()=0;
		virtual bool doYourThing(bool)=0;
		virtual std::ostream& operator<<(std::ostream& out)=0;
};

#endif // __prisoner_hh
