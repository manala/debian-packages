.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME    = phpredisadmin
PACKAGE_VERSION = 1.4.2
PACKAGE_SOURCE  = https://github.com/erikdubbelboer/phpRedisAdmin/archive/v${PACKAGE_VERSION}.tar.gz

## Macros
DOCKER = docker run \
    --rm \
    --volume `pwd`:/srv \
    --workdir /srv \
    --tty \
    amezin/debian-build-essentials:${DEBIAN_DISTRIBUTION} \
    make build-package@debian-${DEBIAN_DISTRIBUTION}

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

## Build
build: build@debian-jessie

build@debian-jessie: DEBIAN_DISTRIBUTION = jessie
build@debian-jessie:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build-package@debian-jessie:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"
	apt-get update
	apt-get -y install curl devscripts pkg-php-tools

	printf "${COLOR_INFO}Install composer...${COLOR_RESET}\n"
	cd /tmp && curl -s https://getcomposer.org/installer | php
	mv /tmp/composer.phar /usr/bin/composer

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}-${PACKAGE_VERSION}

	printf "${COLOR_INFO}Download upstream package...${COLOR_RESET}\n"
	curl -L ${PACKAGE_SOURCE} -o ~/${PACKAGE_NAME}_${PACKAGE_VERSION}.orig.tar.gz
	tar xfv ~/${PACKAGE_NAME}_${PACKAGE_VERSION}.orig.tar.gz -C ~/${PACKAGE_NAME}-${PACKAGE_VERSION} --strip-components=1

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cp -a /srv/debian ~/${PACKAGE_NAME}-${PACKAGE_VERSION}
	cd ~/${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc

	printf "${COLOR_INFO}List builded packages...${COLOR_RESET}\n"
	ls -lsah ~/*.deb

	printf "${COLOR_INFO}Show builded packages informations...${COLOR_RESET}\n"
	dpkg -I ~/*.deb

	printf "${COLOR_INFO}Show builded packages files...${COLOR_RESET}\n"
	dpkg -c ~/*.deb

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
