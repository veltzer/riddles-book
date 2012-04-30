#include "prisonerfull.hh"

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
PrisonerFull::PrisonerFull() {
}
PrisonerFull::~PrisonerFull() {
	delete bits;
}
bool PrisonerFull::wantToEnd(void) {
	return numBits==prisnum;
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
std::ostream& PrisonerFull::operator<<(std::ostream& out) {
	out << "prisoner #" << mynum << " " << numBits << std::endl;
	for(unsigned int i=0;i<prisnum;i++) {
		out << bits[i];
	}
	out << std::endl;
	return out;
}
bool PrisonerFull::doYourThing(bool light) {
	return light;
}
