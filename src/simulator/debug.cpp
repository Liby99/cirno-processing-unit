#include "loader.cpp"
#include "cpu.cpp"
#include <string>
#include <sstream>

void print_prompt() {
  printf("(cdb) > ");
}

void print_help() {
  printf("These options are available for you...\n");
  printf("  help\n");
  printf("  step\n");
  printf("  run\n");
  printf("  break [line_num]\n");
  printf("  print pc\n");
  printf("  print regs\n");
  printf("  print mem\n");
  printf("  print mem [position]\n");
}

std::vector<std::string> split(std::string str, char delimiter) {
  std::vector<std::string> internal;
  std::stringstream ss(str); // Turn the string into a stream.
  std::string tok;
  while (getline(ss, tok, delimiter)) {
    if (tok != "") {
      internal.push_back(tok);
    }
  }
  return internal;
}

void exec_user_input(const std::string &user_input, std::vector<int> &breakpoints, CPU &cpu) {
  std::vector<std::string> trimmed = split(user_input, ' ');
  printf("[");
  for (int i = 0; i < trimmed.size(); i++) {
    printf("%s", trimmed[i].c_str());
    if (i < trimmed.size() - 1) {
      printf(", ");
    }
  }
  printf("]\n");
}

int main(int argc, char *argv[]) {

  std::string user_input;
  std::vector<int> breakpoints;

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

  print_help();
  print_prompt();

  // Run the CPU until Halt
  while (true) {
    char c = getchar();
    if (c == '\n') {
      exec_user_input(user_input, breakpoints, cpu);
      user_input = "";
      print_prompt();
    } else {
      user_input += c;
    }
  }
}