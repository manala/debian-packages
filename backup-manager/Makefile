.SILENT:

###########
# Package #
###########

PACKAGE                              = backup-manager
PACKAGE_VERSION                      = 0.7.12
PACKAGE_REVISION                     = 4
PACKAGE_REVISION_MANALA              = 1
PACKAGE_REVISION_MANALA_DISTRIBUTION = 1
PACKAGE_DISTRIBUTIONS                = wheezy jessie stretch

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
	debsnap --force --verbose --destdir $(PACKAGE_BUILD_DIR) $(PACKAGE) $(call package_debian_version)
	dpkg-source -x $(PACKAGE_BUILD_DIR)/$(PACKAGE)_$(call package_debian_file).dsc $(PACKAGE_BUILD_DIR)/$(PACKAGE)

	$(call log,Prepare)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& dch --newversion $(call package_manala_version,$(DEBIAN_DISTRIBUTION)) "Backport" \
		&& dch --release ""

	$(call log,Dependencies)
	sudo apt-get update
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc

	$(call build_dist)
