#include "cpu.c"

int main() {
  instr instructions[4] = {
    0b101000101,
    0b100000101,
    0b100010011,
    0b001010001
  };

  byte memory[256];

  CPU* cpu = init_cpu(instructions, memory, 4);

  // printf("Stepping once...\n");
  // step(cpu);
  // print_regs(cpu);
  // printf("Stepping twice...\n");
  // step(cpu);
  // print_regs(cpu);
  // printf("Terminating...\n");

  run(cpu);
  print_regs(cpu);

  free_cpu(cpu);
}