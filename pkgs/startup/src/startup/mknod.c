#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <sys/types.h>
#include <unistd.h>

#include <startup/mknod.h>

int do_mknodes() {
  dev_t dev;
  dev = makedev(1, 7);
  return mknod("/dev/urandom", 644, dev);
}
