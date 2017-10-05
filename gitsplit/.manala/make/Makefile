.PHONY: sh update build lint deploy

##########
# Manala #
##########

MANALA_DIR := $(abspath $(patsubst %/make/Makefile,%,$(firstword $(filter %.manala/make/Makefile,$(MAKEFILE_LIST)))))

include \
	$(MANALA_DIR)/make/Makefile.manala \
	$(MANALA_DIR)/make/Makefile.docker \
	$(MANALA_DIR)/make/Makefile.host \
	$(MANALA_DIR)/make/Makefile.aptly

-include \
	$(MANALA_CURRENT_DIR)/../.env \
	$(MANALA_CURRENT_DIR)/.env

MANALA_VERBOSE := $(if $(VERBOSE),$(VERBOSE),$(MANALA_VERBOSE))

###########
# Package #
###########

PACKAGE_DIR       := $(MANALA_CURRENT_DIR)
PACKAGE_BUILD_DIR := $(PACKAGE_DIR)/build/$(DISTRIBUTION)
PACKAGE_DIST_DIR  := $(PACKAGE_DIR)/dist/$(DISTRIBUTION)

##########
# Debian #
##########

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

# Note: "DEB_BUILD_OPTIONS=noddebs" to get rid of dbgsym packages

MANALA_DOCKER_IMAGE     = manala/build-debian
MANALA_DOCKER_IMAGE_TAG = $(if $(DOCKER_TAG),$(DOCKER_TAG)-)$(DISTRIBUTION)
MANALA_DOCKER_DIR       = /srv/package
MANALA_DOCKER_HOST      = $(PACKAGE).$(DISTRIBUTION).build
MANALA_DOCKER_ENV       = \
	MANALA_HOST=build \
	MANALA_VERBOSE=$(MANALA_VERBOSE) \
	DISTRIBUTION=$(DISTRIBUTION) \
	DEBFULLNAME=$(MANALA_CONTACT_NAME) \
	DEBEMAIL=$(MANALA_CONTACT_MAIL) \
	DEB_BUILD_OPTIONS=noddebs

######
# Sh #
######

MANALA_HELP += $(call if_host,local,$(SH_HELP)\n)

SH_HELP = \
	$(call help_section,Build host shell)

sh: .host_restrict(local)
	$(call fail_unless,DISTRIBUTION)
	$(call if_in,$(DISTRIBUTION),$(PACKAGE_DISTRIBUTIONS), \
		$(call docker_shell), \
		$(call log_warning,Shell on \"$(DISTRIBUTION)\" is not supported) \
	)

SH_HELP += $(call if_in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.wheezy, Open shell on build host - Wheezy))
sh.wheezy: DISTRIBUTION = wheezy
sh.wheezy: sh

SH_HELP += $(call if_in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.jessie, Open shell on build host - Jessie))
sh.jessie: DISTRIBUTION = jessie
sh.jessie: sh

SH_HELP += $(call if_in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.stretch,Open shell on build host - Stretch))
sh.stretch: DISTRIBUTION = stretch
sh.stretch: sh

##########
# Update #
##########

MANALA_HELP += $(call if_host,local,$(UPDATE_HELP)\n)

UPDATE_HELP = \
	$(call help_section,Build host update) \
	$(call help,update,        Update build hosts across distributions)

update: .host_restrict(local)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(DISTRIBUTIONS),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call log,Update \"$$(DISTRIBUTION)\") ; \
				$$(call docker_pull), \
			$$(call log_warning,Update \"$$(DISTRIBUTION)\" is not supported) \
		) \
	)

UPDATE_HELP += $(call if_in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,update.wheezy, Update build host - Wheezy))
update.wheezy: DISTRIBUTIONS = wheezy
update.wheezy: update

UPDATE_HELP += $(call if_in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,update.jessie, Update build host - Jessie))
update.jessie: DISTRIBUTIONS = jessie
update.jessie: update

