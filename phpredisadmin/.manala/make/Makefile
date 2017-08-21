.PHONY: build

##########
# Manala #
##########

MANALA_DIR = $(abspath $(patsubst %/make/Makefile,%,$(firstword $(filter %manala/make/Makefile,$(MAKEFILE_LIST)))))

include \
	$(MANALA_DIR)/make/Makefile.manala \
	$(MANALA_DIR)/make/Makefile.docker \
	$(MANALA_DIR)/make/Makefile.host \
	$(MANALA_DIR)/make/Makefile.aptly

-include \
	$(MANALA_CURRENT_DIR)/../.env \
	$(MANALA_CURRENT_DIR)/.env

###########
# Package #
###########

PACKAGE_DIR       = $(MANALA_CURRENT_DIR)
PACKAGE_BUILD_DIR = $(PACKAGE_DIR)/build
PACKAGE_DIST_DIR  = $(PACKAGE_DIR)/dist

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
	DISTRIBUTION=$(DISTRIBUTION) \
	DEBFULLNAME=$(MANALA_CONTACT_NAME) \
	DEBEMAIL=$(MANALA_CONTACT_MAIL) \
	DEB_BUILD_OPTIONS=noddebs

######
# Sh #
######

MANALA_HELP += $(call host,local,$(SH_HELP)\n)

SH_HELP = \
	$(call help_section,Build host shell)

sh: .host(local) .if(DISTRIBUTION)
	$(call in,$(DISTRIBUTION),$(PACKAGE_DISTRIBUTIONS), \
		$(call docker_shell), \
		$(call log_warning,Distribution \"$(DISTRIBUTION)\" is not enabled) \
	)

SH_HELP += $(call in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.wheezy, Open shell on build host - Wheezy))
sh.wheezy: DISTRIBUTION = wheezy
sh.wheezy: sh

SH_HELP += $(call in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.jessie, Open shell on build host - Jessie))
sh.jessie: DISTRIBUTION = jessie
sh.jessie: sh

SH_HELP += $(call in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,sh.stretch,Open shell on build host - Stretch))
sh.stretch: DISTRIBUTION = stretch
sh.stretch: sh

##########
# Update #
##########

MANALA_HELP += $(call host,local,$(UPDATE_HELP)\n)

UPDATE_HELP = \
	$(call help_section,Build host update) \
	$(call help,update,        Update build hosts)

update: .host(local)
	$(call for,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(call uniq,$(DISTRIBUTIONS)),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call log,Distribution \"$$(DISTRIBUTION)\"); \
		$$(call in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call docker_pull), \
			$$(call log_warning,Distribution \"$$(DISTRIBUTION)\" is not enabled) \
		) \
	)

UPDATE_HELP += $(call in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,update.wheezy, Update build host - Wheezy))
update.wheezy: DISTRIBUTIONS = wheezy
update.wheezy: update

UPDATE_HELP += $(call in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,update.jessie, Update build host - Jessie))
update.jessie: DISTRIBUTIONS = jessie
update.jessie: update

UPDATE_HELP += $(call in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,update.stretch,Update build host - Stretch))
update.stretch: DISTRIBUTIONS = stretch
update.stretch: update

#########
# Build #
#########

MANALA_HELP += $(call host,local,$(BUILD_HELP)\n)

BUILD_HELP = \
	$(call help_section,Build) \
	$(call help,build,        Build packages)

build: .host(local)
	$(call for,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(call uniq,$(DISTRIBUTIONS)),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call log,Distribution \"$$(DISTRIBUTION)\"); \
		$$(call in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call docker_make,package), \
			$$(call log_warning,Distribution \"$$(DISTRIBUTION)\" is not enabled) \
		) \
	)

BUILD_HELP += $(call in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,build.wheezy, Build packages - Wheezy))
build.wheezy: DISTRIBUTIONS = wheezy
build.wheezy: build

BUILD_HELP += $(call in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,build.jessie, Build packages - Jessie))
build.jessie: DISTRIBUTIONS = jessie
build.jessie: build

