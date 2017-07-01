.SILENT:

###########
# Package #
###########

PACKAGE               = oauth2-proxy
PACKAGE_VERSION       = 2.2.0
PACKAGE_SOURCE        = https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-$(PACKAGE_VERSION).linux-amd64.go1.8.1.tar.gz
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
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C ~/$(PACKAGE) --strip-components=1

	$(call log,Prepare)
	mv ~/$(PACKAGE)/oauth2_proxy ~/$(PACKAGE)/$(PACKAGE)
	chmod 755 ~/$(PACKAGE)/$(PACKAGE)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
