.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = exa
PACKAGE_VERSION       = 0.7.0
PACKAGE_SOURCE        = https://github.com/ogham/exa/releases/download/v$(PACKAGE_VERSION)/exa-linux-x86_64-$(PACKAGE_VERSION).zip
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	mv $(PACKAGE_BUILD_DIR)/$(PACKAGE)/exa-linux-x86_64 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/exa
	cp -R $(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
