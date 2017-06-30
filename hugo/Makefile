.SILENT:

###########
# Package #
###########

PACKAGE               = hugo
PACKAGE_VERSION       = 0.23
PACKAGE_SOURCE        = https://github.com/gohugoio/hugo/releases/download/v$(PACKAGE_VERSION)/hugo_$(PACKAGE_VERSION)_Linux-64bit.tar.gz
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
		| bsdtar -xvf - -C ~/$(PACKAGE)

	$(call log,Prepare)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
