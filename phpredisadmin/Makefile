.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = phpredisadmin
PACKAGE_VERSION       = 1.9.0
PACKAGE_SOURCE        = https://github.com/erikdubbelboer/phpRedisAdmin/archive/v$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)

	# Composer
	$(call if_eq,stretch,$(DISTRIBUTION), \
		sudo apt-get install -y --no-install-recommends php-cli, \
		sudo apt-get install -y --no-install-recommends php5-cli \
	)
	curl $(call verbose,--silent,--silent --show-error, ) --location https://getcomposer.org/installer \
		| sudo php -- --install-dir /usr/bin --filename composer

	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
