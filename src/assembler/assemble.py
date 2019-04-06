import sys
from typing import List

def pad_zero(s: str, l: int):
  if len(s) < l:
    return ("0" * (l - len(s))) + s
  else:
    return s

def last_digits(s: str, l: int):
  return pad_zero(s, l)[-l:]

def binary_repr(num: int, length: int):
  return last_digits(repr(bin(num))[3:-1], length)

class Instruction:
  def __init__(self):
    pass

  def __repr__(self):
    pass

  def opcode(self) -> str:
    pass

class Jmpi(Instruction):
  def __init__(self, sign: bool, imm: int):
    """
    sign: boolean, positive is True, negative is False
    imm: number
    """
    self.sign = sign
    self.imm = imm

  def opcode(self) -> str:
    return "111"

  def __repr__(self):
    s = "0" if self.sign else "1"
    i = binary_repr(self.imm, 5)
    return self.opcode() + s + i

class AImmInstruction(Instruction):
  def __init__(self, rega: int, imm: int):
    self.rega = rega
    self.imm = imm

  def __repr__(self):
    return self.opcode() + binary_repr(self.rega, 2) + binary_repr(self.imm, 4)

class Andi(AImmInstruction):
  def opcode(self) -> str:
    return "110"

class Lih(AImmInstruction):
  def opcode(self) -> str:
    return "101"

class Lil(AImmInstruction):
  def opcode(self) -> str:
    return "100"

class AShamtInstruction(Instruction):
  def __init__(self, rega: int, shamt: int):
    self.rega = rega
    self.shamt = shamt

  def __repr__(self):
    return self.opcode() + binary_repr(self.rega, 2) + binary_repr(self.shamt, 3)

class Shri(AShamtInstruction):
  def opcode(self):
    return "0111"

class Shli(AShamtInstruction):
  def opcode(self):
    return "0110"

class ABInstruction(Instruction):
  def __init__(self, rega: int, regb: int):
    self.rega = rega
    self.regb = regb

  def __repr__(self):
    return self.opcode() + binary_repr(self.rega, 2) + binary_repr(self.regb, 2)

class Sb(ABInstruction):
  def opcode(self):
    return "01011"

class Lb(ABInstruction):
  def opcode(self):
    return "01010"

class Shrr(ABInstruction):
  def opcode(self):
    return "01001"

class Shlr(ABInstruction):
  def opcode(self):
    return "01000"

class Mov(ABInstruction):
  def opcode(self):
    return "00111"

class Cmp(ABInstruction):
  def opcode(self):
    return "00110"

class Add(ABInstruction):
  def opcode(self):
    return "00101"

class Sub(ABInstruction):
  def opcode(self):
    return "00100"

class And(ABInstruction):
  def opcode(self):
    return "00011"

class Or(ABInstruction):
  def opcode(self):
    return "00010"

class Xor(ABInstruction):
  def opcode(self):
    return "00001"

class AInstruction(Instruction):
  def __init__(self, rega: int):
    self.rega = rega

  def __repr__(self):
    return self.opcode() + binary_repr(self.rega, 2)

class Incr(AInstruction):
  def opcode(self):
    return "0000011"

class Jmpr(AInstruction):
  def opcode(self):
    return "0000010"

class Br(AInstruction):
  def opcode(self):
    return "0000001"

class Nil(Instruction):
  def __repr__(self):
    return "000000000"

def parse_reg(str: str) -> int:
  assert str[0] == "$"
  return int(str[1:])

def parse_instr(str: str) -> Instruction:
  arr = str.split(" ")
  op = arr[0]
  if op == "jmpi":
    imm = arr[1]
    sign = imm[0] == '-'
    return Jmpi(sign, abs(int(imm)))
  elif op == "andi":
    rega = parse_reg(arr[1])
    imm = int(arr[2])
    return Andi(rega, imm)
  elif op == "lih":
    rega = parse_reg(arr[1])
    imm = int(arr[2])
    return Lih(rega, imm)
  elif op == "lil":
    rega = parse_reg(arr[1])
    imm = int(arr[2])
    return Lil(rega, imm)
  elif op == "shri":
    rega = parse_reg(arr[1])
    shamt = int(arr[2])
    return Shri(rega, shamt)
  elif op == "shli":
    rega = parse_reg(arr[1])
    shamt = int(arr[2])
    return Shli(rega, shamt)
  elif op == "sb":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Sb(rega, regb)
  elif op == "lb":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Lb(rega, regb)
  elif op == "shrr":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Shrr(rega, regb)
  elif op == "shlr":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Shlr(rega, regb)
  elif op == "mov":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Mov(rega, regb)
  elif op == "cmp":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Cmp(rega, regb)
  elif op == "add":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Add(rega, regb)
  elif op == "sub":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Sub(rega, regb)
  elif op == "and":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return And(rega, regb)
  elif op == "or":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Or(rega, regb)
  elif op == "xor":
    rega = parse_reg(arr[1])
    regb = parse_reg(arr[2])
    return Xor(rega, regb)
  elif op == "incr":
    rega = parse_reg(arr[1])
    return Incr(rega)
  elif op == "jmpr":
    rega = parse_reg(arr[1])
    return Jmpr(rega)
  elif op == "br":
    rega = parse_reg(arr[1])
    return Br(rega)
  elif op == "nil":
    return Nil()
  else:
    raise Exception("Not Implemented")

def parse_args(args: List[str]):
  obj = {}
  for arg in args:
    if arg == '--c-style':
      obj['c_style'] = True
  return obj

if __name__ == "__main__":
  with open(sys.argv[1]) as file:
    options = parse_args(sys.argv[2:])

    # First go through all the lines
    machine_codes = []
    for instr in file:

      # Ignore comment only line
      trimmed = instr[0:instr.find('#')]
      if len(trimmed) == 0:
        continue

      # Parse the instruction to machine code
      machine_codes.append(parse_instr(instr))

    # Print the codes
    for c in machine_codes:
      if 'c_style' in options:
        print("0b" + repr(c) + ",")
      else:
        print(c)