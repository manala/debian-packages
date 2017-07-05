.PHONY: build

###########
# Package #
###########

PACKAGE_DIR       = /srv/package
PACKAGE_BUILD_DIR = $(PACKAGE_DIR)/build
PACKAGE_DIST_DIR  = $(PACKAGE_DIR)/dist

##########
# Debian #
##########

DEBIAN_DISTRIBUTIONS = $(PACKAGE_DISTRIBUTIONS)

%.wheezy: DEBIAN_DISTRIBUTION = wheezy
%.jessie: DEBIAN_DISTRIBUTION = jessie
%.stretch: DEBIAN_DISTRIBUTION = stretch

export DEBFULLNAME = Manala
export DEBEMAIL = contact@manala.io

define package_debian_version
$(if $(PACKAGE_EPOCH),$(PACKAGE_EPOCH):)$(PACKAGE_VERSION)-$(PACKAGE_REVISION)
endef

define package_debian_file
$(PACKAGE_VERSION)-$(PACKAGE_REVISION)
endef

define package_manala_version
$(call package_debian_version)manala$(PACKAGE_REVISION_MANALA)~$(1)$(PACKAGE_REVISION_MANALA_DISTRIBUTION)
endef

##########
# Docker #
##########

MANALA_DOCKER_IMAGE     = manala/build-debian
MANALA_DOCKER_IMAGE_TAG = $(if $(DOCKER_IMAGE_TAG),$(DOCKER_IMAGE_TAG)-)$(DEBIAN_DISTRIBUTION)
MANALA_DOCKER_DIR       = $(PACKAGE_DIR)
MANALA_DOCKER_HOST      = $(PACKAGE).$(DEBIAN_DISTRIBUTION).build
MANALA_DOCKER_ENV       = \
	MANALA_ENV=build \
	DEBIAN_DISTRIBUTION=$(DEBIAN_DISTRIBUTION)

##########
# Manala #
##########

MANALA_DIR = $(abspath $(patsubst %/make/Makefile,%,$(firstword $(filter %manala/make/Makefile,$(MAKEFILE_LIST)))))

include \
	$(MANALA_DIR)/make/Makefile.manala \
	$(MANALA_DIR)/make/Makefile.docker \
	$(MANALA_DIR)/make/Makefile.environment

-include $(MANALA_DIR)/../Makefile.local

###############
# Environment #
###############

ifeq ($(MANALA_ENV),local)

MANALA_HELP += $(call help_section,Environment)

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.wheezy,     Shell to environment - Wheezy)
sh.wheezy:
	@$(MANALA_DOCKER_RUN)
endif

ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.jessie,     Shell to environment - Jessie)
sh.jessie:
	@$(MANALA_DOCKER_RUN)
endif

ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.stretch,    Shell to environment - Stretch)
sh.stretch:
	@$(MANALA_DOCKER_RUN)
endif

sh.%:
	$(call log_warning,Debian distribution \"$(*)\" is not enabled.)

MANALA_HELP += $(call help,update-all,    Update all environments)

update-all:
	EXIT=0 ; $(foreach \
		DEBIAN_DISTRIBUTION,\
		$(DEBIAN_DISTRIBUTIONS),\
		$(call log,Update $(DEBIAN_DISTRIBUTION)) \
			&& $(MAKE) update.$(DEBIAN_DISTRIBUTION) \
		|| EXIT=$$? ;\
	) exit $$EXIT

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.wheezy, Update environment - Wheezy)
update.wheezy:
	@$(MANALA_DOCKER_PULL)
endif

ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.jessie, Update environment - Jessie)
update.jessie:
	@$(MANALA_DOCKER_PULL)
endif

ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.stretch,Update environment - Jessie)
update.stretch:
	@$(MANALA_DOCKER_PULL)
endif

update.%:
	$(call log_warning,Debian distribution \"$(*)\" is not enabled.)

MANALA_HELP += \n

endif

#########
# Proxy #
#########

%@proxy:
	@$(MANALA_DOCKER_RUN) sh -c "make --silent --directory=$(MANALA_DOCKER_DIR) $(*)"

###########
# Package #
###########

MANALA_HELP += $(call help_section,Package)

###################
# Package - Build #
###################

ifeq ($(MANALA_ENV),local)

MANALA_HELP += $(call help,build-all,    Build all packages)

build-all:
	EXIT=0 ; $(foreach \
		DEBIAN_DISTRIBUTION,\
		$(DEBIAN_DISTRIBUTIONS),\
		$(call log,Build $(DEBIAN_DISTRIBUTION)) \
			&& $(MAKE) build.$(DEBIAN_DISTRIBUTION) \
		|| EXIT=$$? ;\
	) exit $$EXIT

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.wheezy, Build package - Wheezy)
build.wheezy: $(call proxy,build) ;
endif

ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.jessie, Build package - Jessie)
build.jessie: $(call proxy,build) ;
endif

ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.stretch,Build package - Stretch)
build.stretch: $(call proxy,build) ;
endif

build.%:
	$(call log_warning,Debian distribution \"$(*)\" is not enabled.)

endif

ifeq ($(MANALA_ENV),build)

MANALA_HELP += $(call help,build,Build package)
build: $(call proxy,build)

endif

build@build: build-clean@build build-package@build build-dist@build

build-clean@build:
	rm -Rf $(PACKAGE_BUILD_DIR)/*

build-dist@build:
	$(call log,Dist)
	for DEB in $(PACKAGE_BUILD_DIR)/*.deb; do \
		basename $$DEB; printf "\n"; \
		dpkg -I $$DEB; printf "\n"; \
		dpkg -c $$DEB; printf "\n"; \
		mv $$DEB $(PACKAGE_DIST_DIR); \
	done