UPDATE_HELP += $(call if_in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,update.stretch,Update build host - Stretch))
update.stretch: DISTRIBUTIONS = stretch
update.stretch: update

##########
# System #
##########

MANALA_HELP += $(call if_host,build,$(SYSTEM_HELP)\n)

SYSTEM_HELP = \
	$(call help_section,System) \
	$(call help,system.update,Update system)

system.update: DEBIAN_FRONTEND = noninteractive
system.update: .host_restrict(build)
	$(call log,Update)
	sudo apt-get $(call verbose,-qq,-qq, ) update
	sudo apt-get $(call verbose,-qq,-q -V,-V) -y dist-upgrade

#########
# Build #
#########

MANALA_HELP += $(call if_host,local,$(BUILD_HELP_LOCAL)\n,$(BUILD_HELP_BUILD)\n)

BUILD_HELP       = $(call help_section,Build)
BUILD_HELP_LOCAL = $(BUILD_HELP) \
	$(call help,build,        Build packages across distributions)
BUILD_HELP_BUILD = $(BUILD_HELP) \
	$(call help,build,Build package)

build: .host_switch(build)

build@local: .host_restrict(local)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(call uniq,$(DISTRIBUTIONS)),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call log,Build \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\") ; \
				$$(call docker_make,build@build), \
			$$(call log_warning,Build \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\" is not supported) \
		) \
	)

build@build: .host_restrict(build) \
	system.update \
	package.clean \
	package.checkout \
	package.prepare \
	package.patch \
	package.dependencies \
	package.build \
	package.dist

BUILD_HELP_LOCAL += $(call if_in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,build.wheezy, Build package - Wheezy))
build.wheezy: DISTRIBUTIONS = wheezy
build.wheezy: build@local

BUILD_HELP_LOCAL += $(call if_in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,build.jessie, Build package - Jessie))
build.jessie: DISTRIBUTIONS = jessie
build.jessie: build@local

BUILD_HELP_LOCAL += $(call if_in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,build.stretch,Build package - Stretch))
build.stretch: DISTRIBUTIONS = stretch
build.stretch: build@local

########
# Lint #
########

MANALA_HELP += $(call if_host,local,$(LINT_HELP_LOCAL)\n,$(LINT_HELP_BUILD)\n)

LINT_HELP       = $(call help_section,Lint)
LINT_HELP_LOCAL = $(LINT_HELP) \
	$(call help,lint,        Lint packages across distributions)
LINT_HELP_BUILD = $(LINT_HELP) \
	$(call help,lint,Lint package)

lint: .host_switch(lint)

lint@local: .host_restrict(local)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(call uniq,$(DISTRIBUTIONS)),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call log,Lint \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\") ; \
				$$(call docker_make,lint@build), \
			$$(call log_warning,Lint \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\" is not supported) \
		) \
	)

