#include "loader.cpp"
#include "cpu.cpp"
#include <string>

int main(int argc, char *argv[]) {

  // Initialize instructions and memory
  std::vector<Instr> instructions;
  byte memory[256];

  // Load the data into the instructions
  if (argc < 2) {
    std::cout << "Please specify the instruction file" << std::endl;
    exit(1);
  }
  load_instructions(argv[1], instructions);

  // Load the memory if the third argument presented
  if (argc > 2) {
    load_memory(argv[2], memory);
  }

  // Create the CPU
  CPU cpu(instructions, memory);

  // Run the CPU until Halt
  cpu.run();

  // Print the result
  cpu.print_curr_state();
  cpu.print_memory();
}