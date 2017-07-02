.SILENT:

###########
# Package #
###########

PACKAGE               = phpmyadmin
PACKAGE_VERSION       = 4.7.1
PACKAGE_SOURCE        = https://files.phpmyadmin.net/phpMyAdmin/$(PACKAGE_VERSION)/phpMyAdmin-$(PACKAGE_VERSION)-all-languages.tar.gz
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
