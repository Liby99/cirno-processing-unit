#ifndef LOADER_CPP
#define LOADER_CPP

#include "cpu.cpp"
#include <iostream>
#include <fstream>

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

byte parse_byte(const std::string &line) {
  if (line.length() == 0) {
    return 0;
  } else if (line.length() != 8) {
    std::cout << "Invalid byte format " << line << std::endl;
  }
  byte i = 0;
  byte b = line[i++] == '1';
  while (i < 8) {
    b <<= 1;
    b |= line[i++] == '1';
  }
  return b;
}

void load_memory(const std::string &file, byte memory[256]) {
  int i = 0;
  std::string line;
  std::ifstream hexFile(file);
  if (hexFile.is_open()) {
    while (getline(hexFile, line) && i < 256) {
      memory[i] = parse_byte(line);
      i++;
    }
    hexFile.close();
  } else {
    std::cout << "Unable to open file " << file << std::endl;
    exit(1);
  }
}

#endif