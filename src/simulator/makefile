LIBRARY_FILES = cpu.cpp loader.cpp

all: simulate debug

simulate: simulate.cpp $(LIBRARY_FILES)
	g++ simulate.cpp -o simulate

debug: debug.cpp $(LIBRARY_FILES)
	g++ debug.cpp -o debug

copy_programs:
	cp ../../test/prog1/compiled/prog1.mem programs/prog1.mem
	cp ../../test/prog2/compiled/prog2.mem programs/prog2.mem
	cp ../../test/prog3/compiled/prog3.mem programs/prog3.mem

prog3:
	./simulate test/prog3.txt memory/prog3_test1.mem > result/prog3_result1.mem
	./simulate test/prog3.txt memory/prog3_test2.mem > result/prog3_result2.mem
	./simulate test/prog3.txt memory/prog3_test3.mem > result/prog3_result3.mem
	python3 verify_prog3.py

clean_prog3:
	rm -f  test/prog3.txt  memory/prog3*  result/*