#include <stdlib.h>
#include <stdio.h>

const long MEM_SIZE = 256;

void print_binary(char x) {
  int l = sizeof(x) * 8;
  for (int i = l - 1 ; i >= 0; i--) {
    printf("%x", (x & (1 << i)) >> i);
  }
}

void print_mem(char *mem, char i) {
  printf("mem[%d] = ", i);
  print_binary(mem[i]);
  printf("\n");
}

void setup(char* mem) {
  printf("Setting up...\n");

  // The first one is the write up example
  // should be decoded to 0b 0000 0101 0101 0101
  mem[0] = 0b00101101;
  mem[1] = 0b01010101;
  print_mem(mem, 0);
  print_mem(mem, 1);

  // The second one is the corrupted write up example
  // The differed bit is at position 6
  // Should still be decoded to 0b 0000 0101 0101 0101 (the same as the first one)
  // because of the correction method
  mem[2] = 0b00001101;
  mem[3] = 0b01010101;
  print_mem(mem, 2);
  print_mem(mem, 3);
}

void prog2(char* mem) {
  char i = 0, j = 0, k = 0, t = 0, p = 0;
  char parity = 0, lower = 0, upper = 0;

  // Index i
  i = 0;
  while (i < 3) {
    k = i; // Store current k

    // Load lower and upper
    lower = mem[i];
    i++; // This is just an increment
    upper = mem[i];
    i++;

    // Initiate 0 parity
    parity = 0;

    // First deal with p8
    p = lower >> 7;
    t = upper;
    j = 0;
    while (j < 7) {
      p = p ^ t;
      t = t >> 1;
      j++;
    }
    p = p & 1;
    parity = parity | p;
    parity = parity << 1;

    // Then deal with p4
    p = lower >> 3;
    t = (upper & 248) | ((lower >> 4) & 7);
    j = 0;
    while (j < 7) {
      p = p ^ t;
      t = t >> 1;
      j++;
    }
    p = p & 1;
    parity = parity | p;
    parity = parity << 1;

    // Then deal with p2
    p = lower >> 1;
    t = p >> 1;
    p = p ^ t;
    t = t >> 3;
    p = p ^ t;
    t = t >> 1;
    p = p ^ t;
    t = upper >> 1;
    p = p ^ t;
    t = t >> 1;
    p = p ^ t;
    t = t >> 3;
    p = p ^ t;
    t = t >> 1;
    p = p ^ t;
    p = p & 1;
    parity = parity | p;
    parity = parity << 1;

    // Finally deal with p1
    j = 0;
    p = lower;
    t = lower >> 2;
    while (j < 3) {
      p = p ^ t;
      t = t >> 2;
      j++;
    }
    t = upper;
    j = 0;
    while (j < 4) {
      p = p ^ t;
      t = t >> 2;
      j++;
    }
    p = p & 1;
    parity = parity | p;

    // Correct parity
    if (parity > 7) {
      t = 1 << (parity - 8);
      upper = t ^ upper;
    }
    if (parity > 0) {
      t = 1 << (parity - 1);
      lower = t ^ lower;
    }

    // Write back to mem
    mem[k] = (upper << 4) | ((lower >> 2) & 1) | ((lower >> 3) & 14);
    k++;
    mem[k] = upper >> 4;
  }
}

void test(char* mem) {
  printf("Testing\n");
  print_mem(mem, 0);
  print_mem(mem, 1);
  print_mem(mem, 2);
  print_mem(mem, 3);
}

int main() {
  char mem[256];
  setup(mem);
  prog2(mem);
  test(mem);
}