prog3:
	make -C test/prog3
	make prog3 -C src/assembler
	make prog3 -C src/simulator

