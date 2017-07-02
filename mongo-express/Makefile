.SILENT:

###########
# Package #
###########

PACKAGE               = node-mongo-express
PACKAGE_VERSION       = 0.40.0
PACKAGE_SOURCE        = mongo-express@$(PACKAGE_VERSION)
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include manala/make/Makefile

#########
# Build #
#########

build-package@build:

	$(call log,Node)
ifeq ($(DEBIAN_DISTRIBUTION), wheezy)
	curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
else
	curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
endif
	echo "Package:      nodejs*\nPin:          origin deb.nodesource.com\nPin-Priority: 900" | sudo tee /etc/apt/preferences.d/nodejs
	sudo apt-get install -y --no-install-recommends nodejs

	$(call log,Checkout)
	mkdir -p ~/$(PACKAGE)
	cd ~/$(PACKAGE) \
		&& npm install --legacy-bundling --only=prod \
			$(PACKAGE_SOURCE)

	$(call log,Prepare)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