BUILD_HELP += $(call in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,build.stretch,Build packages - Stretch))
build.stretch: DISTRIBUTIONS = stretch
build.stretch: build

##########
# System #
##########

MANALA_HELP += $(call host,build,$(SYSTEM_HELP)\n)

SYSTEM_HELP = \
	$(call help_section,System) \
	$(call help,update,Update system)

system.update: DEBIAN_FRONTEND = noninteractive
system.update: .host(build)
	$(call log,Update)
	sudo apt-get update
	sudo apt-get -y dist-upgrade

###########
# Package #
###########

MANALA_HELP += $(call host,build,$(PACKAGE_HELP))

PACKAGE_HELP = \
	$(call help_section,Package) \
	$(call help,package,             Build package)

package: .host(build) \
	system.update \
	package.clean \
	package.checkout \
	package.prepare \
	package.dependencies \
	package.build \
	package.dist

PACKAGE_HELP += $(call help,package.clean,       Build package - Clean)
package.clean: .host(build)
	$(call log,Clean)
	rm -Rf $(PACKAGE_BUILD_DIR)/*
	rm -Rf $(PACKAGE_DIST_DIR)/*~$(DISTRIBUTION)*.deb

PACKAGE_HELP += $(call help,package.checkout,    Build package - Checkout)
package.checkout: .host(build)

PACKAGE_HELP += $(call help,package.prepare,     Build package - Prepare)
package.prepare: .host(build)

PACKAGE_HELP += $(call help,package.dependencies,Build package - Dependencies)
package.dependencies: .host(build)
	$(call log,Dependencies)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& mk-build-deps \
			--install --remove --root-cmd sudo \
			--tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y" \
			debian/control

PACKAGE_HELP += $(call help,package.build,       Build package - Build)
package.build: .host(build)

PACKAGE_HELP += $(call help,package.dist,        Build package - Dist)
package.dist: .host(build)
	$(call log,Dist)
	for DEB in $(PACKAGE_BUILD_DIR)/*.deb; do \
		basename $$DEB; printf "\n"; \
		dpkg -I $$DEB; printf "\n"; \
		dpkg -c $$DEB; printf "\n"; \
		mv $$DEB $(PACKAGE_DIST_DIR); \
	done

##########
# Deploy #
##########

MANALA_APTLY_HOST       = $(DEPLOY_HOST)
MANALA_APTLY_USER       = $(DEPLOY_USER)
MANALA_APTLY_PACKAGES   = $(PACKAGE_DIST_DIR)/*~$(DISTRIBUTION)*.deb
MANALA_APTLY_REPOSITORY = $(DISTRIBUTION)

MANALA_HELP += $(call host,local,$(DEPLOY_HELP))

DEPLOY_HELP = \
	$(call help_section,Deploy) \
	$(call help,deploy,        Deploy packages to repository)

deploy: .host(local) .if(DEPLOY_HOST DEPLOY_USER)
	$(call for,DISTRIBUTION,$(if $(DISTRIBUTIONS),$(call uniq,$(DISTRIBUTIONS)),$(PACKAGE_DISTRIBUTIONS)), \
		$$(call log,Distribution \"$$(DISTRIBUTION)\"); \
		$$(call in,$$(DISTRIBUTION),$$(PACKAGE_DISTRIBUTIONS), \
			$$(call aptly_deploy), \
			$$(call log_warning,Distribution \"$$(DISTRIBUTION)\" is not enabled) \
		) \
	)

DEPLOY_HELP += $(call in,wheezy,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.wheezy, Deploy packages to repository - Wheezy))
deploy.wheezy: DISTRIBUTIONS = wheezy
deploy.wheezy: deploy

DEPLOY_HELP += $(call in,jessie,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.jessie, Deploy packages to repository - Jessie))
deploy.jessie: DISTRIBUTIONS = jessie
deploy.jessie: deploy

DEPLOY_HELP += $(call in,stretch,$(PACKAGE_DISTRIBUTIONS),$(call help,deploy.stretch,Deploy packages to repository - Stretch))
deploy.stretch: DISTRIBUTIONS = stretch
deploy.stretch: deploy
