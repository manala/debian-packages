.PHONY: sh update build lint deploy

##########
# Manala #
##########

MANALA_MAKE_DIR := $(abspath $(patsubst %/Makefile,%,$(lastword $(MAKEFILE_LIST))))

include \
	$(MANALA_MAKE_DIR)/Makefile.manala \
	$(MANALA_MAKE_DIR)/Makefile.docker \
	$(MANALA_MAKE_DIR)/Makefile.host \
	$(MANALA_MAKE_DIR)/Makefile.aptly

-include \
	$(MANALA_CURRENT_DIR)/../.env \
	$(MANALA_CURRENT_DIR)/.env

MANALA_VERBOSE := $(if $(VERBOSE),$(VERBOSE),$(MANALA_VERBOSE))

###########
# Package #
###########

PACKAGE_DIR      := $(MANALA_CURRENT_DIR)
PACKAGE_BUILD_DIR = $(PACKAGE_DIR)/build/$(DISTRIBUTION)
PACKAGE_DIST_DIR  = $(PACKAGE_DIR)/dist/$(DISTRIBUTION)

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
MANALA_DOCKER_VOLUMES   = \
	$(if $(CACHE_DIR), \
		$(CACHE_DIR)/$(DISTRIBUTION)/apt/archives:/var/cache/apt/archives \
		$(CACHE_DIR)/$(DISTRIBUTION)/apt/lists:/var/lib/apt/lists \
	)
MANALA_DOCKER_ENV       = \
	USER_ID=$(MANALA_USER_ID) \
	GROUP_ID=$(MANALA_GROUP_ID) \
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

sh: .fail_if_host_not(local)
	$(call fail_if_not,$(DISTRIBUTION),DISTRIBUTION is empty or not set)
	$(call if_in,$(DISTRIBUTION),$(PACKAGE_DISTRIBUTIONS), \
		$(call docker_shell), \
		$(call log_warning,Shell on \"$(DISTRIBUTION)\" is not supported) \
	)

SH_HELP += $(call if_in,buster,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.buster.amd64,Open shell on build host - buster))
sh.buster.amd64: DISTRIBUTION = buster
sh.buster.amd64: ARCHITECTURE = linux/amd64
sh.buster.amd64: sh

SH_HELP += $(call if_in,bullseye,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.bullseye.amd64,Open shell on build host - bullseye))
sh.bullseye.amd64: DISTRIBUTION = bullseye
sh.bullseye.amd64: ARCHITECTURE = linux/amd64
sh.bullseye.amd64: sh

SH_HELP += $(call if_in,bookworm,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.bookworm.arm64,Open shell on build host - bookworm))
sh.bookworm.amd64: DISTRIBUTION = bookworm
sh.bookworm.amd64: ARCHITECTURE = linux/amd64
sh.bookworm.amd64: sh

SH_HELP += $(call if_in,buster,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.buster.arm64,Open shell on build host - buster))
sh.buster.arm64: DISTRIBUTION = buster
sh.buster.arm64: ARCHITECTURE = linux/arm64
sh.buster.arm64: sh

SH_HELP += $(call if_in,bullseye,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.bullseye.arm64,Open shell on build host - bullseye))
sh.bullseye.arm64: DISTRIBUTION = bullseye
sh.bullseye.arm64: ARCHITECTURE = linux/arm64
sh.bullseye.arm64: sh

SH_HELP += $(call if_in,bookworm,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.bookworm.arm64,Open shell on build host - bookworm))
sh.bookworm.arm64: DISTRIBUTION = bookworm
sh.bookworm.arm64: ARCHITECTURE = linux/arm64
sh.bookworm.arm64: sh

##########
# Update #
##########

MANALA_HELP += $(call if_host,local,$(UPDATE_HELP)\n)

UPDATE_HELP = \
	$(call help_section,Build host update) \
	$(call help,update,        Update build hosts across distributions)

update: .fail_if_host_not(local)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(DISTRIBUTIONS),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call log,Update \"$$(DISTRIBUTION)\") ; \
				$$(call docker_pull), \
			$$(call log_warning,Update \"$$(DISTRIBUTION)\" is not supported) \
		) \
	)

UPDATE_HELP += $(call if_in,buster,$(PACKAGE_DISTRIBUTIONS),$(call help,update.buster,Update build host - buster))
update.buster: DISTRIBUTIONS = buster
update.buster: update

UPDATE_HELP += $(call if_in,bullseye,$(PACKAGE_DISTRIBUTIONS),$(call help,update.bullseye,Update build host - bullseye))
update.bullseye: DISTRIBUTIONS = bullseye
update.bullseye: update

UPDATE_HELP += $(call if_in,bookworm,$(PACKAGE_DISTRIBUTIONS),$(call help,update.bookworm,Update build host - Stretch))
update.bookworm: DISTRIBUTIONS = bookworm
update.bookworm: update

##########
# System #
##########

MANALA_HELP += $(call if_host,build,$(SYSTEM_HELP)\n)

SYSTEM_HELP = \
	$(call help_section,System) \
	$(call help,system.update,Update system)

system.update: DEBIAN_FRONTEND = noninteractive
system.update: .fail_if_host_not(build)
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

build@local: .fail_if_host_not(local)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(DISTRIBUTIONS),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call log,Build \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\") ; \
				$$(call docker_make,build@build), \
			$$(call log_warning,Build \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\" is not supported) \
		) \
	)

