.SILENT:

###########
# Package #
###########

PACKAGE               = phantomjs
PACKAGE_VERSION       = 2.1.1
PACKAGE_SOURCE        = https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$(PACKAGE_VERSION)-linux-x86_64.tar.bz2
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
