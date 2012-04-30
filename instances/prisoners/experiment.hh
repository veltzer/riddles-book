template<class PrisonerType> class Experiment {
	private:
		// number of prisoners in this experiment
		unsigned int numpris;
		// who was in the cell
		bool* bits;
		// how many were in the cell
		unsigned int numBits;
		// what day is it
		unsigned int day;
		// all the prisoners
		PrisonerType* prisoners;
		// should we debug
		bool do_debug;

	public:
		inline Experiment(unsigned int inumpris,bool ido_debug) {
			numpris=inumpris;
			do_debug=ido_debug;
			numBits=0;
			day=0;
			bits=new bool[numpris];
			for(unsigned int i=0;i<numpris;i++) {
				bits[i]=false;
			}
			prisoners=new PrisonerType[numpris];
			// give the prisoners some info using init
			for(unsigned int i=0;i<numpris;i++) {
				prisoners[i].init(i,numpris);
			}
		}
		inline ~Experiment() {
			delete bits;
			delete prisoners;
		}
		inline void incDay(void) {
			day++;
		}
		inline unsigned int getDay(void) {
			return day;
		}

		inline std::ostream& operator<<(std::ostream& out) {
			out << "day is " << day << std::endl;
			out << "numBits is " << numBits << std::endl;
			out << "numpris is " << numpris << std::endl;
			for(unsigned int i=0;i<numpris;i++) {
				out << bits[i];
			}
			out << std::endl;
			for(unsigned int i=0;i<numpris;i++) {
				out << prisoners[i];
			}
			return out;
		}
		inline void updateBit(unsigned int bit) {
			if(bits[bit]==false) {
				bits[bit]=true;
				numBits++;
			}
		}
		/*
		 * return the next prisoner to visit the room.
		 * Technically: a random number from 0 to NUM_PRIS-1
		 * I'm not sure that this is the best way to pick a number from 0 to NUM_PRIS-1
		 * since rand() returns a random number between 0 and MAX_RAND-1.
		 */
		PrisonerType& pick_prisoner(void) {
			int prisonerpicked=rand()%numpris;
			updateBit(prisonerpicked);
			return prisoners[rand()%numpris];
		}
		/**
		 * Prisoners don't know anything at the begining...
		 */
		void null_pris_knowledge(void) {
			for(unsigned int i=0;i<numpris;i++) {
				prisoners[i].nullit();
			}
		}

		void run(void) {
			// all prisoners have not visited the room
			null_pris_knowledge();
			bool over=false;
			bool light=false;
			while(!over) {
				PrisonerType& prisoner=pick_prisoner();
				light=prisoner.doYourThing(light);
				if(prisoner.wantToEnd()) {
					over=true;
				}
				if(do_debug) {
					std::cout << this;
				}
				incDay();
			}
		}
};
