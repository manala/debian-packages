.SILENT:

###########
# Package #
###########

PACKAGE               = phpredisadmin
PACKAGE_VERSION       = 1.7.0
PACKAGE_SOURCE        = https://github.com/erikdubbelboer/phpRedisAdmin/archive/v$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include manala/make/Makefile

#########
# Build #
#########

build:

	$(call build_clean)

	$(call log,Composer)
	sudo apt-get update
ifneq (,$(filter $(DEBIAN_DISTRIBUTION),wheezy jessie))
	sudo apt-get install -y --no-install-recommends php5-cli
else
	sudo apt-get install -y --no-install-recommends php-cli
endif
	curl -L https://getcomposer.org/installer \
		| sudo php -- --install-dir /usr/bin --filename composer

	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
