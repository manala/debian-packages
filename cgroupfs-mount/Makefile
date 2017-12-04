.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = cgroupfs-mount
PACKAGE_DISTRIBUTIONS = wheezy

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	cp $(call verbose, , ,--verbose) --recursive \
		$(PACKAGE_DIR)/src/* $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
