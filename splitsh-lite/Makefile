.SILENT:
.PHONY: help dev build
.DEFAULT_GOAL := help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME    = splitsh-lite
PACKAGE_VERSION = 1.0.1
PACKAGE_SOURCE  = github.com/splitsh/lite

## GO
GO_VERSION = 1.8
export GOPATH = ${HOME}/go

## Path
export PATH := ${PATH}:/usr/local/go/bin

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
	sudo apt-get update
	sudo apt-get install -y git cmake pkg-config libssh2-1-dev libssl-dev libcurl4-openssl-dev
	curl -L https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz \
		| sudo bsdtar -xvf - -C /usr/local

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
