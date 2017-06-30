.SILENT:

###########
# Package #
###########

PACKAGE               = cgroupfs-mount
PACKAGE_DISTRIBUTIONS = wheezy

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
	cp -R /srv/src/* ~/$(PACKAGE)

	$(call log,Prepare package)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build package)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
