## Package
PACKAGE_NAME    = alt-galaxy
PACKAGE_VERSION = 1.3.3
PACKAGE_SOURCE  = https://github.com/gantsign/alt-galaxy/releases/download/$(PACKAGE_VERSION)/alt-galaxy_linux_amd64.tar.xz

# Debian
DEBIAN_DISTRIBUTION ?= wheezy jessie stretch

include manala/make/Makefile

#########
# Build #
#########

build-package:
	$(call log,Install build dependencies)

	$(call log,Create build workspace)
	mkdir -p ~/$(PACKAGE_NAME)

	$(call log,Download upstream package)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C ~/$(PACKAGE_NAME)

	$(call log,Build package)
	cp -R /srv/debian.$(lastword $(DEBIAN_DISTRIBUTION)) ~/$(PACKAGE_NAME)/debian
	cd ~/$(PACKAGE_NAME) && debuild --no-tgz-check -us -uc -b

	$(call log,Show packages informations)
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	$(call log,Move builded packages into build directory)
	mkdir -p /srv/build && mv ~/*.deb /srv/build
