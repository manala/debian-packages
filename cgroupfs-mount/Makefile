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

build:

	$(call build_clean)

	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	cp -R $(PACKAGE_DIR)/src/* $(PACKAGE_BUILD_DIR)/$(PACKAGE)

	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
