.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = sensu-go-backend
PACKAGE_VERSION       = 6.5.1
PACKAGE_SOURCE        = https://github.com/sensu/sensu-go/archive/v$(PACKAGE_VERSION).tar.gz
PACKAGE_DISTRIBUTIONS = stretch buster bullseye

export PATH  := $(PATH):/usr/local/go/bin
export LANG   = C.UTF-8

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

	#Go
	curl $(call verbose,--silent,--silent --show-error, ) --location https://dl.google.com/go/go1.17.2.linux-amd64.tar.gz \
		| sudo bsdtar $(call verbose, , ,-v) -xf - -C /usr/local

	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
	&& go build \
		-ldflags '-X "github.com/sensu/sensu-go/version.Version=$(PACKAGE_VERSION)"' \
		-o bin/sensu-backend ./cmd/sensu-backend

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
