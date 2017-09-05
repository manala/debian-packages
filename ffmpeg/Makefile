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
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
