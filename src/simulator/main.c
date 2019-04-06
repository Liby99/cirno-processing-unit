#include "cpu.c"

int main() {
  instr instructions[2] = {
    0b0000000101000101,
    0b0000000100000101
  };

  byte memory[256];

  CPU* cpu = init_cpu(instructions, memory);

  printf("Stepping once...\n");
  step(cpu);
  print_regs(cpu);
  printf("Stepping twice...\n");
  step(cpu);
  print_regs(cpu);
  printf("Terminating...\n");

  free_cpu(cpu);
}