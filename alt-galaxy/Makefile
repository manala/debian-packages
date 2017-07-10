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

include .manala/make/Makefile

#########
# Build #
#########

build:

	$(call build_clean)

	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
