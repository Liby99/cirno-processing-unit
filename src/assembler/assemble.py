import sys, os
from typing import List
from parser import trim_comment, is_label, parse_label, parse_instr

machine_codes = []
debug_labels = {}
labels = {}

if __name__ == "__main__":
  if len(sys.argv) < 2:
    print("Please specify the file you want to assemble")
    exit(1)

  options = {}
  for arg in sys.argv[2:]:
    if arg == "--print-instr":
      options["print_instr"] = True
    if arg == "--print-original":
      options["print_original"] = True
    if arg == "--debug":
      options["debug"] = True

  filepath = os.path.join(os.getcwd(), sys.argv[1])
  with open(filepath) as file:

    # First go through all the lines
    for line in file:

      if "print_original" in options:
        print(line)

      # Ignore comment only line
      trimmed = trim_comment(line)
      if len(trimmed) == 0:
        continue

      # Print the instruction
      if "print_instr" in options:
        print(trimmed)

      if "debug" in options:
        if not len(machine_codes) in debug_labels:
          debug_labels[len(machine_codes)] = {}

      # Parse the instruction to machine code
      if is_label(trimmed):
        label = parse_label(trimmed)
        labels[label] = len(machine_codes)
        if "debug" in options:
          debug_labels[len(machine_codes)]["label"] = label
      else:
        instrs = parse_instr(trimmed)
        if "debug" in options:
          debug_labels[len(machine_codes)]["instr"] = trimmed
        if isinstance(instrs, list):
          machine_codes += instrs
        else:
          machine_codes.append(instrs)

    # Print the codes
    num_digits = len(str(len(machine_codes)))
    for index in range(len(machine_codes)):
      if "debug" in options:
        i = str(index).rjust(num_digits, ' ')
        b = machine_codes[index].to_binary(index, labels)
        c = debug_labels[index]["instr"] if index in debug_labels else ""
        has_label = index in debug_labels and "label" in debug_labels[index]
        l = "<- " + debug_labels[index]["label"] if has_label else ""
        print("{}: {} {} {}".format(i, b, c, l))
      else:
        print(machine_codes[index].to_binary(index, labels))