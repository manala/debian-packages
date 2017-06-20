.SILENT:
.DEFAULT_GOAL := help
.PHONY: help dev build

# Colors
MANALA_COLOR_RESET   = \033[0m
MANALA_COLOR_ERROR   = \033[31m
MANALA_COLOR_INFO    = \033[32m
MANALA_COLOR_WARNING = \033[33m
MANALA_COLOR_COMMENT = \033[36m

# Docker
DOCKER_IMAGE = manala/build-debian
DOCKER_TAG  ?=

########
# Help #
########

MANALA_HELP = \
	$(MANALA_COLOR_COMMENT)Usage:$(MANALA_COLOR_RESET)\
	\n  make [target]\n\
	\n$(MANALA_COLOR_COMMENT)Help:$(MANALA_COLOR_RESET)\
	\n  $(MANALA_COLOR_INFO)help:$(MANALA_COLOR_RESET) This help\
	\n

help:
	@printf "$(MANALA_HELP)"
	@awk '/^[a-zA-Z\-\_0-9\.@%]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  $(MANALA_COLOR_INFO)%-20s$(MANALA_COLOR_RESET) %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@printf "\n"

#######
# Log #
#######

define log
    printf "\n[$(MANALA_COLOR_COMMENT)$(shell date +"%T")$(MANALA_COLOR_RESET)][$(MANALA_COLOR_COMMENT)$(@)$(MANALA_COLOR_RESET)] $(MANALA_COLOR_INFO)$(1)$(MANALA_COLOR_RESET)\n\n"
endef

###########
# Confirm #
###########

confirm:
	@printf "\n$(MANALA_COLOR_INFO) ༼ つ ◕_◕ ༽つ $(MANALA_COLOR_WARNING)$(if $(CONFIRM_MESSAGE),$(CONFIRM_MESSAGE),Please confirm) (y/N)$(MANALA_COLOR_RESET): "
	@read CONFIRM ; if [ "$$CONFIRM" != "y" ]; then exit 1; fi

#######
# Dev #
#######

MANALA_HELP += \
	\n$(MANALA_COLOR_COMMENT)Dev:$(MANALA_COLOR_RESET)\
	\n  $(MANALA_COLOR_INFO)dev:$(MANALA_COLOR_RESET)         Dev

dev:
	docker run \
		--rm \
		--volume `pwd`:/srv \
		--tty --interactive \
		--env USER_ID=`id -u` \
		--env GROUP_ID=`id -g` \
		$(DOCKER_IMAGE):$(if $(DOCKER_TAG),$(DOCKER_TAG)-)$(lastword $(DEBIAN_DISTRIBUTION))

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTION)),)
MANALA_HELP += \
	\n  $(MANALA_COLOR_INFO)dev@wheezy:$(MANALA_COLOR_RESET)  Dev - Wheezy
dev@wheezy: DEBIAN_DISTRIBUTION = wheezy
dev@wheezy: dev
endif

ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTION)),)
MANALA_HELP += \
	\n  $(MANALA_COLOR_INFO)dev@jessie:$(MANALA_COLOR_RESET)  Dev - Jessie
dev@jessie: DEBIAN_DISTRIBUTION = jessie
dev@jessie: dev
endif

ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTION)),)
MANALA_HELP += \
	\n  $(MANALA_COLOR_INFO)dev@stretch:$(MANALA_COLOR_RESET) Dev - Stretch
dev@stretch: DEBIAN_DISTRIBUTION = stretch
dev@stretch: dev
endif

MANALA_HELP += \n

#########
# Build #
#########

MANALA_HELP += \
	\n$(MANALA_COLOR_COMMENT)Build:$(MANALA_COLOR_RESET)\
	\n  $(MANALA_COLOR_INFO)build:$(MANALA_COLOR_RESET)         Build

build:
	EXIT=0 ; $(foreach \
		distribution,\
		$(DEBIAN_DISTRIBUTION),\
		printf "\n$(MANALA_COLOR_INFO)Build $(MANALA_COLOR_COMMENT)$(distribution)$(MANALA_COLOR_RESET)\n\n" && \
			docker run \
			    --rm \
			    --volume `pwd`:/srv \
			    --tty \
					--env USER_ID=`id -u` \
					--env GROUP_ID=`id -g` \
			    $(DOCKER_IMAGE):$(if $(DOCKER_TAG),$(DOCKER_TAG)-)$(distribution) \
			    make do-build-package DEBIAN_DISTRIBUTION=$(distribution) \
		|| EXIT=$$? ;\
	) exit $$EXIT

do-build-package: build-package build-package-post

build-package-post:
	$(call log,Show packages informations)
	for i in ~/*.deb; do ls -lsah $$i; dpkg -I $$i; dpkg -c $$i; done

	$(call log,Move builded packages into build directory)
	mkdir -p /srv/build && mv ~/*.deb /srv/build

ifneq ($(filter wheezy,$(DEBIAN_DISTRIBUTION)),)
MANALA_HELP += \
	\n  $(MANALA_COLOR_INFO)build@wheezy:$(MANALA_COLOR_RESET)  Build - Wheezy
build@wheezy: DEBIAN_DISTRIBUTION = wheezy
build@wheezy: build
endif

ifneq ($(filter jessie,$(DEBIAN_DISTRIBUTION)),)
MANALA_HELP += \
	\n  $(MANALA_COLOR_INFO)build@jessie:$(MANALA_COLOR_RESET)  Build - Jessie
build@jessie: DEBIAN_DISTRIBUTION = jessie
build@jessie: build
endif

ifneq ($(filter stretch,$(DEBIAN_DISTRIBUTION)),)
MANALA_HELP += \
	\n  $(MANALA_COLOR_INFO)build@stretch:$(MANALA_COLOR_RESET) Build - Stretch
build@stretch: DEBIAN_DISTRIBUTION = stretch
build@stretch: build
endif

MANALA_HELP += \n

#########
# Local #
#########

-include Makefile.local
