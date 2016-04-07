.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME            = ngrok
PACKAGE_DESCRIPTION     = Secure tunnels to localhost
PACKAGE_VERSION         = 2.0.25
PACKAGE_REVISION_MANALA = 1
PACKAGE_REVISION_JESSIE = 1
PACKAGE_LICENSE         = MIT
PACKAGE_HOMEPAGE        = https://ngrok.com/
PACKAGE_SOURCE          = https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip

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
build: build@debian-jessie

build@debian-jessie: DEBIAN_DISTRIBUTION = jessie
build@debian-jessie:
	$(DOCKER)

build-package@debian-jessie:
	# Fpm (prefer git version, as 1.4 don't support systemd options)
	apt-get -y install git ruby ruby-dev gcc xz-utils
	git clone https://github.com/jordansissel/fpm.git ~/fpm
	cd ~/fpm && git checkout 420a76b
	cd ~/fpm && make install
	# Dependencies
	apt-get -y install wget unzip
	# Get binary
	mkdir -p ~/package/usr/bin
	wget ${PACKAGE_SOURCE} -O ~/package.zip
	cd ~ && unzip package.zip -d ~/package/usr/bin/
	chmod 755 ~/package/usr/bin/ngrok
	# Fpm
	cd ~/package && fpm \
        --verbose \
        -s dir \
        -t deb \
        --deb-compression xz \
        -n ${PACKAGE_NAME} \
        -v ${PACKAGE_VERSION} \
        --iteration manala${PACKAGE_REVISION_MANALA}~jessie${PACKAGE_REVISION_JESSIE} \
        -m "${MAINTAINER_NAME} <${MAINTAINER_EMAIL}>" \
        --description "${PACKAGE_DESCRIPTION}" \
        --license ${PACKAGE_LICENSE} \
        --url ${PACKAGE_HOMEPAGE} \
        --vendor "" \
        .
	mkdir -p /srv/build && mv ~/package/*.deb /srv/build
