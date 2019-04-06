#include "cpu.cpp"
#include <iostream>
#include <fstream>
#include <string>

Instr parse_instruction(const std::string &line) {
  if (line.length() == 0) {
    return 0;
  } else if (line.length() != 9) {
    std::cout << "Invalid instruction format " << line << std::endl;
  }
  byte i = 0;
  Instr ins = line[i++] == '1';
  while (i < 9) {
    ins <<= 1;
    ins |= line[i++] == '1';
  }
  return ins;
}

void load_instructions(const std::string &file, std::vector<Instr> &instructions) {
  std::string line;
  std::ifstream hexFile(file);
  if (hexFile.is_open()) {
    while (getline(hexFile, line)) {
      instructions.push_back(parse_instruction(line));
    }
    hexFile.close();
  } else {
    std::cout << "Unable to open file " << file << std::endl;
    exit(1);
  }
}

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

  // Create the CPU
  CPU cpu(instructions, memory);

  // Run the CPU until Halt
  cpu.run();

  // Print the result
  cpu.print_regs();
}