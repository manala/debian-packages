.SILENT:

###########
# Package #
###########

PACKAGE               = phppgadmin
PACKAGE_VERSION       = 5.1.0
PACKAGE_SOURCE        = https://github.com/phppgadmin/phppgadmin/archive/c7c6beb.tar.gz
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
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

	$(call log,Prepare)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
