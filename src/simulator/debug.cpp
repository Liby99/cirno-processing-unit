#include "loader.cpp"
#include "cpu.cpp"
#include <string>
#include <sstream>

void clean_memory(byte mem[256]) {
  for (int i = 0; i < 256; i++) {
    mem[i] = 0;
  }
}

void print_prompt() {
  printf("(cdb) > ");
}

void print_unknown_command(const std::string &user_input) {
  printf("Unknown command \"%s\"\n", user_input.c_str());
}

void print_entry(const std::string &filename) {
  printf("Debugging program %s. Type `help` if you want more commands.\n", filename.c_str());
}

void print_help() {
  printf("These options are available for you...\n");
  printf("  help\n");
  printf("  step\n");
  printf("  run\n");
  printf("  list [breakpoint]\n");
  printf("  break line_num\n");
  printf("  remove [breakpoint [id]]\n");
  printf("  print [pc | reg | cmp | mem | mem [loc] | mem [start] [end]]\n");
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

void print_mem_at(CPU &cpu, int index) {
  printf("mem[%d]: ", index);
  print_binary(cpu.memory[index]);
  printf("\n");
}

bool should_stop(CPU &cpu, std::vector<int> &breakpoints) {
  if (cpu.pc >= cpu.instructions.size()) {
    return true;
  } else {
    for (int i = 0; i < breakpoints.size(); i++) {
      int bp = breakpoints[i];
      if (cpu.pc == bp) {
        return true;
      }
    }
    return false;
  }
}

void run_cpu(CPU &cpu, std::vector<int> &breakpoints) {
  cpu.step();
  while (!should_stop(cpu, breakpoints)) {
    cpu.step();
  }
}

void exec_user_input(const std::string &user_input, std::vector<int> &breakpoints, CPU &cpu) {
  std::vector<std::string> trimmed = split(user_input, ' ');
  if (trimmed.size() > 0) {
    if (trimmed[0] == "help") {
      print_help();
    } else if (trimmed[0] == "step") {
      cpu.step();
    } else if (trimmed[0] == "run") {
      run_cpu(cpu, breakpoints);
      if (cpu.pc >= cpu.instructions.size()) {
        printf("The program finished running\n");
      } else {
        printf("The program hit a breakpoint at %d\n", cpu.pc);
      }
    } else if (trimmed[0] == "break") {
      if (trimmed.size() > 1) {
        try {
          int index = std::stoi(trimmed[1]);
          if (index >= 0 && index < cpu.instructions.size()) {
            breakpoints.push_back(index);
            printf("Added breakpoint #%lu at line %d\n", breakpoints.size(), index);
          } else {
            printf("index has to be >= 0 and < 256\n");
          }
        } catch (...) {
          printf("Cannot parse index %s\n", trimmed[1].c_str());
        }
      } else {
        printf("Please specify the line number you want to set breakpoint.");
        printf("Usage: break [line_num]\n");
      }
    } else if (trimmed[0] == "remove") {
      if (trimmed.size() > 1) {
        if (trimmed[1] == "breakpoint") {
          if (trimmed.size() > 2) {
            try {
              int index = std::stoi(trimmed[2]);
              if (index > 0 && index <= breakpoints.size()) {
                int actual = index - 1;
                breakpoints.erase(breakpoints.begin() + actual);
              } else {
                printf("Non-exist breakpoint #%d\n", index);
              }
            } catch (...) {
              printf("Unknown argument %s\n", trimmed[2].c_str());
              printf("Please input the breakpoint id\n");
            }
          } else {
            breakpoints.clear();
          }
        } else {
          printf("Unknown object %s\n", trimmed[1].c_str());
        }
      } else {
        printf("Please specify what do you want to clear\n");
        printf("Usage: remove [breakpoint]\n");
      }
    } else if (trimmed[0] == "list") {
      if (trimmed.size() > 1) {
        if (trimmed[1] == "breakpoint") {
          printf("Breakpoints:\n");
          for (int i = 0; i < breakpoints.size(); i++) {
            printf("  #%d: line %d\n", i + 1, breakpoints[i]);
          }
        } else {
          printf("Unknown object %s\n", trimmed[1].c_str());
        }
      } else {
        int start = std::max(cpu.pc - 4, 0);
        int end = std::min(cpu.pc + 5, (int) cpu.instructions.size());
        for (int i = start; i < end; i++) {
          Instr instr = cpu.instructions[i];
          printf("%s %d: %d", i == cpu.pc ? "->" : "  ", i, (instr >> 8) & 1);
          print_binary((byte) instr);
          printf("\n");
        }
      }
    } else if (trimmed[0] == "print") {
      if (trimmed.size() > 1) {
        if (trimmed[1] == "pc") {
          printf("pc: %d\n", cpu.pc);
        } else if (trimmed[1] == "reg") {
          cpu.print_regs();
        } else if (trimmed[1] == "cmp") {
          printf("cmp: %d\n", cpu.cmp);
        } else if (trimmed[1] == "mem") {
          if (trimmed.size() > 2) {
            try {
              int index_1 = std::stoi(trimmed[2]);
              if (index_1 >= 0 && index_1 < 256) {
                if (trimmed.size() > 3) {
                  try {
                    int index_2 = std::stoi(trimmed[3]);
                    if (index_2 >= 0 && index_2 < 256) {
                      if (index_1 <= index_2) {
                        for (int i = index_1; i <= index_2; i++) {
                          print_mem_at(cpu, i);
                        }
                      } else {
                        printf("start has to be less than or equal to end\n");
                      }
                    } else {
                      printf("index has to be >= 0 and < 256\n");
                    }
                  } catch (...) {
                    printf("Cannot parse index %s\n", trimmed[3].c_str());
                  }
                } else {
                  print_mem_at(cpu, index_1);
                }
              } else {
                printf("index has to be >= 0 and < 256\n");
              }
            } catch (...) {
              printf("Cannot parse index %s\n", trimmed[2].c_str());
            }
          } else {
            cpu.print_memory();
          }
        }
      } else {
        printf("Please specify the thing you want to print.\n");
        printf("Usage: print [pc|reg|cmp|mem|mem [location]]\n");
      }
    } else {
      print_unknown_command(user_input);
    }
  }
}

int main(int argc, char *argv[]) {

  std::string user_input;
  std::vector<int> breakpoints;

  // Initialize instructions and memory
  std::vector<Instr> instructions;
  byte memory[256];
  clean_memory(memory);

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

  print_entry(argv[1]);
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