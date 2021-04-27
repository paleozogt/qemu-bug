# QEMU PPC Bug demonstration

For certain ppc binaries qemu-user will crash.  This project demonstrates how to build the binaries.

## To cross-compile the ppc binary:
```
$ make centos-crosscompile
$ qemu-ppc-static bin/centos-crosscompile/helloworld.static.ppc
qemu: uncaught target signal 4 (Illegal instruction) - core dumped
[1]    17854 illegal hardware instruction (core dumped)  qemu-ppc-static bin/centos-crosscompile/helloworld.static.ppc
```

## To compile the ppc binary directly (using qemu to run the container):
```
$ docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
$ make centos
$ qemu-ppc-static bin/centos/helloworld.static.ppc
qemu: uncaught target signal 4 (Illegal instruction) - core dumped
[1]    24268 illegal hardware instruction (core dumped)  qemu-ppc-static bin/centos/helloworld.static.ppc
```

## To cross-compile the ppc binary on another platform where it doesn't crash:
```
$ make ubuntu-crosscompile
$ qemu-ppc-static bin/ubuntu-crosscompile/helloworld.static.ppc
```
