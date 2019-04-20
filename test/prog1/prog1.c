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
  mem[pos+1] = high;
  print_mem(mem, pos);
  print_mem(mem, pos+1);
}

void setup(byte* mem) {
  // setup_case(mem, 0, 0b01010101, 0b00000101);
  // setup_case(mem, 2, 0b10110101, 0b00000110);
  setup_case(mem, 0, 0b10000001, 0b00000110);
}

void prog1(byte* mem) {
  byte i = 0, j = 0, k = 30, t = 0, p = 0;
  byte p8 = 0, p4 = 0, p2 = 0, p1 = 0, lower = 0, upper = 0;
  byte b4to2 = 0, b1 = 0;
  byte temp_lower = 0, temp_upper = 0;

  while (i < 30) {
    lower = mem[i];
    i++;
    upper = mem[i];
    i++;

    temp_upper = (upper << 4) | (lower >> 4);

    // find p8
    // p8 = 0;
    p = temp_upper;
    t = temp_upper >> 1;
    while (j < 7) {
      p = p ^ t;
      t = t >> 1;
      j++;
    }
    p8 = p << 7;

    // find p4
    // p4 = 0;
    p = (temp_upper & 248) | ((lower >> 1) & 7);
    t = p >> 1;
    j = 0;
    while (j < 7) {
      p = p ^ t;
      t = t >> 1;
      j++;
    }
    p4 = p << 3;

    // find p2
    // p2 = 0;
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

    mem[k] = temp_lower;
    k++;
    mem[k] = temp_upper;
    k++;
  }
}

void test(byte* mem) {
  printf("Testing...\n");
  print_mem(mem, 30); // 0110 1000 1000 1110
  print_mem(mem, 31);
  // print_mem(mem, 32);
  // print_mem(mem, 33);
}

int main() {
  byte mem[MEM_SIZE];
  setup(mem);
  prog1(mem);
  test(mem);
}
