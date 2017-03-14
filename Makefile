.SILENT:
.PHONY: help build

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME    = splitsh-lite
PACKAGE_VERSION = 1.0.0
PACKAGE_SOURCE  = github.com/splitsh/lite

## GO
GO_VERSION = 1.7.4
export GOPATH = ${HOME}/go

## Path
export PATH := ${PATH}:/usr/local/go/bin

## Macros
DOCKER = docker run \
    --rm \
    --volume `pwd`:/srv \
    --workdir /srv \
    --tty \
    ${DOCKER_OPTIONS} \
    manala/build-debian:${DEBIAN_DISTRIBUTION} \
    ${DOCKER_COMMAND}

## Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

#######
# Dev #
#######

dev@wheezy: DEBIAN_DISTRIBUTION = wheezy
dev@wheezy: DOCKER_OPTIONS      = --interactive
dev@wheezy: DOCKER_COMMAND      = /bin/bash
dev@wheezy:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

dev@jessie: DEBIAN_DISTRIBUTION = jessie
dev@jessie: DOCKER_OPTIONS      = --interactive
dev@jessie: DOCKER_COMMAND      = /bin/bash
dev@jessie:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

#########
# Build #
#########

## Build
build: build@wheezy build@jessie

build@wheezy: DEBIAN_DISTRIBUTION = wheezy
build@wheezy: DOCKER_COMMAND      = make build-package DEBIAN_DISTRIBUTION=${DEBIAN_DISTRIBUTION}
build@wheezy:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build@jessie: DEBIAN_DISTRIBUTION = jessie
build@jessie: DOCKER_COMMAND      = make build-package DEBIAN_DISTRIBUTION=${DEBIAN_DISTRIBUTION}
build@jessie:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build-package:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"
	apt-get update
	apt-get install -y git cmake pkg-config libssh2-1-dev libssl-dev libcurl4-openssl-dev
	curl -L https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz -o ~/go.tar.gz
	tar -C /usr/local -xzf ~/go.tar.gz

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	go get -d github.com/libgit2/git2go
	cd ${GOPATH}/src/github.com/libgit2/git2go && \
		git checkout next && \
		git submodule update --init && \
		make install
	go get ${PACKAGE_SOURCE}
	cd ${GOPATH}/src/${PACKAGE_SOURCE} && \
		git checkout v${PACKAGE_VERSION}
	go build -o ~/${PACKAGE_NAME}/${PACKAGE_NAME} ${PACKAGE_SOURCE}
	chmod 755 ~/${PACKAGE_NAME}/${PACKAGE_NAME}
	cp -R /srv/debian.${DEBIAN_DISTRIBUTION} ~/${PACKAGE_NAME}/debian
	cd ~/${PACKAGE_NAME} && debuild --no-tgz-check -us -uc -b

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
