.PHONY: build

##########
# Debian #
##########

export DEBFULLNAME = Manala
export DEBEMAIL = contact@manala.io

%.wheezy: DEBIAN_DISTRIBUTION = wheezy
%.jessie: DEBIAN_DISTRIBUTION = jessie
%.stretch: DEBIAN_DISTRIBUTION = stretch

define package_debian_version
$(PACKAGE_VERSION)-$(PACKAGE_REVISION)
endef

define package_manala_version
$(call package_debian_version)manala$(PACKAGE_REVISION_MANALA)~$(1)$(PACKAGE_REVISION_MANALA_DISTRIBUTION)
endef

##########
# Docker #
##########

MANALA_DOCKER_IMAGE       = manala/build-debian
MANALA_DOCKER_TAG         = $(if $(DOCKER_TAG),$(DOCKER_TAG)-)$(DEBIAN_DISTRIBUTION)
MANALA_DOCKER_DIR         = /srv
MANALA_DOCKER_HOST        = $(PACKAGE).$(DEBIAN_DISTRIBUTION).build
MANALA_DOCKER_RUN_OPTIONS = \
	--env MANALA_ENV=build \
	--env DEBIAN_DISTRIBUTION=$(DEBIAN_DISTRIBUTION)

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

ifneq ($(filter wheezy,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.wheezy,     Shell to environment - Wheezy)
sh.wheezy:
	@$(MANALA_DOCKER_RUN)
endif

ifneq ($(filter jessie,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.jessie,     Shell to environment - Jessie)
sh.jessie:
	@$(MANALA_DOCKER_RUN)
endif

ifneq ($(filter stretch,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,sh.stretch,    Shell to environment - Stretch)
sh.stretch:
	@$(MANALA_DOCKER_RUN)
endif

MANALA_HELP += $(call help,update-all,    Update all environments)

update-all:
	EXIT=0 ; $(foreach \
		PACKAGE_DISTRIBUTION,\
		$(PACKAGE_DISTRIBUTIONS),\
		$(call log,Update $(PACKAGE_DISTRIBUTION)) \
			&& $(MAKE) update.$(PACKAGE_DISTRIBUTION) \
		|| EXIT=$$? ;\
	) exit $$EXIT

ifneq ($(filter wheezy,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.wheezy, Update environment - Wheezy)
update.wheezy:
	@$(MANALA_DOCKER_PULL)
endif

ifneq ($(filter jessie,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.jessie, Update environment - Jessie)
update.jessie:
	@$(MANALA_DOCKER_PULL)
endif

ifneq ($(filter stretch,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,update.stretch,Update environment - Jessie)
update.stretch:
	@$(MANALA_DOCKER_PULL)
endif

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

ifeq ($(MANALA_ENV),local)

MANALA_HELP += $(call help,build-all,    Build all packages)

build-all:
	EXIT=0 ; $(foreach \
		PACKAGE_DISTRIBUTION,\
		$(PACKAGE_DISTRIBUTIONS),\
		$(call log,Build $(PACKAGE_DISTRIBUTION)) \
			&& $(MAKE) build.$(PACKAGE_DISTRIBUTION) \
		|| EXIT=$$? ;\
	) exit $$EXIT

ifneq ($(filter wheezy,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.wheezy, Build package - Wheezy)
build.wheezy: $(call proxy,build)
endif

ifneq ($(filter jessie,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.jessie, Build package - Jessie)
build.jessie: $(call proxy,build)
endif

ifneq ($(filter stretch,$(PACKAGE_DISTRIBUTIONS)),)
MANALA_HELP += $(call help,build.stretch,Build package - Stretch)
build.stretch: $(call proxy,build)
endif

endif

ifeq ($(MANALA_ENV),build)

MANALA_HELP += $(call help,build,Build package)
build: $(call proxy,build)

endif

build@build: build-package@build build-info@build build-move@build

build-info@build:
	$(call log,Packages informations)
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

build-move@build:
	$(call log,Move builded packages into build directory)
	mkdir -p /srv/build && mv ~/*.deb /srv/build
