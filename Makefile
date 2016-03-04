.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME            = jinja2
PACKAGE_DISTRIBUTION    = testing
PACKAGE_VERSION         = 2.8
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
    debian:${DEBIAN_DISTRIBUTION} \
    sh -c '\
        apt-get update && \
        apt-get -y upgrade && \
        apt-get -y install make && \
        make build-package@debian-${DEBIAN_DISTRIBUTION} \
    '

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
	$(DOCKER)

build@debian-jessie: DEBIAN_DISTRIBUTION = jessie
build@debian-jessie:
	$(DOCKER)

build-package@debian-wheezy:
	echo "deb-src http://httpredir.debian.org/debian ${PACKAGE_DISTRIBUTION} main contrib non-free" > /etc/apt/sources.list.d/${PACKAGE_DISTRIBUTION}.list
	echo "deb http://httpredir.debian.org/debian wheezy-backports main" > /etc/apt/sources.list.d/backports.list
	apt-get update
	apt-get -y install devscripts
	apt-get -y --only-source build-dep ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && apt-get -y --only-source source ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && DEBFULLNAME="${MAINTAINER_NAME}" DEBEMAIL="${MAINTAINER_EMAIL}" dch -v ${PACKAGE_VERSION}-${PACKAGE_REVISION}manala${PACKAGE_REVISION_MANALA}~wheezy${PACKAGE_REVISION_WHEEZY} "Backport"
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc
	mkdir -p /srv/build && mv ~/*.deb /srv/build

build-package@debian-jessie:
	echo "deb-src http://httpredir.debian.org/debian ${PACKAGE_DISTRIBUTION} main contrib non-free" > /etc/apt/sources.list.d/${PACKAGE_DISTRIBUTION}.list
	apt-get update
	apt-get -y install devscripts
	apt-get -y --only-source build-dep ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && apt-get -y --only-source source ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && DEBFULLNAME="${MAINTAINER_NAME}" DEBEMAIL="${MAINTAINER_EMAIL}" dch -v ${PACKAGE_VERSION}-${PACKAGE_REVISION}manala${PACKAGE_REVISION_MANALA}~jessie${PACKAGE_REVISION_JESSIE} "Backport"
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc
	mkdir -p /srv/build && mv ~/*.deb /srv/build
