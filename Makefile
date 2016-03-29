.SILENT:
.PHONY: help

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

## Package
PACKAGE_NAME            = mailhog
PACKAGE_DESCRIPTION     = Web and API based SMTP testing
PACKAGE_VERSION         = 0.1.9
PACKAGE_REVISION_MANALA = 1
PACKAGE_REVISION_JESSIE = 1
PACKAGE_LICENSE         = MIT
PACKAGE_HOMEPAGE        = https://github.com/mailhog/MailHog
PACKAGE_SOURCE          = https://github.com/mailhog/MailHog/releases/download

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
	apt-get -y install wget
	# Get binary
	mkdir -p ~/package/usr/bin
	wget ${PACKAGE_SOURCE}/v${PACKAGE_VERSION}/MailHog_linux_amd64 -O ~/package/usr/bin/mailhog
	chmod 755 ~/package/usr/bin/mailhog
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
	    --deb-systemd "/srv/src/systemd/mailhog" \
	    --vendor "" \
	    .
	mkdir -p /srv/build && mv ~/package/*.deb /srv/build
