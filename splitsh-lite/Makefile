.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = splitsh-lite
PACKAGE_VERSION       = 1.0.1
PACKAGE_GO            = github.com/splitsh/lite
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

export GOPATH = $(PACKAGE_BUILD_DIR)/go
export PATH  := $(PATH):/usr/local/go/bin

package.checkout:
	$(call log,Checkout)

	# Go
	curl $(call verbose,--silent,--silent --show-error, ) --location https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz \
		| sudo bsdtar $(call verbose, , ,-v) -xf - -C /usr/local

	# Git2go
	sudo apt-get install -y --no-install-recommends \
		cmake pkg-config libssh2-1-dev libssl-dev libcurl4-openssl-dev
	go get -d github.com/libgit2/git2go
	cd $(GOPATH)/src/github.com/libgit2/git2go \
		&& git checkout next \
		&& git submodule update --init \
		&& $(MAKE) install

	go get $(PACKAGE_GO)
	cd $(GOPATH)/src/$(PACKAGE_GO) \
		&& git checkout tags/v$(PACKAGE_VERSION) -b v$(PACKAGE_VERSION)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	go build -o $(PACKAGE_BUILD_DIR)/$(PACKAGE)/bin/$(PACKAGE) $(PACKAGE_GO)

package.prepare:
	$(call log,Prepare)
	chmod $(call verbose, , ,--verbose) 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/bin/$(PACKAGE)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
