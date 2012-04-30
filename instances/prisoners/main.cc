#include<stdio.h>
#include<stdlib.h>
#include<ostream> // for std::ostream
#include<iostream> // for std::cerr
#include<stdlib.h> // for EXIT_SUCCESS, EXIT_FAILURE, atoi(3)

#include"experiment.hh"
#include"prisonerfull.hh"

int main(int argc,char** argv,char** envp) {
	if(argc!=3) {
		std::cerr << argv[0] << ": usage: " << argv[0] << " [numpris] [dodebug]" << std::endl;
		return EXIT_FAILURE;
	}
	const int numpris=atoi(argv[1]);
	const bool do_debug=atoi(argv[2]);
	Experiment<PrisonerFull> e(numpris,do_debug);
	e.run();
	return EXIT_SUCCESS;
}
