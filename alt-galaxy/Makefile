.SILENT:

###########
# Package #
###########

PACKAGE               = alt-galaxy
PACKAGE_VERSION       = 1.3.3
PACKAGE_SOURCE        = https://github.com/gantsign/alt-galaxy/releases/download/$(PACKAGE_VERSION)/alt-galaxy_linux_amd64.tar.xz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include manala/make/Makefile

#########
# Build #
#########

build-package@build:
	$(call log,Create build workspace)
	mkdir -p ~/$(PACKAGE)

	$(call log,Prepare package)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C ~/$(PACKAGE)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build package)
	cd ~/$(PACKAGE) \
		&& debuild --no-tgz-check -us -uc -b
