#include <stdlib.h>
#include <stdio.h>

typedef unsigned char byte;

typedef unsigned char bool;

typedef unsigned short instr;

typedef struct CPU {
  int pc;
  bool cmp;
  int num_instrs;
  byte regs[4];
  instr* instructions;
  byte* memory;
} CPU;

void print_binary(byte x) {
  int l = sizeof(x) * 8;
  for (int i = l - 1 ; i >= 0; i--) {
    printf("%x", (x & (1 << i)) >> i);
  }
}

CPU* init_cpu(instr* instructions, byte* memory, int num_instrs) {
  CPU* cpu = (CPU *) calloc(0, sizeof(CPU));
  cpu->pc = 0;
  cpu->cmp = 0;
  cpu->num_instrs = num_instrs;
  byte i = 0;
  while (i < 4) {
    cpu->regs[i] = 0;
    i++;
  }
  cpu->instructions = instructions;
  cpu->memory = memory;
  return cpu;
}

void step(CPU* cpu) {
  instr ins;
  if (cpu->pc >= cpu->num_instrs) {
    ins = 0;
  } else {
    ins = cpu->instructions[cpu->pc];
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
          cpu->pc -= imm;
        } else {
          cpu->pc += imm;
        }
        advance_pc = 0;
      } else {
        cpu->regs[reg] &= imm;
      }
    } else {
      if (b6) {
        cpu->regs[reg] |= imm << 4;
      } else {
        cpu->regs[reg] |= imm;
      }
    }
  } else {
    if (b7) {
      if (b6) {
        byte reg = (ins >> 3) & 3;
        byte shamt = ins & 7;
        if (b5) {
          cpu->regs[reg] >>= shamt;
        } else {
          cpu->regs[reg] <<= shamt;
        }
      } else {
        byte b4 = (ins >> 4) & 1;
        byte rega = (ins >> 2) & 3;
        byte regb = ins & 3;
        if (b5) {
          if (b4) {
            cpu->memory[regb] = cpu->regs[rega];
          } else {
            cpu->regs[rega] = cpu->memory[regb];
          }
        } else {
          if (b4) {
            cpu->regs[rega] >>= cpu->regs[regb];
          } else {
            cpu->regs[rega] <<= cpu->regs[regb];
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
            cpu->regs[rega] = cpu->regs[regb];
          } else {
            cpu->cmp = cpu->regs[rega] == cpu->regs[regb];
          }
        } else {
          if (b4) {
            cpu->regs[rega] += cpu->regs[regb];
          } else {
            cpu->regs[rega] -= cpu->regs[regb];
          }
        }
      } else {
        if (b5) {
          if (b4) {
            cpu->regs[rega] &= cpu->regs[regb];
          } else {
            cpu->regs[rega] |= cpu->regs[regb];
          }
        } else {
          if (b4) {
            cpu->regs[rega] ^= cpu->regs[regb];
          } else {
            byte b3 = (rega >> 1) & 1;
            byte b2 = rega & 1;
            rega = regb;
            if (b3) {
              if (b2) {
                cpu->regs[rega] += 1;
              } else {
                cpu->pc = cpu->regs[rega];
                advance_pc = 0;
              }
            } else {
              if (b2) {
                if (cpu->cmp) {
                  cpu->pc = cpu->regs[rega];
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
    cpu->pc += 1;
  }
}

void run(CPU* cpu) {
  while (cpu->pc < cpu->num_instrs) {
    step(cpu);
  }
}

void print_reg(CPU* cpu, byte i) {
  printf("reg[%d]: ", i);
  print_binary(cpu->regs[i]);
  printf("\n");
}

void print_regs(CPU* cpu) {
  int i = 0;
  while (i < 4) {
    print_reg(cpu, i);
    i++;
  }
}

void free_cpu(CPU* cpu) {
  free(cpu);
}