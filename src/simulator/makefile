LIBRARY_FILES = cpu.cpp loader.cpp

all: simulate debug

simulate: simulate.cpp $(LIBRARY_FILES)
	g++ simulate.cpp -o simulate

debug: debug.cpp $(LIBRARY_FILES)
	g++ debug.cpp -o debug