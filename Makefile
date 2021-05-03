TRIPLET=$(shell gcc -dumpmachine)
CC=$(TRIPLET)-gcc
CFLAGS=--static
LDFLAGS=

all: bin/$(TRIPLET)/sys_clone_bare_test bin/$(TRIPLET)/sys_clone_fork_test bin/$(TRIPLET)/sys_clone_example_test bin/$(TRIPLET)/fork_test

bin/$(TRIPLET)/%: src/%.c
	mkdir -p bin/$(TRIPLET)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

docker: Dockerfile.ubuntu-crosscompile
	docker build --build-arg TRIPLET=$(TRIPLET) -t qemu-bug:$(TRIPLET) -f $^ .
	docker run --rm -u$(shell id -u):$(shell id -g) -v$(PWD):$(PWD) -w$(PWD) qemu-bug:$(TRIPLET) \
		make TRIPLET=$(TRIPLET)

clean:
	rm -rf bin/*
