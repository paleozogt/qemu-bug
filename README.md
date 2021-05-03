# QEMU Clone Bug demonstration

Qemu doesn't seem to support the [clone syscall](https://linux.die.net/man/2/clone) with certain parameters.

To cross-compile:

```
$ make docker TRIPLET=aarch64-linux-gnu
...
$ ls bin/aarch64-linux-gnu
fork_test  sys_clone_bare_test  sys_clone_fork_test
```

To build native:
```
$ make
...
$ ls bin/x86_64-linux-gnu
fork_test  sys_clone_bare_test  sys_clone_fork_test
```

To demonstrate the bug:
```
$ qemu-aarch64-static bin/aarch64-linux-gnu/fork_test
pid= 30181
parent
pid= 0
child
sig_handler: got 17

$ qemu-aarch64-static bin/aarch64-linux-gnu/sys_clone_fork_test
pid= 30310
parent
pid= 0
child
sig_handler: got 17

$ qemu-aarch64-static bin/aarch64-linux-gnu/sys_clone_bare_test
pid= -1
parent

$ qemu-aarch64-static bin/aarch64-linux-gnu/sys_clone_example_test
pid= -1
parent
```

When running natively (without qemu) this looks like:
```
$ ./bin/x86_64-linux-gnu/fork_test
pid= 626
parent
pid= 0
child
sig_handler: got 17

$ ./bin/x86_64-linux-gnu/sys_clone_fork_test
pid= 732
pid= 0
child
parent
sig_handler: got 17
parent

$ ./bin/x86_64-linux-gnu/sys_clone_bare_test
pid= 878
parent
pid= 0
child

$ ./bin/x86_64-linux-gnu/sys_clone_example_test
pid= 15117
parent
child
```