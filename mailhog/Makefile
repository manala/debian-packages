.SILENT:

###########
# Package #
###########

PACKAGE               = mailhog
PACKAGE_VERSION       = 1.0.0
PACKAGE_SOURCE        = https://github.com/mailhog/MailHog/releases/download/v$(PACKAGE_VERSION)/MailHog_linux_amd64
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

	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) -o $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)

	$(call log,Prepare)
	chmod 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
