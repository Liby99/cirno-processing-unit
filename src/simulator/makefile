LIBRARY_FILES = cpu.cpp loader.cpp

all: simulate debug

simulate: simulate.cpp $(LIBRARY_FILES)
	g++ simulate.cpp -o simulate

debug: debug.cpp $(LIBRARY_FILES)
	g++ debug.cpp -o debug

prog3:
	./simulate test/prog3.txt memory/prog3_test1.mem
	./simulate test/prog3.txt memory/prog3_test2.mem
	./simulate test/prog3.txt memory/prog3_test3.mem

clean_prog3:
	rm -f test/prog3.txt memory/prog3_test1.mem memory/prog3_test2.mem memory/prog3_test3.mem