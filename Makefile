.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME            = ansible
PACKAGE_DISTRIBUTION    = unstable
PACKAGE_VERSION         = 2.0.2.0
PACKAGE_REVISION        = 1
PACKAGE_REVISION_MANALA = 1
PACKAGE_REVISION_WHEEZY = 1
PACKAGE_REVISION_JESSIE = 1

## Maintainer
MAINTAINER_NAME  = Manala
MAINTAINER_EMAIL = contact@manala.io

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
build: build@debian-wheezy build@debian-jessie

build@debian-wheezy: DEBIAN_DISTRIBUTION = wheezy
build@debian-wheezy:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build@debian-jessie: DEBIAN_DISTRIBUTION = jessie
build@debian-jessie:
	printf "${COLOR_INFO}Run docker...${COLOR_RESET}\n"
	$(DOCKER)

build-package@debian-wheezy:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"
	echo "deb-src http://httpredir.debian.org/debian ${PACKAGE_DISTRIBUTION} main contrib non-free" > /etc/apt/sources.list.d/${PACKAGE_DISTRIBUTION}.list
	echo "deb http://httpredir.debian.org/debian wheezy-backports main" > /etc/apt/sources.list.d/backports.list
	apt-get update

	printf "${COLOR_INFO}Prepare package...${COLOR_RESET}\n"
	apt-get -y --only-source build-dep ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && apt-get -y --only-source source ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && DEBFULLNAME="${MAINTAINER_NAME}" DEBEMAIL="${MAINTAINER_EMAIL}" dch -v ${PACKAGE_VERSION}-${PACKAGE_REVISION}manala${PACKAGE_REVISION_MANALA}~wheezy${PACKAGE_REVISION_WHEEZY} "Backport"

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build

build-package@debian-jessie:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"
	echo "deb-src http://httpredir.debian.org/debian ${PACKAGE_DISTRIBUTION} main contrib non-free" > /etc/apt/sources.list.d/${PACKAGE_DISTRIBUTION}.list
	apt-get update

	printf "${COLOR_INFO}Prepare package...${COLOR_RESET}\n"
	apt-get -y --only-source build-dep ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && apt-get -y --only-source source ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && DEBFULLNAME="${MAINTAINER_NAME}" DEBEMAIL="${MAINTAINER_EMAIL}" dch -v ${PACKAGE_VERSION}-${PACKAGE_REVISION}manala${PACKAGE_REVISION_MANALA}~jessie${PACKAGE_REVISION_JESSIE} "Backport"

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