build@build: .fail_if_host_not(build) \
	system.update \
	package.clean \
	package.checkout \
	package.prepare \
	package.patch \
	package.dependencies \
	package.build \
	package.dist

BUILD_HELP_LOCAL += $(call if_in,buster,$(PACKAGE_DISTRIBUTIONS),$(call help,build.buster,Build package - buster))
build.buster: DISTRIBUTIONS = buster
build.buster: build@local

BUILD_HELP_LOCAL += $(call if_in,bullseye,$(PACKAGE_DISTRIBUTIONS),$(call help,build.bullseye,Build package - bullseye))
build.bullseye: DISTRIBUTIONS = bullseye
build.bullseye: build@local

BUILD_HELP_LOCAL += $(call if_in,bookworm,$(PACKAGE_DISTRIBUTIONS),$(call help,build.bookworm,Build package - Stretch))
build.bookworm: DISTRIBUTIONS = bookworm
build.bookworm: build@local

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

lint@local: .fail_if_host_not(local)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(DISTRIBUTIONS),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call log,Lint \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\") ; \
				$$(call docker_make,lint@build), \
			$$(call log_warning,Lint \"$$(PACKAGE)\" on \"$$(DISTRIBUTION)\" is not supported) \
		) \
	)

lint@build: .fail_if_host_not(build)
	$(foreach PACKAGE,$(wildcard $(PACKAGE_DIST_DIR)/*.deb), \
		$(call verbose, ,basename $(PACKAGE) ; echo ; ) \
		lintian $(call verbose, , , ,--info) $(PACKAGE) || true ; \
	)

LINT_HELP_LOCAL += $(call if_in,buster,$(PACKAGE_DISTRIBUTIONS),$(call help,lint.buster,Lint package - buster))
lint.buster: DISTRIBUTIONS = buster
lint.buster: lint@local

LINT_HELP_LOCAL += $(call if_in,bullseye,$(PACKAGE_DISTRIBUTIONS),$(call help,lint.bullseye,Lint package - bullseye))
lint.bullseye: DISTRIBUTIONS = bullseye
lint.bullseye: lint@local

LINT_HELP_LOCAL += $(call if_in,bookworm,$(PACKAGE_DISTRIBUTIONS),$(call help,lint.bookworm,Lint package - Stretch))
lint.bookworm: DISTRIBUTIONS = bookworm
lint.bookworm: lint@local

###########
# Package #
###########

MANALA_HELP += $(call if_host,build,$(PACKAGE_HELP))

PACKAGE_HELP = $(call help_section,Package)

PACKAGE_HELP += $(call help,package.clean,       Package - Clean)
package.clean: .fail_if_host_not(build)
	$(call log,Clean)
	rm $(call verbose, , ,--verbose) --recursive --force \
		$(PACKAGE_BUILD_DIR)/* $(PACKAGE_DIST_DIR)/*.deb

PACKAGE_HELP += $(call help,package.checkout,    Package - Checkout)
package.checkout: .fail_if_host_not(build)

PACKAGE_HELP += $(call help,package.prepare,     Package - Prepare)
package.prepare: .fail_if_host_not(build)

# Create a patch (in build/[distribution] directory):
#   $ diff -Naur [file] [file].patch > ../../patches/[distribution]/XXX.[name].patch
PACKAGE_HELP += $(call help,package.patch,       Package - Patch)
package.patch: PATCHES = $(sort $(wildcard $(PACKAGE_DIR)/patches/$(DISTRIBUTION)/*.patch))
package.patch: .fail_if_host_not(build)
	$(call log,Patch)
	$(foreach PATCH,$(PATCHES), \
		cd $(PACKAGE_BUILD_DIR) && \
		patch $(call verbose,--quiet,--quiet,--verbose) --strip=0 < $(PATCH) ; \
	)

PACKAGE_HELP += $(call help,package.dependencies,Package - Dependencies)
package.dependencies: .fail_if_host_not(build)
	$(call log,Dependencies)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control $(call verbose,>/dev/null 2>&1,>/dev/null, )

PACKAGE_HELP += $(call help,package.build,       Package - Build)
package.build: .fail_if_host_not(build)

PACKAGE_HELP += $(call help,package.dist,        Package - Dist)
package.dist: .fail_if_host_not(build)
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

deploy: .fail_if_host_not(local)
	$(call fail_if_not,$(DEPLOY_HOST),DEPLOY_HOST is empty or not set)
	$(call fail_if_not,$(DEPLOY_USER),DEPLOY_USER is empty or not set)
	$(call list_loop,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(DISTRIBUTIONS),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call log,Distribution \"$$(DISTRIBUTION)\") ; \
		$$(call if_in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call confirm,Please confirm deploy on \"$$(DISTRIBUTION)\" distribution) ; \
			$$(call aptly_deploy), \
			$$(call log_error,Distribution \"$$(DISTRIBUTION)\" is not available) ; exit 1 \
		) \
	)

DEPLOY_HELP += $(call if_in,buster,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.buster,Deploy package to repository - buster))
deploy.buster: DISTRIBUTIONS = buster
deploy.buster: deploy

DEPLOY_HELP += $(call if_in,bullseye,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.bullseye,Deploy package to repository - bullseye))
deploy.bullseye: DISTRIBUTIONS = bullseye
deploy.bullseye: deploy

DEPLOY_HELP += $(call if_in,bookworm,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.bookworm,Deploy package to repository - Stretch))
deploy.bookworm: DISTRIBUTIONS = bookworm
deploy.bookworm: deploy
