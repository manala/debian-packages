.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = rtail
PACKAGE_VERSION       = 0.2.1
PACKAGE_SOURCE        = $(PACKAGE)@$(PACKAGE_VERSION)
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)

	# Node
	$(call if_eq,wheezy,$(DISTRIBUTION), \
		curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -, \
		curl -sL https://deb.nodesource.com/setup_8.x | sudo bash - \
	)
	echo "Package:      nodejs*\nPin:          origin deb.nodesource.com\nPin-Priority: 900" | sudo tee /etc/apt/preferences.d/nodejs
	sudo apt-get install -y --no-install-recommends nodejs

	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& npm install --legacy-bundling --only=prod $(PACKAGE_SOURCE)

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
