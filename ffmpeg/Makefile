.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = ffmpeg
PACKAGE_VERSION       = 2.8.4
PACKAGE_SOURCE        = file://$(PACKAGE_DIR)/files/ffmpeg-$(PACKAGE_VERSION)-64bit-static.tar.xz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)/man
	help2man --no-info --version-option "-version" --output $(PACKAGE_BUILD_DIR)/$(PACKAGE)/man/ffmpeg.1 \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/ffmpeg
	help2man --no-info --version-option "-version" --output $(PACKAGE_BUILD_DIR)/$(PACKAGE)/man/ffmpeg-10bit.1 \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/ffmpeg-10bit
	help2man --no-info --version-option "-version" --output $(PACKAGE_BUILD_DIR)/$(PACKAGE)/man/ffprobe.1 \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/ffprobe
	help2man --no-info --version-option "-version" --output $(PACKAGE_BUILD_DIR)/$(PACKAGE)/man/ffserver.1 \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/ffserver
	help2man --no-info --version-option "-version" --output $(PACKAGE_BUILD_DIR)/$(PACKAGE)/man/qt-faststart.1 \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/qt-faststart

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
