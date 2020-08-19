#include <stdio.h>
#include <stdlib.h>
#include <sys/reboot.h>
#include <unistd.h>

/* Halt the system. */
#define WHY 0xcdef0123

void do_reboot() {
  int res = reboot(WHY);
  if (res != 0) {
    perror("reboot() failed, what");
    abort();
  }
}
