import sys, os
from typing import List
from parser import trim_comment, is_label, parse_label, parse_instr

machine_codes = []
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

      # Parse the instruction to machine code
      if is_label(trimmed):
        label = parse_label(trimmed)
        labels[label] = len(machine_codes)
      else:
        instrs = parse_instr(trimmed)
        if isinstance(instrs, list):
          machine_codes += instrs
        else:
          machine_codes.append(instrs)

    # Print the codes
    for index in range(len(machine_codes)):
      print(machine_codes[index].to_binary(index, labels))