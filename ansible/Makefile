.SILENT:

###########
# Package #
###########

PACKAGE                              = ansible
PACKAGE_VERSION                      = 2.2.0.0
PACKAGE_REVISION                     = 1
PACKAGE_REVISION_MANALA              = 1
PACKAGE_REVISION_MANALA_DISTRIBUTION = 1
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
	debsnap --force --verbose --destdir ~ $(PACKAGE) $(call package_debian_version)
	dpkg-source -x ~/$(PACKAGE)_$(call package_debian_file).dsc ~/$(PACKAGE)

	$(call log,Prepare)
	cd ~/$(PACKAGE) \
		&& dch --newversion $(call package_manala_version,$(DEBIAN_DISTRIBUTION)) "Backport" \
		&& dch --release ""

	$(call log,Dependencies)
	sudo apt-get update
	cd ~/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc
