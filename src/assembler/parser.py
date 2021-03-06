from typing import Union, List
from instruction import *

def trim_comment(s: str) -> str:
  comment_index = s.find(';')
  if comment_index >= 0:
    return str.strip(s[0:comment_index])
  return str.strip(s)

def parse_reg(s: str) -> int:
  assert s[0] == "$"
  return int(s[1:])

def parse_instr(s: str) -> Union[Instruction, List[Instruction]]:
  try:
    arr = [e for e in s.replace('\t',' ').replace(',',' ').split(" ") if e != ""]
    op = arr[0]

    # ---- Basic Instructions ----

    if op == "jmpi":
      imm = arr[1]
      sign = imm[0] == '-'
      return Jmpi(sign, abs(int(imm)))

    elif op == "andi":
      rega = parse_reg(arr[1])
      imm = int(arr[2])
      return Andi(rega, imm)

    elif op == "movih":
      rega = parse_reg(arr[1])
      imm = int(arr[2])
      return Movih(rega, imm)

    elif op == "movil":
      rega = parse_reg(arr[1])
      imm = int(arr[2])
      return Movil(rega, imm)

    elif op == "shri":
      rega = parse_reg(arr[1])
      shamt = int(arr[2])
      return Shri(rega, shamt)

    elif op == "shli":
      rega = parse_reg(arr[1])
      shamt = int(arr[2])
      return Shli(rega, shamt)

    elif op == "beqi":
      imm = arr[1]
      neg = imm[0] == '-'
      return Beqi(neg, abs(int(imm)))

    elif op == "sh":
      rega = parse_reg(arr[1])
      regb = parse_reg(arr[2])
      return Sh(rega, regb)

    elif op == "st" or op == "sb":
      rega = parse_reg(arr[1])
      regb = parse_reg(arr[2])
      return St(rega, regb)

    elif op == "ld" or op == "lb":
      rega = parse_reg(arr[1])
      regb = parse_reg(arr[2])
      return Ld(rega, regb)

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

    elif op == "jmp":
      rega = parse_reg(arr[1])
      return Jmp(rega)

    elif op == "beq":
      rega = parse_reg(arr[1])
      return Beq(rega)

    elif op == "halt":
      return Halt()

    elif op == "nil":
      return Nil()

    # ---- Special Instructions that will be compiled to other instructions ----

    elif op == "clr":
      rega = parse_reg(arr[1])
      return Andi(rega, 0)

    elif op == "movl":
      rega = parse_reg(arr[1])
      label = arr[2]
      return [
        MoveLabel(rega, True, label),
        MoveLabel(rega, False, label)
      ]

    elif op == "movi":
      rega = parse_reg(arr[1])
      imm = int(arr[2])
      assert imm >= 0 # Immediate is always unsigned
      upper, lower = (imm >> 4) & 15, imm & 15
      return [Movih(rega, upper), Movil(rega, lower)]

    elif op == "jmpl":
      reg = parse_reg(arr[1])
      label = arr[2]
      return [
        MoveLabel(reg, True, label),
        MoveLabel(reg, False, label),
        Jmp(reg)
      ]

    elif op == "beql":
      reg = parse_reg(arr[1])
      label = arr[2]
      return [
        MoveLabel(reg, True, label),
        MoveLabel(reg, False, label),
        Beq(reg)
      ]

    elif op == "jmpil":
      label = arr[1]
      return JumpImmediateLabel(label)

    elif op == "beqil":
      label = arr[1]
      return BranchImmediateLabel(label)

    else:
      raise Exception("Unknown command {}".format(op))
  except Exception as ex:
    print("Error when parsing \"{}\": {}".format(s, ex))
    raise ex

def parse_label(s: str) -> str:
  return str.strip(s[0:s.find(":")])

def is_label(s: str) -> str:
  return s.find(":") >= 0