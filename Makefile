.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME                  = pam-ssh-agent-auth
PACKAGE_VERSION               = 0.10.2
PACKAGE_SOURCE = http://heanet.dl.sourceforge.net/project/pamsshagentauth/pam_ssh_agent_auth/v0.10.2/pam_ssh_agent_auth-0.10.2.tar.bz2

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
build: build@jessie

build@jessie: DEBIAN_DISTRIBUTION = jessie
build@jessie:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build-package:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"
	apt-get update
	apt-get -y install autotools-dev libssl-dev libpam0g-dev

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}-${PACKAGE_VERSION}

	printf "${COLOR_INFO}Download upstream package...${COLOR_RESET}\n"
	curl -L ${PACKAGE_SOURCE} -o ~/${PACKAGE_NAME}_${PACKAGE_VERSION}.orig.tar.bz2
	tar xfv ~/${PACKAGE_NAME}_${PACKAGE_VERSION}.orig.tar.bz2 -C ~/${PACKAGE_NAME}-${PACKAGE_VERSION} --strip-components=1

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -i -us -uc -b

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
