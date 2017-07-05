.SILENT:

###########
# Package #
###########

PACKAGE                              = pam-ssh-agent-auth
PACKAGE_VERSION                      = 0.10.3
PACKAGE_REVISION                     = 1
PACKAGE_REVISION_MANALA              = 1
PACKAGE_REVISION_MANALA_DISTRIBUTION = 1
PACKAGE_SOURCE                       = https://downloads.sourceforge.net/project/pamsshagentauth/pam_ssh_agent_auth/v$(PACKAGE_VERSION)/pam_ssh_agent_auth-$(PACKAGE_VERSION).tar.bz2
PACKAGE_DISTRIBUTIONS                = wheezy jessie stretch

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
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

	$(call log,Prepare)
	#echo "\noverride_dh_auto_configure:\n\tdh_auto_configure -- --without-openssl-header-check\n" \
	#	>> $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian/rules
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& dch --newversion $(call package_manala_version,$(DEBIAN_DISTRIBUTION)) "Backport" \
		&& dch --release ""

	$(call log,Dependencies)
	sudo apt-get update
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc
