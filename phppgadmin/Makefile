.SILENT:

###########
# Package #
###########

PACKAGE               = phppgadmin
PACKAGE_VERSION       = 5.1.0
PACKAGE_SOURCE        = https://github.com/phppgadmin/phppgadmin/archive/c7c6beb.tar.gz
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

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
