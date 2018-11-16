.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE                              = python-httplib2
PACKAGE_VERSION                      = 0.11.3
PACKAGE_REVISION                     = 1
PACKAGE_REVISION_MANALA              = 1
PACKAGE_REVISION_MANALA_DISTRIBUTION = 1
PACKAGE_DISTRIBUTIONS                = jessie stretch

package.checkout:
	$(call log,Checkout)
	debsnap $(call verbose, , ,--verbose) --force --destdir $(PACKAGE_BUILD_DIR) $(PACKAGE) $(call package_debian_version)
	dpkg-source -x $(PACKAGE_BUILD_DIR)/$(PACKAGE)_$(call package_debian_file).dsc $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& dch --newversion $(call package_manala_version,$(DISTRIBUTION)) "Backport" \
		&& dch --release ""

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc $(call verbose,>/dev/null 2>&1,>/dev/null, )
