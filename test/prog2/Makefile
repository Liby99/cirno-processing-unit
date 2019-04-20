PROGRAM = prog2
ASSEMBLER = ../../src/assembler/assemble.py
TO_INSTR_BYTE_CODE = ../../src/tools/to_instr_byte_code.py

all: c-test directory machine-code debug verilog-code

c-test: $(PROGRAM)
	gcc $(PROGRAM).c -o $(PROGRAM)

directory:
	mkdir -p compiled

machine-code:
	rm -f compiled/$(PROGRAM).mem
	python3 $(ASSEMBLER) ./$(PROGRAM).s > compiled/$(PROGRAM).mem

debug:
	rm -f compiled/$(PROGRAM).debug
	python3 $(ASSEMBLER) ./$(PROGRAM).s --debug > compiled/$(PROGRAM).debug

verilog-code:
	rm -f compiled/$(PROGRAM).mem.sv
	python3 $(ASSEMBLER) ./$(PROGRAM).s --verilog > compiled/$(PROGRAM).mem.sv