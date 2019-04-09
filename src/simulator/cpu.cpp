#ifndef CPU_CPP
#define CPU_CPP

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

  int pc;

  bool cmp;

  byte regs[4];

  const std::vector<Instr> &instructions;

  byte *memory;

  CPU(const std::vector<Instr> &instructions, byte *memory)
    : pc(0), cmp(0), instructions(instructions), memory(memory) {
    for (int i = 0; i < 4; i++) {
      regs[i] = 0;
    }
  }

  void step() {
    bool advance_pc = true;

    Instr ins;
    if (pc >= instructions.size()) {
      ins = 0; // Nil Operator
      advance_pc = false;
    } else {
      ins = instructions[pc];
    }

    byte b876 = (ins >> 6) & 7;
    byte b54 = (ins >> 4) & 3;
    byte b5 = (ins >> 5) & 1;
    byte rega = (ins >> 2) & 3;
    byte regb = ins & 3;
    switch (b876) {
      case 0b111: { // 111, jmpi
        byte imm = ins & 31;
        if (b5) {
          pc -= imm;
        } else {
          pc += imm;
        }
        advance_pc = false;
      } break;
      case 0b110: { // 110, andi
        byte reg = (ins >> 4) & 3;
        byte imm = ins & 15;
        regs[reg] &= imm;
      } break;
      case 0b101: { // 101, movih
        byte reg = (ins >> 4) & 3;
        byte imm = ins & 15;
        regs[reg] |= imm << 4;
      } break;
      case 0b100: { // 100, movil
        byte reg = (ins >> 4) & 3;
        byte imm = ins & 15;
        regs[reg] |= imm;
      } break;
      case 0b011: { // 011
        byte reg = (ins >> 3) & 3;
        byte shamt = ins & 7;
        if (b5) { // 0111, shri
          regs[reg] >>= shamt;
        } else { // 0110, shli
          regs[reg] <<= shamt;
        }
      } break;
      case 0b010: { // 010
        switch (b54) {
          case 0b11: { // 01011, bri
            if (cmp) {
              byte b3 = (ins >> 3) & 1;
              byte imm = ins & 7;
              pc = b3 ? pc - imm : pc + imm;
              advance_pc = false;
            }
          } break;
          case 0b10: { // 01010, sh
            byte b = regs[regb];
            byte shamt = b & 7;
            byte sign = (b >> 3) & 1;
            if (sign) {
              regs[rega] <<= shamt;
            } else {
              regs[rega] >>= shamt;
            }
          } break;
          case 0b01: { // 01001, sb
            memory[regb] = regs[rega];
          } break;
          case 0b00: { // 01000, lb
            regs[rega] = memory[regb];
          } break;
        }
      } break;
      case 0b001: { // 001
        switch (b54) {
          case 0b11: { // 00011, mov
            regs[rega] = regs[regb];
          } break;
          case 0b10: { // 00010, cmp
            cmp = regs[rega] == regs[regb];
          } break;
          case 0b01: { // 00001, add
            regs[rega] += regs[regb];
          } break;
          case 0b00: { // 00000, sub
            regs[rega] -= regs[regb];
          } break;
        }
      } break;
      case 0b000: { // 000
        switch (b54) {
          case 0b11: { // 00011, and
            regs[rega] &= regs[regb];
          } break;
          case 0b10: { // 00010, or
            regs[rega] |= regs[regb];
          } break;
          case 0b01: { // 00001, xor
            regs[rega] ^= regs[regb];
          } break;
          case 0b00: { // 00000
            byte b32 = rega;
            rega = regb;
            switch (b32) {
              case 0b11: { // 0000011, incr
                regs[rega] += 1;
              } break;
              case 0b10: { // 0000010, jmpr
                pc = regs[rega];
                advance_pc = false;
              } break;
              case 0b01: { // 0000001, br
                if (cmp) {
                  pc = regs[rega];
                  advance_pc = false;
                }
              } break;
              case 0b00: { // 0000000xx, nil
                // Do nothing
              } break;
            }
          } break;
        }
      } break;
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

  void print_curr_state() {
    printf("pc: %d\n", pc);
    printf("cmp: %d\n", cmp);
    print_regs();
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

  void print_memory() {
    printf("memory:");
    for (int i = 0; i < 256; i++) {
      printf("%d ", i);
      print_binary(memory[i]);
      printf("\n");
    }
  }
};

#endif