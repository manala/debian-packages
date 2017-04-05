.SILENT:
.PHONY: help dev build
.DEFAULT_GOAL := help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME    = vault
PACKAGE_VERSION = 0.7.0
PACKAGE_SOURCE  = https://releases.hashicorp.com/vault/${PACKAGE_VERSION}/vault_${PACKAGE_VERSION}_linux_amd64.zip

# Docker
DOCKER_IMAGE = manala/build-debian
DOCKER_TAG  ?=

# Debian
DEBIAN_DISTRIBUTION ?= jessie

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

## Build - Jessie
build@jessie: DEBIAN_DISTRIBUTION = jessie
build@jessie: build

build-package:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}

	printf "${COLOR_INFO}Download upstream package...${COLOR_RESET}\n"
	curl -L ${PACKAGE_SOURCE} \
		| bsdtar -xvf - -C ~/${PACKAGE_NAME}

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cp -R /srv/debian.$(lastword ${DEBIAN_DISTRIBUTION}) ~/${PACKAGE_NAME}/debian
	cd ~/${PACKAGE_NAME} && debuild --no-tgz-check -us -uc -b

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
