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

%.wheezy:  DEBIAN_DISTRIBUTION = wheezy
%.jessie:  DEBIAN_DISTRIBUTION = jessie
%.stretch: DEBIAN_DISTRIBUTION = stretch

export DEBFULLNAME = Manala
export DEBEMAIL    = contact@manala.io

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

-include \
	../Makefile.local \
	Makefile.local

###############
# Environment #
###############

ifndef MANALA_ENV

MANALA_HELP += $(call help_section,Environment)

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.wheezy,     Shell to build environment - Wheezy)
endif
ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.jessie,     Shell to build environment - Jessie)
endif
ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.stretch,    Shell to build environment - Stretch)
endif

MANALA_HELP += $(call help,update-all,    Update all build environments)

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.wheezy, Update build environment - Wheezy)
endif
ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.jessie, Update build environment - Jessie)
endif
ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.stretch,Update build environment - Jessie)
endif

MANALA_HELP += \n

endif

sh.wheezy: @@local
ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
	@$(call docker_shell)
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

sh.jessie: @@local
ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
	@$(call docker_shell)
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

sh.stretch: @@local
ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
	@$(call docker_shell)
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

update-all: @@local
	$(call loop,$(DEBIAN_DISTRIBUTIONS), \
		$(MAKE) update.$$(ITEM), \
		Update debian distribution \"$$(ITEM)\" \
	)

update.wheezy: @@local
ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
	@$(call docker_pull)
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

update.jessie: @@local
ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
	@$(call docker_pull)
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

update.stretch: @@local
ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
	@$(call docker_pull)
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

#########
# Proxy #
#########

ifeq ($(MANALA_ENV),build)
@@build: ;
%@@build: % ;
else
@@build:
	@$(call log_error,Must be run in \"build\" environment)
	@exit 1
%@@build:
	$(call docker_proxy,$(*))
endif

#########
# Build #
#########

MANALA_HELP += $(call help_section,Build)

ifndef MANALA_ENV

MANALA_HELP += $(call help,build-all,    Build all packages)

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.wheezy, Build package - Wheezy)
endif
ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.jessie, Build package - Jessie)
endif
ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.stretch,Build package - Stretch)
endif

endif

build-all: @@local
	$(call loop,$(DEBIAN_DISTRIBUTIONS), \
		$(MAKE) build.$$(ITEM), \
		Build debian distribution \"$$(ITEM)\" \
	)

build.wheezy: @@local
ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTIONS)),)
build.wheezy: build@@build
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

build.jessie: @@local
ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTIONS)),)
build.jessie: build@@build
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

build.stretch: @@local
ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTIONS)),)
build.stretch: build@@build
else
	@$(call log_warning,Debian distribution \"$(DEBIAN_DISTRIBUTION)\" is not enabled.)
endif

ifeq ($(MANALA_ENV),build)

MANALA_HELP += $(call help,build,Build package)

endif

MANALA_HELP += \n

define build_clean
	@$(call log,Clean)
	@rm -Rf $(PACKAGE_BUILD_DIR)/*
	@rm -Rf $(PACKAGE_DIST_DIR)/*~$(DEBIAN_DISTRIBUTION)*.deb
endef

define build_dist
	@$(call log,Dist)
	@for DEB in $(PACKAGE_BUILD_DIR)/*.deb; do \
		basename $$DEB; printf "\n"; \
		dpkg -I $$DEB; printf "\n"; \
		dpkg -c $$DEB; printf "\n"; \
		mv $$DEB $(PACKAGE_DIST_DIR); \
	done
endef

build: @@build
