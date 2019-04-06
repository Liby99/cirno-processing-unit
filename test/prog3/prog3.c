#include <stdio.h>
#include <stdlib.h>
const int MEM_SIZE = 256;


void setup(char* mem) {
  for (int i = 128; i <= 191; i++) {
    mem[i] = 0b11111110;
  }
  mem[192] = 0b11010000;
}

/*
 * Algorithm: Iterate through mem[128] to mem[190]. In each iteration, have two 
 *            vars (char1 and char2) to store mem[i] and mem[i+1]. Then xor
 *            pattern with char1, where the result is abcdxxxx, where if abcd
 *            are all zeros indicate that there is a pattern match. Then left
 *            shift char1 by 1 place, and pad the last bit of char1 by first
 *            bit of char2, and also left shift char2 by 1 place. This is
 *            effectively shifting the whole memory to left 1 bit at a time.
 *            In each iteration of outer loop, shift char1 8 times to complete
 *            check within char1, and if a match is found in the first 4 shift,
 *            this means that the pattern is matched within the pattern, then 
 *            have a boolean to indicate this. At the end of 8 shifts, if the
 *            boolean is true, increament accumulator of number of bytes.
 * 
 *            The last byte has to be chcked separately because it has no
 *            neighbor to the right.
 * 
 * Instructions used:
 *     Move High    reg  4bits
 *     Move Low     eg   4bits
 *     Load         reg1 reg2
 *     Store        reg1 reg2
 *     Clear        reg1
 *     Branch if 0  reg1
 *     Increment    reg1
 *     Shift        reg1 4bits
 *     Xor          reg1 reg2
 *     And          reg1 reg2
 *     Or           reg1 reg2
 *   
 */
void prog3(char* mem) {
  unsigned char pattern = mem[192]; // TODO check which 4 bits are the pattern
  unsigned char acc1 = 0, acc2 = 0; // acc1 is number of times pattern occure
                                    // acc2 is numebr of bytes pattern occure within
  unsigned char char1, char2;
  unsigned char i = 0b11000001; // The outer while loop runs 63 times, check last byte separately
  unsigned char pos = 128;
  unsigned char temp; // used to store intermediate value
  unsigned char inByte = 0; // boolean flag to indicate whether the pattern occurs in the byte
  unsigned char j; // inner loop counter

  while (i != 0) {
    i++;
    j = 0b11111000;
    //char1 = mem[pos]; // Optimization, char1 has been set of value of last char2
    pos++;
    char2 = mem[pos];

    while (j != 0) { // j is a loop counter that logically loops between 0:7
      temp = char1 ^ pattern;
      temp &= 0b11110000;
      if (temp == 0) {
        acc1++;
        if((j & 0b00000100) == 0) { // Essentailly checking that j is < 4
          inByte = 1;
        }
      }
      char1 = char1 << 1;
      temp = char2 >> 7;
      char1 |= temp;
      char2 = char2 << 1;
      j++;
    }

    if (inByte) {
      acc2++;
    }
  }

  /*-------------- Check last byte --------------*/
  inByte = 0;
  j = 0b11111100;
  while (j != 0) {
    temp = char1 ^ pattern;
    temp &= 0b11110000;
    if (temp == 0) {
      acc1++;
      inByte = 1;
    }
    char1 = char1 << 1;
    j++;
  }
  if (inByte) {
    acc2++;
  }
  /*-------------- Check last byte --------------*/

  mem[193] = acc2;
  mem[194] = acc1;
}

void test(char* mem) {
  printf("%d\n", mem[193]);
  printf("%d\n", mem[194]);
}


int main() {
  char * mem = malloc(sizeof(char) * MEM_SIZE);
  setup(mem);
  prog3(mem);
  test(mem);
}