.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = gitsplit
PACKAGE_VERSION       = b524730
PACKAGE_SOURCE        = https://github.com/jderusse/docker-gitsplit/archive/$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	chmod $(call verbose, , ,--verbose) 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp $(call verbose, , ,--verbose) --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