lint@build: .host_restrict(build)
	$(foreach PACKAGE,$(wildcard $(PACKAGE_DIST_DIR)/*.deb), \
		$(call verbose, ,basename $(PACKAGE) ; echo ; ) \
		lintian $(call verbose, , , ,--info) $(PACKAGE) || true ; \
	)

LINT_HELP_LOCAL += $(call if_in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,lint.wheezy, Lint package - Wheezy))
lint.wheezy: DISTRIBUTIONS = wheezy
lint.wheezy: lint@local

LINT_HELP_LOCAL += $(call if_in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,lint.jessie, Lint package - Jessie))
lint.jessie: DISTRIBUTIONS = jessie
lint.jessie: lint@local

LINT_HELP_LOCAL += $(call if_in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,lint.stretch,Lint package - Stretch))
lint.stretch: DISTRIBUTIONS = stretch
lint.stretch: lint@local

###########
# Package #
###########

MANALA_HELP += $(call if_host,build,$(PACKAGE_HELP))

PACKAGE_HELP = $(call help_section,Package)

PACKAGE_HELP += $(call help,package.clean,       Package - Clean)
package.clean: .host_restrict(build)
	$(call log,Clean)
	rm $(call verbose, , ,--verbose) --recursive --force \
		$(PACKAGE_BUILD_DIR)/* $(PACKAGE_DIST_DIR)/*.deb

PACKAGE_HELP += $(call help,package.checkout,    Package - Checkout)
package.checkout: .host_restrict(build)

PACKAGE_HELP += $(call help,package.prepare,     Package - Prepare)
package.prepare: .host_restrict(build)

# Create a patch (in build directory):
#   $ diff -Naur [file] [file].patch > ../patches/[distribution]/XXX.[name].patch
PACKAGE_HELP += $(call help,package.patch,       Package - Patch)
package.patch: PATCHES = $(sort $(wildcard $(PACKAGE_DIR)/patches/$(DISTRIBUTION)/*.patch))
package.patch: .host_restrict(build)
	$(call log,Patch)
	$(foreach PATCH,$(PATCHES), \
		cd $(PACKAGE_BUILD_DIR) && \
		patch $(call verbose,--quiet,--quiet,--verbose) --strip=0 < $(PATCH) ; \
	)

PACKAGE_HELP += $(call help,package.dependencies,Package - Dependencies)
package.dependencies: .host_restrict(build)
	$(call log,Dependencies)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control $(call verbose,>/dev/null 2>&1,>/dev/null, )

PACKAGE_HELP += $(call help,package.build,       Package - Build)
package.build: .host_restrict(build)

PACKAGE_HELP += $(call help,package.dist,        Package - Dist)
package.dist: .host_restrict(build)
	$(call log,Dist)
	mkdir $(call verbose, , ,--verbose) --parents $(PACKAGE_DIST_DIR)
	$(foreach PACKAGE,$(wildcard $(PACKAGE_BUILD_DIR)/*.deb), \
		$(call verbose, ,basename $(PACKAGE) ; echo ; ) \
		$(call verbose, , , \
			dpkg --info $(PACKAGE) ; echo ; \
			dpkg --contents $(PACKAGE) ; echo ; \
		) \
		mv $(call verbose, , ,--verbose) $(PACKAGE) $(PACKAGE_DIST_DIR) ; \
	)

##########
# Deploy #
##########

MANALA_APTLY_HOST       = $(DEPLOY_HOST)
MANALA_APTLY_USER       = $(DEPLOY_USER)
MANALA_APTLY_PACKAGES   = $(PACKAGE_DIST_DIR)/*.deb
MANALA_APTLY_REPOSITORY = $(DISTRIBUTION)

MANALA_HELP += $(call if_host,local,$(DEPLOY_HELP))

DEPLOY_HELP = \
	$(call help_section,Deploy) \
	$(call help,deploy,        Deploy packages to repository across distributions)

deploy: .host_restrict(local)
	$(call fail_unless,DEPLOY_HOST)
	$(call fail_unless,DEPLOY_USER)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(call uniq,$(DISTRIBUTIONS)),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call log,Distribution \"$$(DISTRIBUTION)\") ; \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call confirm,Please confirm deploy on \"$$(DISTRIBUTION)\" distribution) ; \
			$$(call aptly_deploy), \
			$$(call log_error,Distribution \"$$(DISTRIBUTION)\" is not available) ; exit 1 \
		) \
	)

DEPLOY_HELP += $(call if_in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.wheezy, Deploy package to repository - Wheezy))
deploy.wheezy: DISTRIBUTIONS = wheezy
deploy.wheezy: deploy

DEPLOY_HELP += $(call if_in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.jessie, Deploy package to repository - Jessie))
deploy.jessie: DISTRIBUTIONS = jessie
deploy.jessie: deploy

DEPLOY_HELP += $(call if_in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.stretch,Deploy package to repository - Stretch))
deploy.stretch: DISTRIBUTIONS = stretch
deploy.stretch: deploy
