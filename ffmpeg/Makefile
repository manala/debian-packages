.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = ffmpeg
PACKAGE_VERSION       = 2.8
PACKAGE_SOURCE        = file://$(PACKAGE_DIR)/files/ffmpeg-$(PACKAGE_VERSION)-64bit-static.tar.xz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
