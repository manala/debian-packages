.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = audiowaveform
PACKAGE_VERSION       = 1.4.1
PACKAGE_SOURCE        = https://github.com/bbc/audiowaveform.git
PACKAGE_DISTRIBUTIONS = jessie stretch buster

export LANG   = C.UTF-8

package.checkout:
	$(call log,Checkout)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_BUILD_DIR)/$(PACKAGE) && \
	git clone $(PACKAGE_SOURCE) $(PACKAGE_BUILD_DIR)/$(PACKAGE) \

	#Googletest framework
	curl $(call verbose,--silent,--silent --show-error, ) --location https://github.com/google/googletest/archive/release-1.10.0.tar.gz \
		| sudo bsdtar $(call verbose, , ,-v) -xf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) && \
	ln -s $(PACKAGE_BUILD_DIR)/$(PACKAGE)/googletest-release-1.10.0/googletest $(PACKAGE_BUILD_DIR)/$(PACKAGE)/googletest && \
	ln -s $(PACKAGE_BUILD_DIR)/$(PACKAGE)/googletest-release-1.10.0/googlemock $(PACKAGE_BUILD_DIR)/$(PACKAGE)/googlemock #&& \
	#cp ./debian/$(DISTRIBUTION)/control $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian/control

package.prepare:
	$(call log,Prepare)
	cp $(call verbose, , ,--verbose) --no-target-directory --recursive \
		$(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild --no-lintian -us -uc -b $(call verbose,>/dev/null 2>&1,>/dev/null, )
