DOCKER_RUN=docker run --rm -it -v${PWD}:${PWD} -w${PWD}

all: centos-crosscompile ubuntu-crosscompile centos

centos-crosscompile: Dockerfile.centos-crosscompile
	mkdir -p bin/centos-crosscompile
	docker build -t qemu-bug:centos-crosscompile -f Dockerfile.centos-crosscompile .
	$(DOCKER_RUN) qemu-bug:centos-crosscompile bash -c 'cp /helloworld* bin/centos-crosscompile'

centos: Dockerfile.centos-crosscompile
	mkdir -p bin/centos
	docker build -t qemu-bug:centos -f Dockerfile.centos .
	$(DOCKER_RUN) qemu-bug:centos bash -c 'cp /helloworld* bin/centos/'

ubuntu-crosscompile: Dockerfile.ubuntu-crosscompile
	mkdir -p bin/ubuntu-crosscompile
	docker build -t qemu-bug:crosscompile -f Dockerfile.ubuntu-crosscompile .
	$(DOCKER_RUN) qemu-bug:crosscompile bash -c 'cp /helloworld* bin/ubuntu-crosscompile/'

clean:
	rm -rf bin
