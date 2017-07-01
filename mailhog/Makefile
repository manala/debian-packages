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

build-package@build:

	$(call log,Checkout)
	mkdir -p ~/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) -o ~/$(PACKAGE)/$(PACKAGE)
	chmod 755 ~/$(PACKAGE)/$(PACKAGE)

	$(call log,Prepare)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
