.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = exa
PACKAGE_VERSION       = 0.8.0
PACKAGE_SOURCE        = https://github.com/ogham/exa/releases/download/v$(PACKAGE_VERSION)/exa-linux-x86_64-$(PACKAGE_VERSION).zip
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	mv $(call verbose, , ,--verbose) \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/exa-linux-x86_64 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/exa
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
