.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = gitsplit
PACKAGE_VERSION       = 2.0
PACKAGE_SOURCE        = https://github.com/jderusse/docker-gitsplit/archive/$(PACKAGE_VERSION).tar.gz
PACKAGE_GO            = github.com/jderusse/gitsplit
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

export GOPATH = $(PACKAGE_BUILD_DIR)/go
export PATH  := $(PATH):/usr/local/go/bin

package.checkout:
	$(call log,Checkout)

	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl $(call verbose,--silent,--silent --show-error, ) --location $(PACKAGE_SOURCE) \
		| bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

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

	mkdir $(call verbose, , ,--verbose) --parents $(GOPATH)/src/github.com/jderusse
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_BUILD_DIR)/$(PACKAGE) $(GOPATH)/src/$(PACKAGE_GO)
	go get $(PACKAGE_GO)
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
