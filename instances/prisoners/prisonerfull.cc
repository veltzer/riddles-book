#include "prisonerfull.hh"

PrisonerFull::PrisonerFull() {
}
PrisonerFull::~PrisonerFull() {
	delete bits;
}
void PrisonerFull::init(int imynum,int iprisnum) {
	mynum=imynum;
	prisnum=iprisnum;
	bits=new bool[prisnum];
}
void PrisonerFull::nullit(void) {
	numBits=0;
	for(unsigned int i=0;i<prisnum;i++) {
		bits[i]=false;
	}
	updateBit(mynum);
}
bool PrisonerFull::wantToEnd(void) {
	return numBits==prisnum;
}
bool PrisonerFull::doYourThing(bool light) {
	return light;
}
void PrisonerFull::output(std::ostream& out) const {
	out << "prisoner #" << mynum << " " << numBits << std::endl;
	for(unsigned int i=0;i<prisnum;i++) {
		out << bits[i];
	}
	out << std::endl;
}
bool PrisonerFull::hasBit(unsigned int bit) {
	return bits[bit];
}
unsigned int PrisonerFull::getNumBits(void) {
	return numBits;
}
void PrisonerFull::updateBit(unsigned int bit) {
	if(bits[bit]==false) {
		bits[bit]=true;
		numBits++;
	}
}
