.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = oauth2-proxy
PACKAGE_VERSION       = 2.2.0
PACKAGE_SOURCE        = https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-$(PACKAGE_VERSION).linux-amd64.go1.8.1.tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	mv $(call verbose, , ,--verbose) \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE)/oauth2_proxy $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	chmod $(call verbose, , ,--verbose) 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp $(call verbose, , ,--verbose) --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
