#include <stdlib.h>
#include <stdio.h>

typedef unsigned char byte;

const long MEM_SIZE = 256;

void print_binary(byte x) {
  int l = sizeof(x) * 8;
  for (int i = l - 1 ; i >= 0; i--) {
    printf("%x", (x & (1 << i)) >> i);
  }
}

void print_mem(byte *mem, byte i) {
  printf("mem[%d] = ", i);
  print_binary(mem[i]);
  printf("\n");
}

void setup_case(byte* mem, byte pos, byte low, byte high) {
  mem[pos] = low;
  mem[pos + 1] = high;
  print_mem(mem, pos);
  print_mem(mem, pos + 1);
}

void setup(byte* mem) {
  printf("Setting up...\n");

  // The first one is the write-up example. This is a correct one without any flipped bit when transmitting
  // should be decoded to 0b 0000 0101 0101 0101
  setup_case(mem, 64, 0b00101101, 0b01010101);

  // The second one is the corrupted write up example
  // The differed bit is at position 6 (lower part)
  // Should still be decoded to 0b 0000 0101 0101 0101 (the same as the first one)
  // because of the correction method
  setup_case(mem, 66, 0b00001101, 0b01010101);

  // The third one is the corrupted write up example
  // The differed bit is at position 10 (upper part)
  // Should still be decoded to 0b 0000 0101 0101 0101 (the same as the first one)
  // because of the correction method
  setup_case(mem, 68, 0b00101101, 0b01010111);

  // The forth one is corrupting the same example
  // The differed bit is at position 8, which is a parity bit position
  // Should still be decoded to 0b 0000 0101 0101 0101 (the same as the first one)
  setup_case(mem, 70, 0b10101101, 0b01010101);
}

void prog2(byte* mem) {
  byte i = 64, j = 0, k = 94, t = 0, p = 0;
  byte parity = 0, lower = 0, upper = 0;

  while (i < 94) {

    // Load lower and upper
    lower = mem[i];
    i++; // This is just an increment
    upper = mem[i];
    i++;

    // Initiate 0 parity
    parity = 0;

    // First deal with p8
    t = upper;
    p = lower >> 7;
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
    t = upper;
    t = t & 248;
    p = lower;
    p = p >> 4;
    p = p & 7;
    t = t | p; // t = (upper & 248) | ((lower >> 4) & 7);
    p = lower >> 3;
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
    t = p;
    t = t >> 2; // t = lower >> 2
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
    t = 1;
    if (parity > 8) {
      p = parity - 9;
      t = t << p; // t = 1 << (parity - 9)
      upper = t ^ upper;
    }
    if (parity > 0) {
      p = parity - 1;
      t = t << p; // t = 1 << (parity - 1)
      lower = t ^ lower;
    }

    // Write back to mem
    t = upper;
    t = t << 4;
    p = lower;
    p = p >> 2;
    p = p & 1;
    t = t | p;
    p = lower;
    p = p >> 3;
    p = p & 14;
    t = t | p; // t = (upper << 4) | ((lower >> 2) & 1) | ((lower >> 3) & 14);
    mem[k] = t;

    k++;
    t = upper;
    t = t >> 4; // t = upper >> 4;
    mem[k] = t;
    k++;
  }
}

void test(byte* mem) {
  printf("Testing\n");
  print_mem(mem, 94);
  print_mem(mem, 95);
  print_mem(mem, 96);
  print_mem(mem, 97);
  print_mem(mem, 98);
  print_mem(mem, 99);
  print_mem(mem, 100);
  print_mem(mem, 101);
}

int main() {
  byte mem[256];
  setup(mem);
  prog2(mem);
  test(mem);
}