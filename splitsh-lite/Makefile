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
PACKAGE_SOURCE        = github.com/splitsh/lite
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

export GOPATH = $(PACKAGE_BUILD_DIR)/go
export PATH  := $(PATH):/usr/local/go/bin

package.checkout:
	$(call log,Checkout)

	# Go
	curl -L https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz \
		| sudo bsdtar -xvf - -C /usr/local

	# Git2go
	sudo apt-get install -y --no-install-recommends \
		cmake pkg-config libssh2-1-dev libssl-dev libcurl4-openssl-dev
	# Git clone manually as a temporary workaround to libgit2 install issue
	# See: https://github.com/libgit2/rugged/issues/711
	mkdir -p $(PACKAGE_BUILD_DIR)/go/src/github.com/libgit2 \
		&& cd $(PACKAGE_BUILD_DIR)/go/src/github.com/libgit2 \
		&& git clone https://github.com/libgit2/git2go.git
	cd $(GOPATH)/src/github.com/libgit2/git2go \
		&& git checkout next \
		&& git submodule update --init \
		&& $(MAKE) install

	go get $(PACKAGE_SOURCE)
	cd $(GOPATH)/src/$(PACKAGE_SOURCE) \
		&& git checkout v$(PACKAGE_VERSION)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	go build -o $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE) $(PACKAGE_SOURCE)

package.prepare:
	$(call log,Prepare)
	chmod 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp -R $(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
