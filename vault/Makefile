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


___build-package:
	printf "${COLOR_INFO}Install build dependencies...${COLOR_RESET}\n"

	printf "${COLOR_INFO}Create build workspace...${COLOR_RESET}\n"
	mkdir -p ~/${PACKAGE_NAME}

	printf "${COLOR_INFO}Download upstream package...${COLOR_RESET}\n"
	curl -L ${PACKAGE_SOURCE} \
		| bsdtar -xvf - -C ~/${PACKAGE_NAME}

	printf "${COLOR_INFO}Build package...${COLOR_RESET}\n"
	cp -R /srv/debian.$(lastword ${DEBIAN_DISTRIBUTION}) ~/${PACKAGE_NAME}/debian
	cd ~/${PACKAGE_NAME} && debuild --no-tgz-check -us -uc -b

	printf "${COLOR_INFO}Show packages informations...${COLOR_RESET}\n"
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	printf "${COLOR_INFO}Move builded packages into build directory...${COLOR_RESET}\n"
	mkdir -p /srv/build && mv ~/*.deb /srv/build
