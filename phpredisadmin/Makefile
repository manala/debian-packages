.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = phpredisadmin
PACKAGE_VERSION       = 1.7.0
PACKAGE_SOURCE        = https://github.com/erikdubbelboer/phpRedisAdmin/archive/v$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)

	# Composer
	$(call eq,stretch,$(DISTRIBUTION), \
		sudo apt-get install -y --no-install-recommends php-cli, \
		sudo apt-get install -y --no-install-recommends php5-cli \
	)
	curl -L https://getcomposer.org/installer \
		| sudo php -- --install-dir /usr/bin --filename composer

	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
