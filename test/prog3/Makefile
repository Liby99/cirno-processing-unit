all: expandARM expand
	# gcc prog3.c -o prog3

expandARM:
	touch temp.s
	cat prologue >> temp.s
	sed '/#/d' prog3.s  >> temp.s
	cat epilogue >> temp.s
	cpp -P temp.s > prog3_arm.s
	rm temp.s

expand:
	cpp -P prog3.s > temp.s
	sed 's/\/.*//g' temp.s  > temp1.s
	tr -d '[]=,' < temp1.s > prog3_expanded.s
	rm temp.s temp1.s