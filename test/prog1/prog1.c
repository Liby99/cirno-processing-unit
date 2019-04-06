#include <stdlib.h>
#include <stdio.h>

const long MEM_SIZE = 256;

void setup(char* mem) {
  // Setup
}

void prog1(char* mem) {
  char i = 0, j = 0, k = 0, t = 0, p = 0;
  char p8 = 0, p4 = 0, p2 = 0, p1 = 0, lower = 0, upper = 0;
  char b4to2 = 0, b1 = 0;
  char temp_lower = 0, temp_upper = 0;
  // loop first 29 bytes to read data
  while (i < 30) {
    lower = mem[i];
    i++;
    upper = mem[i];
    i++;

    temp_upper = (upper << 4) | (lower >> 4)

    // find p8
    p8 = 0;
    p = temp_upper;
    t = temp_upper >> 1;
    while (j < 7) {
      p = p ^ t;
      t = t >> 1;
      j++;
    }
    p8 = (p << 7) & 128;

    // find p4
    p4 = 0;
    p = (temp_upper & 248) | ((lower >> 1) & 7);
    t = p >> 1;
    j = 0;
    while (j < 7) {
      p = p ^ t;
      t = t >> 1;
      j++;
    }
    p4 = (p << 3) & 8;

    // find p2
    p2 = 0;
    p = temp_upper >> 1;
    t = p >> 1;
    p = p ^ t;
    t = t >> 2;
    p = p ^ t;
    t = t >> 1;
    p = p ^ t;
    t = lower;
    p = p ^ t;
    t = t >> 2;
    p = p ^ t;
    t = t >> 1;
    p = p ^ t;
    p2 = (p << 1) & 2;

    // find p1
    p = temp_upper;
    t = p >> 2;
    j = 0;
    while (j < 3) {
      p = p ^ t;
      t = t >> 2;
      j++;
    }
    t = lower;
    p = p ^ t;
    t = t >> 1;
    p = p ^ t;
    t = t >> 2;
    p = p ^ t;
    p1 = p & 1;
    b4to2 = (lower << 3) & 112;
    b1 = (lower << 2) & 4;

    temp_lower = p8 | b4to2 | p4 | b1 | p2 | p1;

    mem[i+28] = temp_lower;
    mem[i+29] = temp_upper;
  }
}

void test(char* mem) {
  // What i need to test
}

int main() {
  char mem[MEM_SIZE];
  setup(mem);
  prog1(mem);
  test(mem);
}
