all: prog3
	gcc prog3.c -o prog3

expand:
	touch temp.s
	cat prologue >> temp.s
	sed '/#/d' prog3.s  >> temp.s
	cat epilogue >> temp.s
	cpp -P temp.s > prog3_arm.s
	rm temp.s