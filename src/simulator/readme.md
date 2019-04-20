# Cirno Simulator Usage

This Simulator will try to run already formatted machine codes.

How to build this simulator?

```
$ make
```

How to run an file containing machine code?

```
$ ./simulate ./test/add.txt
```

You can also attach an initiated test use data memory file by adding another argument

```
$ ./simulate ./test/prog2.txt ./memory/prog2.mem
```

## Debugging

We also have a debugger designed to debug our program. How to build the debugger?

``` bash
$ make
```

How to debug?

``` bash
$ ./debug ./test/prog2.txt ./memory/prog2.mem
```

Then the process is pretty much like all the other debugger program. Inside the
command line you can do

```
(cdb) > help # Print help message
(cdb) > list # List the instructions around the current line
(cdb) > break 5 # Set breakpoint at line
(cdb) > break 6 # Set breakpoint at line 6
(cdb) > list breakpoint # List all breakpoints
(cdb) > remove breakpoint 3 # remove breakpoint number 3
(cdb) > remove breakpoint # Remove all breakpoints
(cdb) > run # Run until breakpoint or halt
(cdb) > step # Step once
(cdb) > print pc # Print the value of pc
(cdb) > print reg # Print the value of registers
(cdb) > print cmp # Print the value of cmp
(cdb) > print mem # Print the whole memory
(cdb) > print mem 251 # Print the memory at location 251
(cdb) > print mem 0 29 # Print the memory from 0 to 29
```