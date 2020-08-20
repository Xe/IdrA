#include <stdio.h>
#include <stdlib.h>
#include <sys/reboot.h>
#include <unistd.h>

/* Halt the system. */
#define WHY 0x01234567

void do_reboot() {
  printf("farewell, cruel world\n");
  int res = reboot(WHY);
  if (res != 0) {
    perror("reboot() failed, what");
    abort();
  }
}
