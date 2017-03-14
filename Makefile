.SILENT:
.PHONY: help build

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_UPSTREAM_NAME = mongo-express
PACKAGE_NAME          = node-${PACKAGE_UPSTREAM_NAME}
PACKAGE_VERSION       = 0.38.0

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
ifeq (${DEBIAN_DISTRIBUTION}, wheezy)
	curl -sL https://deb.nodesource.com/setup_6.x | bash -
else
	curl -sL https://deb.nodesource.com/setup_7.x | bash -
endif
	echo "Package:      nodejs*\nPin:          origin deb.nodesource.com\nPin-Priority: 900" > /etc/apt/preferences.d/nodejs
	apt-get install -y nodejs
	#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
	#echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" > /etc/apt/sources.list.d/mongodb.list
	#apt-get update
	#apt-get install -y mongodb-org

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}

	printf "${COLOR_INFO}Download upstream package...${COLOR_RESET}\n"
	cd ~/${PACKAGE_NAME} && npm install ${PACKAGE_UPSTREAM_NAME}@${PACKAGE_VERSION} --legacy-bundling --only=prod

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cp -R /srv/debian.${DEBIAN_DISTRIBUTION} ~/${PACKAGE_NAME}/debian
	cd ~/${PACKAGE_NAME} && debuild --no-tgz-check -us -uc -b

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
