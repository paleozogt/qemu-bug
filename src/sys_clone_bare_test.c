#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sched.h>
#include <sys/syscall.h>
#include <sys/wait.h>

void sig_handler(int signum) {
   printf("%s: got %d\n", __FUNCTION__, signum);
   wait(NULL);
}

int main(int argc, char *argv[]) {
   signal(SIGCHLD, sig_handler);

   int pid = syscall(SYS_clone, 0x0, 0x0, NULL, NULL);

   printf("pid= %d\n", pid);
   if (pid == 0) {
      printf("child\n");
   } else {
      printf("parent\n");
      sleep(1);
   }

   return 0;
}
