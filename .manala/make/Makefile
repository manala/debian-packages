.PHONY: build lint split sync

##########
# Manala #
##########

MANALA_MAKE_DIR := $(abspath $(patsubst %/Makefile,%,$(lastword $(MAKEFILE_LIST))))

include \
	$(MANALA_MAKE_DIR)/Makefile.manala

-include \
	$(MANALA_CURRENT_DIR)/.env

MANALA_VERBOSE := $(if $(VERBOSE),$(VERBOSE),$(MANALA_VERBOSE))

############
# Packages #
############

PACKAGES_ALL  = $(filter-out $(PACKAGES_DEPRECATED),$(sort $(patsubst %/,%,$(wildcard */))))

#############
# Partition #
#############

PART ?= 1/1

PARTITION_PART  := $(call list_split_first,/,$(PART))
PARTITION_PARTS := $(call list_split_last,/,$(PART))

#########
# Build #
#########

## Build - Build Package
build:
	$(call list_loop,PACKAGE,$(call list_partition,$(PARTITION_PART),$(PARTITION_PARTS),$(if $(PACKAGES),$(PACKAGES),$(PACKAGES_ALL))), \
		$$(call if_in,$$(PACKAGE),$$(PACKAGES_ALL), \
			$$(MAKE) --silent --directory=$$(PACKAGE) build, \
			$$(call log_error,Package \"$$(PACKAGE)\" is not available) ; exit 1 \
		), \
		TRAVIS_FOLD \
	)

########
# Lint #
########

## Lint - Lint package
lint:
	$(call list_loop,PACKAGE,$(call list_partition,$(PARTITION_PART),$(PARTITION_PARTS),$(if $(PACKAGES),$(PACKAGES),$(PACKAGES_ALL))), \
		$$(call if_in,$$(PACKAGE),$$(PACKAGES_ALL), \
			$$(MAKE) --silent --directory=$$(PACKAGE) lint, \
			$$(call log_error,Package \"$$(PACKAGE)\" is not available) ; exit 1 \
		), \
		TRAVIS_FOLD \
	)

########
# Sync #
########

## Sync - Sync .gitignore and .manala
sync:
	$(call fail_if_not,$(FROM),FROM is empty or not set)
	$(call confirm,Please confirm sync from \"$(FROM)\" debian package)
	for PACKAGE in */; do \
		echo $$PACKAGE; \
		cp $$FROM/.gitignore $$PACKAGE; \
		cp -r $$FROM/.manala $$PACKAGE; \
	done
