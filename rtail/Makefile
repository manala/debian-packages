.SILENT:

###########
# Package #
###########

PACKAGE               = node-rtail
PACKAGE_VERSION       = 0.2.1
PACKAGE_SOURCE        = rtail@$(PACKAGE_VERSION)
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include .manala/make/Makefile

#########
# Build #
#########

build:

	$(call build_clean)

	$(call log,Node)
ifeq ($(DEBIAN_DISTRIBUTION), wheezy)
	curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
else
	curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
endif
	echo "Package:      nodejs*\nPin:          origin deb.nodesource.com\nPin-Priority: 900" | sudo tee /etc/apt/preferences.d/nodejs
	sudo apt-get install -y --no-install-recommends nodejs

	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& npm install --legacy-bundling --only=prod \
			$(PACKAGE_SOURCE)

	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
