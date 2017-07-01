.SILENT:

###########
# Package #
###########

PACKAGE               = gitsplit
PACKAGE_VERSION       = 63c00e6
PACKAGE_SOURCE        = https://github.com/jderusse/docker-gitsplit/archive/$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include manala/make/Makefile

#########
# Build #
#########

build-package@build:

	$(call log,Checkout)
	mkdir -p ~/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C ~/$(PACKAGE) --strip-components=1

	$(call log,Prepare)
	chmod 755 ~/$(PACKAGE)/$(PACKAGE)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Dependencies)
	sudo apt-get update
	cd ~/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
