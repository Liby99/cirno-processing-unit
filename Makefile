prog3:
	make -C test/prog3
	make prog3 -C src/assembler
	make prog3 -C src/simulator


clean: clean_prog3

clean_prog3:
	make clean_prog3 -C src/simulator
	make clean -C test/prog3

