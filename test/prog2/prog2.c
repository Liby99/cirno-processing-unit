#include <stdlib.h>

const long MEM_SIZE = 256;

void setup(char* mem) {
  // Setup
}

void prog2(char* mem) {
  // What i need to write
}

void test(char* mem) {
  // What i need to test
}

int main() {
  char * mem = (char *) calloc(0, sizeof(char) * MEM_SIZE);
  setup(mem);
  prog2(mem);
  test(mem);
}