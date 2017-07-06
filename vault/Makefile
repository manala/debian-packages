.SILENT:

###########
# Package #
###########

PACKAGE               = vault
PACKAGE_VERSION       = 0.7.0
PACKAGE_SOURCE        = https://releases.hashicorp.com/vault/$(PACKAGE_VERSION)/vault_$(PACKAGE_VERSION)_linux_amd64.zip
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include manala/make/Makefile

#########
# Build #
#########

build-package@build:

	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE)

	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
