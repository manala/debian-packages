.SILENT:

###########
# Package #
###########

PACKAGE                              = ansible
PACKAGE_VERSION                      = 2.2.0.0
PACKAGE_REVISION                     = 4
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
	git clone \
		--branch debian/$(call package_debian_version) \
		git://anonscm.debian.org/collab-maint/$(PACKAGE).git ~/$(PACKAGE)

	$(call log,Install dependencies)
	sudo apt-get update
	cd ~/$(PACKAGE) \
		&& mk-build-deps \
			--install --build-dep --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

	$(call log,Prepare package)
	cd ~/$(PACKAGE) \
		&& dch --newversion $(call package_manala_version,$(DEBIAN_DISTRIBUTION)) "Backport" \
		&& dch --release ""

	$(call log,Build package)
	cd ~/$(PACKAGE) \
		&& debuild --no-tgz-check -us -uc -b
