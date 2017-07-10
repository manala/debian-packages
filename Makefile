.SILENT:
.PHONY: build-all build-diff sync split

############
# Packages #
############

PACKAGES_ALL  = $(sort $(subst /,,$(wildcard */)))
PACKAGES_DIFF = $(shell git diff --name-only | grep "/" | cut -d "/" -f1 | sort -u | tr "\n" " ")

##########
# Manala #
##########

include .manala/make/Makefile

#########
# Build #
#########

## Build all
build-all:
	$(call loop,$(PACKAGES_ALL), \
		$(MAKE) --directory=$$(ITEM) build$(if $(DEBIAN_DISTRIBUTION),.$(DEBIAN_DISTRIBUTION),-all), \
		Build package \"$$(ITEM)\"$(if $(DEBIAN_DISTRIBUTION), on \"$(DEBIAN_DISTRIBUTION)\") \
	)

## Build all - Wheezy
build-all.wheezy: build-all

## Build all - Jessie
build-all.jessie: build-all

## Build all - Stretch
build-all.stretch: build-all

## Build diff
build-diff: PACKAGES_ALL = $(PACKAGES_DIFF)
build-diff: build-all

## Build all - Wheezy
build-diff.wheezy: build-diff

## Build all - Jessie
build-diff.jessie: build-diff

## Build all - Stretch
build-diff.stretch: build-diff

########
# Sync #
########

## Sync all packages from
sync:
ifndef FROM
	printf "\n[$(COLOR_COMMENT)(╯°□°)╯︵ ┻━┻$(COLOR_RESET)] $(COLOR_ERROR)Variable FROM must be set.$(COLOR_RESET)\n\n"
endif
	printf "\n$(COLOR_INFO) ༼ つ ◕_◕ ༽つ $(COLOR_WARNING)Please confirm sync from \"$(FROM)\" debian package (y/N)$(COLOR_RESET): "
	read CONFIRM ; if [ "$$CONFIRM" != "y" ]; then printf "\n"; exit 1; fi
	printf "\n"
	for PACKAGE in */; do \
		echo $$PACKAGE; \
		cp $$FROM/.gitignore $$PACKAGE; \
		cp $$FROM/.travis.yml $$PACKAGE; \
		cp -r $$FROM/manala $$PACKAGE; \
	done

#########
# Split #
#########

## Split
split:
ifeq (${shell uname -s},Darwin)
	docker run \
		--rm \
		--tty --interactive \
		--volume ${PWD}:/srv \
		--volume ${HOME}/.ssh:/root/.ssh \
		jderusse/gitsplit
else
	docker run \
		--rm \
		--tty --interactive \
		--volume ${PWD}:/srv \
		--volume ${SSH_AUTH_SOCK}:/ssh-agent \
		--env SSH_AUTH_SOCK=/ssh-agent \
		jderusse/gitsplit
endif
