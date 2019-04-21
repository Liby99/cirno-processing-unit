from typing import Dict

def pad_zero(s: str, l: int) -> str:
  if len(s) < l:
    return ("0" * (l - len(s))) + s
  else:
    return s

def last_digits(s: str, l: int) -> str:
  return pad_zero(s, l)[-l:]

def binary_repr(num: int, length: int) -> str:
  return last_digits(repr(bin(num))[3:-1], length)

class Instruction:
  def __init__(self):
    pass

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    pass

  def opcode(self) -> str:
    pass

class Jmpi(Instruction):
  def __init__(self, neg: bool, imm: int):
    self.neg = neg
    self.imm = imm

  def opcode(self) -> str:
    return "111"

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    s = "1" if self.neg else "0"
    i = binary_repr(self.imm, 5)
    return self.opcode() + s + i

class AImmInstruction(Instruction):
  def __init__(self, rega: int, imm: int):
    self.rega = rega
    self.imm = imm

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    return self.opcode() + binary_repr(self.rega, 2) + binary_repr(self.imm, 4)

class Andi(AImmInstruction):
  def opcode(self) -> str:
    return "110"

class Movih(AImmInstruction):
  def opcode(self) -> str:
    return "101"

class Movil(AImmInstruction):
  def opcode(self) -> str:
    return "100"

class AShamtInstruction(Instruction):
  def __init__(self, rega: int, shamt: int):
    self.rega = rega
    self.shamt = shamt

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    return self.opcode() + binary_repr(self.rega, 2) + binary_repr(self.shamt, 3)

class Shri(AShamtInstruction):
  def opcode(self):
    return "0111"

class Shli(AShamtInstruction):
  def opcode(self):
    return "0110"

class Beqi(Instruction):
  def __init__(self, neg: bool, imm: int):
    self.neg = neg
    self.imm = imm

  def opcode(self):
    return "01011"

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    s = "1" if self.neg else "0"
    return self.opcode() + s + binary_repr(self.imm, 3)

class ABInstruction(Instruction):
  def __init__(self, rega: int, regb: int):
    self.rega = rega
    self.regb = regb

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    return self.opcode() + binary_repr(self.rega, 2) + binary_repr(self.regb, 2)

class Sh(ABInstruction):
  def opcode(self):
    return "01010"

class St(ABInstruction):
  def opcode(self):
    return "01001"

class Ld(ABInstruction):
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

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    return self.opcode() + binary_repr(self.rega, 2)

class Incr(AInstruction):
  def opcode(self):
    return "0000011"

class Jmp(AInstruction):
  def opcode(self):
    return "0000010"

class Beq(AInstruction):
  def opcode(self):
    return "0000001"

class EInstruction(Instruction):
  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    return self.opcode()

class Halt(EInstruction):
  def opcode(self):
    return "000000001"

class Nil(EInstruction):
  def opcode(self):
    return "000000000"

class MoveLabel(Instruction):
  def __init__(self, reg: int, is_upper: bool, label: str):
    self.reg = reg
    self.is_upper = is_upper
    self.label = label

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    if not self.label in labels:
      raise Exception("Label {} doesn't exist".format(self.label))
    label_index = labels[self.label]
    if self.is_upper:
      num = (label_index >> 4) & 15
      return Movih(self.reg, num).to_binary(index, labels)
    else:
      num = label_index & 15
      return Movil(self.reg, num).to_binary(index, labels)

class JumpImmediateLabel(Instruction):
  def __init__(self, label: str):
    self.label = label

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    if not self.label in labels:
      raise Exception("Label {} doesn't exist".format(self.label))
    label_index = labels[self.label]
    diff = label_index - index
    assert abs(diff) < 32
    is_neg = diff < 0
    return Jmpi(is_neg, abs(diff)).to_binary(index, labels)

class BranchImmediateLabel(Instruction):
  def __init__(self, label: str):
    self.label = label

  def to_binary(self, index: int, labels: Dict[str, int]) -> str:
    if not self.label in labels:
      raise Exception("Label {} doesn't exist".format(self.label))
    label_index = labels[self.label]
    diff = label_index - index
    assert abs(diff) < 8
    is_neg = diff < 0
    return Beqi(is_neg, abs(diff)).to_binary(index, labels)