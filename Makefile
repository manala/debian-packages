.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME    = cgroupfs-mount
PACKAGE_VERSION = 1.0.0

## Macros
DOCKER = docker run \
    --rm \
    --volume `pwd`:/srv \
    --workdir /srv \
    --tty \
    manala/build-debian:${DEBIAN_DISTRIBUTION} \
    make build-package DEBIAN_DISTRIBUTION=${DEBIAN_DISTRIBUTION}

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

#########
# Build #
#########

## Build
build: build@wheezy

build@wheezy: DEBIAN_DISTRIBUTION = wheezy
build@wheezy:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build-package:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}-${PACKAGE_VERSION}

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cp -a /srv/* ~/${PACKAGE_NAME}-${PACKAGE_VERSION}
	cp -a /srv/debian.${DEBIAN_DISTRIBUTION} ~/${PACKAGE_NAME}-${PACKAGE_VERSION}/debian
	ls -alsh ~/${PACKAGE_NAME}-${PACKAGE_VERSION}
	cd ~/${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
