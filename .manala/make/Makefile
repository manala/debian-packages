.PHONY: build

##########
# Manala #
##########

MANALA_DIR = $(abspath $(patsubst %/make/Makefile,%,$(firstword $(filter %.manala/make/Makefile,$(MAKEFILE_LIST)))))

include \
	$(MANALA_DIR)/make/Makefile.manala \
	$(MANALA_DIR)/make/Makefile.travis \
	$(MANALA_DIR)/make/Makefile.gitsplit

-include \
	$(MANALA_CURRENT_DIR)/.env

MANALA_VERBOSE := $(if $(VERBOSE),$(VERBOSE),$(MANALA_VERBOSE))

############
# Packages #
############

PACKAGES_ALL  = $(sort $(notdir $(patsubst %/,%,$(dir $(wildcard $(MANALA_CURRENT_DIR)/*/)))))
PACKAGES_DIFF = $(filter-out .manala,$(sort $(shell git diff --name-only $(TRAVIS_COMMIT_RANGE)| grep "/" | cut -d/ -f1)))

#########
# Build #
#########

MANALA_HELP += $(BUILD_HELP)\n

BUILD_HELP = \
	$(call help_section,Build) \
	$(call help,build,     Build packages)

build:
	$(call for,PACKAGE,$(if $(PACKAGES),$(call uniq,$(PACKAGES)),$(PACKAGES_ALL)), \
		$$(call log,Package \"$$(PACKAGE)\") ; \
		$$(call in,$$(PACKAGE),$$(PACKAGES_ALL), \
			$$(MAKE) --silent --directory=$$(PACKAGE) build, \
			$$(call log_warning,Package \"$$(PACKAGE)\" is not available) \
		) \
	)

BUILD_HELP += $(call help,build.diff,Build packages - Diff)
build.diff: PACKAGES = $(PACKAGES_DIFF)
build.diff: build

#########
# Split #
#########

MANALA_HELP += $(SPLIT_HELP)\n

SPLIT_HELP = \
	$(call help_section,Split) \
	$(call help,split,Split git repositories)

split:
	$(call gitsplit)

########
# Sync #
########

MANALA_HELP += $(SYNC_HELP)

SYNC_HELP = \
	$(call help_section,Sync) \
	$(call help,sync,Sync packages)

sync: .if(FROM)
	$(call confirm,Please confirm sync from \"$(FROM)\" debian package)
	for PACKAGE in */; do \
		echo $$PACKAGE; \
		cp $$FROM/.gitignore $$PACKAGE; \
		cp $$FROM/.travis.yml $$PACKAGE; \
		cp -r $$FROM/.manala $$PACKAGE; \
	done
