.SILENT:
.PHONY: help dev build
.DEFAULT_GOAL := help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME                  = backup-manager
PACKAGE_DISTRIBUTION          = testing
PACKAGE_VERSION               = 0.7.12
PACKAGE_REVISION              = 4
PACKAGE_REVISION_MANALA       = 1
PACKAGE_REVISION_DISTRIBUTION = 1

## Maintainer
MAINTAINER_NAME  = Manala
MAINTAINER_EMAIL = contact@manala.io

# Docker
DOCKER_IMAGE = manala/build-debian
DOCKER_TAG  ?=

# Debian
DEBIAN_DISTRIBUTION ?= wheezy jessie

-include Makefile.local

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
	{ lastLine = $$0 }' ${MAKEFILE_LIST}

#######
# Dev #
#######

## Dev
dev:
	docker run \
		--rm \
		--volume `pwd`:/srv \
		--tty --interactive \
		--env USER_ID=`id -u` \
		--env GROUP_ID=`id -g` \
		${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)$(lastword ${DEBIAN_DISTRIBUTION})

## Dev - Wheezy
dev@wheezy: DEBIAN_DISTRIBUTION = wheezy
dev@wheezy: dev

## Dev - Jessie
dev@jessie: DEBIAN_DISTRIBUTION = jessie
dev@jessie: dev

#########
# Build #
#########

## Build
build:
	EXIT=0 ; ${foreach \
		distribution,\
		${DEBIAN_DISTRIBUTION},\
		printf "\n${COLOR_INFO}Build ${COLOR_COMMENT}${distribution}${COLOR_RESET}\n\n" && \
			docker run \
			    --rm \
			    --volume `pwd`:/srv \
			    --tty \
					--env USER_ID=`id -u` \
					--env GROUP_ID=`id -g` \
			    ${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)${distribution} \
			    make build-package DEBIAN_DISTRIBUTION=${distribution} \
		|| EXIT=$$? ;\
	} exit $$EXIT

## Build - Wheezy
build@wheezy: DEBIAN_DISTRIBUTION = wheezy
build@wheezy: build

## Build - Jessie
build@jessie: DEBIAN_DISTRIBUTION = jessie
build@jessie: build

build-package:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"
	echo "deb-src http://httpredir.debian.org/debian ${PACKAGE_DISTRIBUTION} main contrib non-free" | sudo tee /etc/apt/sources.list.d/${PACKAGE_DISTRIBUTION}.list
	sudo apt-get update

	printf "${COLOR_INFO}Prepare package...${COLOR_RESET}\n"
	sudo apt-get -y --only-source build-dep ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ && apt-get -y --only-source source ${PACKAGE_NAME}/${PACKAGE_DISTRIBUTION}
	cd ~ \
	  && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} \
	  && \
	    DEBFULLNAME="${MAINTAINER_NAME}" \
	    DEBEMAIL="${MAINTAINER_EMAIL}" \
	    dch -v ${PACKAGE_VERSION}-${PACKAGE_REVISION}manala${PACKAGE_REVISION_MANALA}~${DEBIAN_DISTRIBUTION}${PACKAGE_REVISION_DISTRIBUTION} "Backport"

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cd ~ && cd ${PACKAGE_NAME}-${PACKAGE_VERSION} && debuild -us -uc

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
