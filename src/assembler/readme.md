# Assembler Usage

It's as simple as

```
$ python3 assemble.py test/add.s
```

This will print out the following result

```
101000101
100000101
100010011
001010000
```

There's also a command line flag of thie program `--c-style`:

```
$ python3 assemble.py test/add.s --c-style
```

The output will then be

```
0b101000101,
0b100000101,
0b100010011,
0b001010000,
```

This way you can more easily copy this assembled machine code to the simulator and run this.

## Assembly Language Syntax

It's very simple, we don't have any symbols. For each instruction specified on the design document, you simply add space between the different components. All the instruction will start with a **code**, like `jmpi`, `add`, `xor` and so on. After that it needs to be followed by either register id or immediate numbers.

If you want to specify the registers, you can only use `$0`, `$1`, `$2`, and `$3` since there are only 4 registers in our CPU.

When you want to specify the immediate, usually you only need positive number. There's one case in the `jmpi` instruction you can actually add a `minus` sign before the number to indicate that you want to jump backward.

## TODO

- [ ] Add `0b003` and `0xf` kind of syntax support when parsing immediate
- [ ] Add Commenting Support. When seeing `#` at the start of the line, stop parsing and go to the next line