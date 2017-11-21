.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = python-proxmoxer
PACKAGE_VERSION       = 1.0.0
PACKAGE_SOURCE        = https://pypi.python.org/packages/ac/7d/7042ed00f532428516fa537b18d9464a76e282acbad8fab1396f3581e583/proxmoxer-$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = jessie stretch

package.checkout:
	$(call log,Checkout)

	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
