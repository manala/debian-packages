.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME            = phantomjs
PACKAGE_DESCRIPTION     = Full web stack, no browser required
PACKAGE_VERSION         = 2.1.1
PACKAGE_REVISION_MANALA = 1
PACKAGE_REVISION_JESSIE = 1
PACKAGE_LICENSE         = BSD
PACKAGE_HOMEPAGE        = http://phantomjs.org/
PACKAGE_SOURCE          = https://bitbucket.org/ariya/phantomjs/downloads

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
	cd ~/fpm && git checkout afbb266
	cd ~/fpm && make install
	# Dependencies
	apt-get -y install curl bzip2
	# Get origin package
	curl -L ${PACKAGE_SOURCE}/phantomjs-${PACKAGE_VERSION}-linux-x86_64.tar.bz2 -o ~/origin.tar.bz2
	mkdir -p ~/origin
	tar xfv ~/origin.tar.bz2 -C ~/origin --strip-components=1
	# Prepare package
	mkdir -p ~/package/usr/bin
	mv ~/origin/bin/phantomjs ~/package/usr/bin
	chmod 755 ~/package/usr/bin/phantomjs
	# Fpm
	cd ~/package && fpm \
	    --verbose \
	    -s dir \
	    -t deb \
	    --deb-compression xz \
	    -n ${PACKAGE_NAME} \
	    -v ${PACKAGE_VERSION} \
	    --depends libfontconfig \
	    --iteration manala${PACKAGE_REVISION_MANALA}~jessie${PACKAGE_REVISION_JESSIE} \
	    -m "${MAINTAINER_NAME} <${MAINTAINER_EMAIL}>" \
	    --description "${PACKAGE_DESCRIPTION}" \
	    --license ${PACKAGE_LICENSE} \
	    --url ${PACKAGE_HOMEPAGE} \
	    --deb-systemd "/srv/src/systemd/phantomjs" \
	    --vendor "" \
	    .
	mkdir -p /srv/build && mv ~/package/*.deb /srv/build
