#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void stringFromByte(char* buf, char b) {
  for (int i = 0; i < 8; i++) {
    if ((b >> (8 - i - 1)) % 2 == 0) {
      buf[i] = '0';
    } else {
      buf[i] = '1';
    }
  }
}

/*
 * @param mem is a pointer to 256 bytes of memory
 * @filename name of your test file. please keep it the same as your test number.
 *           for example, if your program is prog1 and test number is test 2, the filename
 *           should be "prog1_test2.mem"
 */
void generateMemFile(unsigned char* mem, char* filename) {
  char name[256];
  strcpy(name, "../../src/simulator/memory/");
  strcat(name, filename);
  FILE* file = fopen(name, "w");
  char buf[10];
  buf[8] = '\n';
  buf[9] = 0;
  for (int i = 0; i < 256; i++) {
    stringFromByte(buf, mem[i]);
    fprintf(file, "%s", buf);
  }
  fclose(file);
}