.SILENT:

###########
# Package #
###########

PACKAGE               = splitsh-lite
PACKAGE_VERSION       = 1.0.1
PACKAGE_SOURCE        = github.com/splitsh/lite
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

##########
# Manala #
##########

include manala/make/Makefile

#########
# Build #
#########

build-package@build: export GOPATH = $(HOME)/go
build-package@build: export PATH  := $(PATH):/usr/local/go/bin
build-package@build:

	$(call log,Go)
	curl -L https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz \
		| sudo bsdtar -xvf - -C /usr/local

	$(call log,Git2go)
	sudo apt-get update
	sudo apt-get install -y --no-install-recommends cmake pkg-config libssh2-1-dev libssl-dev libcurl4-openssl-dev
	go get -d github.com/libgit2/git2go
	cd $(GOPATH)/src/github.com/libgit2/git2go \
		&& git checkout next \
		&& git submodule update --init \
		&& $(MAKE) install

	$(call log,Checkout)
	go get $(PACKAGE_SOURCE)
	cd $(GOPATH)/src/$(PACKAGE_SOURCE) \
		&& git checkout v$(PACKAGE_VERSION)
	mkdir -p ~/$(PACKAGE)
	go build -o ~/$(PACKAGE)/$(PACKAGE) $(PACKAGE_SOURCE)

	$(call log,Prepare)
	chmod 755 ~/$(PACKAGE)/$(PACKAGE)
	cp -R /srv/debian/$(DEBIAN_DISTRIBUTION) ~/$(PACKAGE)/debian

	$(call log,Build)
	cd ~/$(PACKAGE) \
		&& debuild -us -uc -b
