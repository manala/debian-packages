.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = vault
PACKAGE_VERSION       = 0.7.3
PACKAGE_SOURCE        = https://releases.hashicorp.com/vault/$(PACKAGE_VERSION)/vault_$(PACKAGE_VERSION)_linux_amd64.zip
PACKAGE_DISTRIBUTIONS = jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

package.prepare:
	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
