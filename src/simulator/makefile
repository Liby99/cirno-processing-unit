LIBRARY_FILES = cpu.cpp loader.cpp

all: simulate debug

simulate: simulate.cpp $(LIBRARY_FILES)
	g++ simulate.cpp -o simulate

debug: debug.cpp $(LIBRARY_FILES)
	g++ debug.cpp -o debug

copy-programs:
	cp ../../test/prog1/compiled/prog1.mem programs/prog1.mem
	cp ../../test/prog2/compiled/prog2.mem programs/prog2.mem
	cp ../../test/prog3/compiled/prog3.mem programs/prog3.mem