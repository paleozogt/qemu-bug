// adapted from https://www.linuxjournal.com/article/5211
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

int child_func() {
   sleep(1);
   printf("child\n");
   _exit(0);
}

int main(int argc, char *argv[]) {
   signal(SIGCHLD, sig_handler);

   void **child_stack = (void **) malloc(16384);
   int pid = clone(child_func, child_stack, CLONE_VM|CLONE_FILES, NULL);

   printf("pid= %d\n", pid);
   if (pid != 0) {
      printf("parent\n");
      sleep(2);
   }

   return 0;
}
