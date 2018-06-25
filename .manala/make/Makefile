.PHONY: build lint split sync

##########
# Manala #
##########

MANALA_MAKE_DIR := $(abspath $(patsubst %/Makefile,%,$(lastword $(MAKEFILE_LIST))))

include \
	$(MANALA_MAKE_DIR)/Makefile.manala \
	$(MANALA_MAKE_DIR)/Makefile.travis \
	$(MANALA_MAKE_DIR)/Makefile.gitsplit

-include \
	$(MANALA_CURRENT_DIR)/.env

MANALA_VERBOSE := $(if $(VERBOSE),$(VERBOSE),$(MANALA_VERBOSE))

############
# Packages #
############

PACKAGES_ALL  = $(filter-out $(PACKAGES_DEPRECATED),$(sort $(patsubst %/,%,$(wildcard */))))
PACKAGES_DIFF = $(filter-out $(PACKAGES_DEPRECATED) .manala,$(sort $(shell git diff --name-only $(TRAVIS_COMMIT_RANGE)| grep "/" | cut -d/ -f1)))

#############
# Partition #
#############

PART ?= 1/1

PARTITION_PART  := $(call list_split_first,/,$(PART))
PARTITION_PARTS := $(call list_split_last,/,$(PART))

#########
# Build #
#########

MANALA_HELP += $(BUILD_HELP)\n

BUILD_HELP = \
	$(call help_section,Build) \
	$(call help,build,     Build packages)

build:
	$(call list_loop,PACKAGE,$(call list_partition,$(PARTITION_PART),$(PARTITION_PARTS),$(if $(PACKAGES),$(PACKAGES),$(PACKAGES_ALL))), \
		$$(call if_in,$$(PACKAGE),$$(PACKAGES_ALL), \
			$$(MAKE) --silent --directory=$$(PACKAGE) build, \
			$$(call log_error,Package \"$$(PACKAGE)\" is not available) ; exit 1 \
		), \
		TRAVIS_FOLD \
	)

BUILD_HELP += $(call help,build.diff,Build packages - Diff)
build.diff: PACKAGES = $(PACKAGES_DIFF)
build.diff: build

########
# Lint #
########

MANALA_HELP += $(LINT_HELP)\n

LINT_HELP = \
	$(call help_section,Lint) \
	$(call help,lint,     Lint packages)

lint:
	$(call list_loop,PACKAGE,$(call list_partition,$(PARTITION_PART),$(PARTITION_PARTS),$(if $(PACKAGES),$(PACKAGES),$(PACKAGES_ALL))), \
		$$(call if_in,$$(PACKAGE),$$(PACKAGES_ALL), \
			$$(MAKE) --silent --directory=$$(PACKAGE) lint, \
			$$(call log_error,Package \"$$(PACKAGE)\" is not available) ; exit 1 \
		), \
		TRAVIS_FOLD \
	)

LINT_HELP += $(call help,lint.diff,Lint packages - Diff)
lint.diff: PACKAGES = $(PACKAGES_DIFF)
lint.diff: lint

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

sync:
	$(call fail_if_not,$(FROM),FROM is empty or not set)
	$(call confirm,Please confirm sync from \"$(FROM)\" debian package)
	for PACKAGE in */; do \
		echo $$PACKAGE; \
		cp $$FROM/.gitignore $$PACKAGE; \
		cp $$FROM/.travis.yml $$PACKAGE; \
		cp -r $$FROM/.manala $$PACKAGE; \
	done
