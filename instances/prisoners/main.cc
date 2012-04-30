#include<stdio.h>
#include<stdlib.h>
#include<ostream> // for std::ostream
#include<iostream> // for std::cerr
#include<stdlib.h> // for EXIT_SUCCESS, EXIT_FAILURE, atoi(3), srand(3)
#include<time.h> // for time(2)

#include"experiment.hh"
#include"prisonerfull.hh"
#include"prisonersimple.hh"

int main(int argc,char** argv,char** envp) {
	if(argc!=3) {
		std::cerr << argv[0] << ": usage: " << argv[0] << " [numpris] [dodebug]" << std::endl;
		return EXIT_FAILURE;
	}
	// initialize the random number generator with random data
	srand(time(NULL)); // FIXME: what about error handling?
	const int numpris=atoi(argv[1]);
	const bool do_debug=atoi(argv[2]);
	//Experiment<PrisonerFull> e(numpris,do_debug);
	Experiment<PrisonerSimple> e(numpris,do_debug);
	e.run();
	std::cout << "experiment ended after " << e.getDay() << " days" << std::endl;
	return EXIT_SUCCESS;
}
