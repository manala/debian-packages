.SILENT:

###########
# Package #
###########

PACKAGE               = ngrok
PACKAGE_VERSION       = 2.2.3
PACKAGE_SOURCE        = https://bin.equinox.io/a/jusDiLP9PCU/ngrok-$(PACKAGE_VERSION)-linux-amd64.tar.gz
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
	chmod 755 ~/$(PACKAGE)/$(PACKAGE)

	$(call log,Prepare)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
