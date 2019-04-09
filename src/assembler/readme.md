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

## Exporting Simulator Runnable File

```
$ python3 assemble.py test/add.s > ../simulator/test/add.txt
```

Then give this `add.txt` to simulator and it will be able to directly run the file

## Print Debugging Symbols

When doing assembly, add a flag `--debug` to enable debugging. Like this:

```
$ python3 assemble.py test/prog2.s --debug
```

## Assembly Language Syntax

It's very simple, we don't have any symbols. For each instruction specified on the design document, you simply add space between the different components. All the instruction will start with a **code**, like `jmpi`, `add`, `xor` and so on. After that it needs to be followed by either register id or immediate numbers.

If you want to specify the registers, you can only use `$0`, `$1`, `$2`, and `$3` since there are only 4 registers in our CPU.

When you want to specify the immediate, usually you only need positive number. There's one case in the `jmpi` instruction you can actually add a `minus` sign before the number to indicate that you want to jump backward.

## TODO

- [ ] Add `0b0011` and `0xf` kind of syntax support when parsing immediate
- [x] Add Commenting Support. When seeing `;` at the start of the line, stop parsing and go to the next line