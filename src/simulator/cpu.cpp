#include <stdio.h>
#include <vector>

typedef unsigned char byte;

typedef unsigned short Instr;

void print_binary(byte x) {
  int l = sizeof(x) * 8;
  for (int i = l - 1 ; i >= 0; i--) {
    printf("%x", (x & (1 << i)) >> i);
  }
}

class CPU {
public:
  CPU(const std::vector<Instr> &instructions, byte *memory)
    : pc(0), cmp(0), instructions(instructions), memory(memory) {
    for (int i = 0; i < 4; i++) {
      regs[i] = 0;
    }
  }

  void step() {
    Instr ins;
    if (pc >= instructions.size()) {
      ins = 0;
    } else {
      ins = instructions[pc];
    }

    bool advance_pc = 1;
    byte b8 = ins >> 8, b7 = (ins >> 7) & 1,
        b6 = (ins >> 6) & 1, b5 = (ins >> 5) & 1;
    if (b8) {
      byte reg = (ins >> 4) & 3;
      byte imm = ins & 15;
      if (b7) {
        if (b6) {
          imm = ins & 31;
          if (b5) {
            pc -= imm;
          } else {
            pc += imm;
          }
          advance_pc = 0;
        } else {
          regs[reg] &= imm;
        }
      } else {
        if (b6) {
          regs[reg] |= imm << 4;
        } else {
          regs[reg] |= imm;
        }
      }
    } else {
      if (b7) {
        if (b6) {
          byte reg = (ins >> 3) & 3;
          byte shamt = ins & 7;
          if (b5) {
            regs[reg] >>= shamt;
          } else {
            regs[reg] <<= shamt;
          }
        } else {
          byte b4 = (ins >> 4) & 1;
          byte rega = (ins >> 2) & 3;
          byte regb = ins & 3;
          if (b5) {
            if (b4) {
              memory[regb] = regs[rega];
            } else {
              regs[rega] = memory[regb];
            }
          } else {
            if (b4) {
              regs[rega] >>= regs[regb];
            } else {
              regs[rega] <<= regs[regb];
            }
          }
        }
      } else {
        byte b4 = (ins >> 4) & 1;
        byte rega = (ins >> 2) & 3;
        byte regb = ins & 3;
        if (b6) {
          if (b5) {
            if (b4) {
              regs[rega] = regs[regb];
            } else {
              cmp = regs[rega] == regs[regb];
            }
          } else {
            if (b4) {
              regs[rega] += regs[regb];
            } else {
              regs[rega] -= regs[regb];
            }
          }
        } else {
          if (b5) {
            if (b4) {
              regs[rega] &= regs[regb];
            } else {
              regs[rega] |= regs[regb];
            }
          } else {
            if (b4) {
              regs[rega] ^= regs[regb];
            } else {
              byte b3 = (rega >> 1) & 1;
              byte b2 = rega & 1;
              rega = regb;
              if (b3) {
                if (b2) {
                  regs[rega] += 1;
                } else {
                  pc = regs[rega];
                  advance_pc = 0;
                }
              } else {
                if (b2) {
                  if (cmp) {
                    pc = regs[rega];
                    advance_pc = 0;
                  }
                } else {
                  // Do nothing
                }
              }
            }
          }
        }
      }
    }

    if (advance_pc) {
      pc += 1;
    }
  }

  void run() {
    while (pc < instructions.size()) {
      step();
    }
  }

  void print_reg(byte i) {
    printf("reg[%d]: ", i);
    print_binary(regs[i]);
    printf("\n");
  }

  void print_regs() {
    for (int i = 0; i < 4; i++) {
      print_reg(i);
    }
  }

private:
  int pc;
  bool cmp;
  byte regs[4];
  const std::vector<Instr> &instructions;
  byte *memory;
};