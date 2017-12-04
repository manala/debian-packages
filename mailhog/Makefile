.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = mailhog
PACKAGE_VERSION       = 1.0.0
PACKAGE_SOURCE        = https://github.com/mailhog/MailHog/releases/download/v$(PACKAGE_VERSION)/MailHog_linux_amd64
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		-o $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	chmod $(call verbose, , ,--verbose) 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
