#include "prisonersimple.hh"

PrisonerSimple::PrisonerSimple() {
}
PrisonerSimple::~PrisonerSimple() {
}
void PrisonerSimple::init(int imynum,int iprisnum) {
	if(imynum==0) {
		type=true;
		prisnum=iprisnum;
	} else {
		type=false;
	}
}
void PrisonerSimple::nullit(void) {
	if(type) {
		counter=1; // include myself
	} else {
		didILightItOn=false;
	}
}
bool PrisonerSimple::wantToEnd(void) {
	if(type) {
		return counter==prisnum;
	} else {
		return false;
	}
}
bool PrisonerSimple::doYourThing(bool light) {
	if(type) {
		if(light) {
			counter++;
			return false;
		} else {
			return false;
		}
	} else {
		if(!didILightItOn && !light) {
			didILightItOn=true;
			return true;
		} else {
			return light;
		}
	}
}
void PrisonerSimple::output(std::ostream& out) const {
	out << "prisoner" <<
		" " << type <<
		" " << didILightItOn <<
		" " << counter <<
		" " << prisnum <<
		std::endl;
}
