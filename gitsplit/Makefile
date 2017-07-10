.SILENT:

###########
# Package #
###########

PACKAGE               = gitsplit
PACKAGE_VERSION       = 63c00e6
PACKAGE_SOURCE        = https://github.com/jderusse/docker-gitsplit/archive/$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include .manala/make/Makefile

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
	chmod 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp -R $(PACKAGE_DIR)/debian/$(DEBIAN_DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

	$(call log,Dependencies)
	sudo apt-get update
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b

	$(call build_dist)
