import sys, os
from typing import List
from parser import parse_label, parse_instr, is_label

machine_codes = []
labels = {}

if __name__ == "__main__":
  if len(sys.argv) < 2:
    print("Please specify the file you want to assemble")
    exit(1)

  filepath = os.path.join(os.getcwd(), sys.argv[1])
  with open(filepath) as file:

    # First go through all the lines
    for instr in file:

      # Ignore comment only line
      trimmed = str.strip(instr[0:instr.find('#')])
      if len(trimmed) == 0:
        continue

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