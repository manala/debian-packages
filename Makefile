.SILENT:
.PHONY: help build sync split

## Colors
COLOR_RESET   = \033[0m
COLOR_ERROR   = \033[31m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

############
# Packages #
############

PACKAGES = $(shell git diff --name-only | grep "/" | cut -d "/" -f1 | sort -u | tr "\n" " ")
ifeq ($(PACKAGES),)
PACKAGES = $(wildcard */)
endif

# Help
help:
	printf "$(COLOR_COMMENT)Usage:$(COLOR_RESET)\n"
	printf " make [target]\n\n"
	printf "$(COLOR_COMMENT)Available targets:$(COLOR_RESET)\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " $(COLOR_INFO)%-16s$(COLOR_RESET) %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

#########
# Build #
#########

## Build - Wheezy
build.wheezy:
	EXIT=0 ; ${foreach \
		PACKAGE,\
		$(PACKAGES),\
		printf "\n$(COLOR_INFO)Build $(COLOR_COMMENT)$(PACKAGE)$(COLOR_RESET)\n\n" && $(MAKE) --directory=$(PACKAGE) build.wheezy || EXIT=$$? ;\
	} exit $$EXIT

## Build - Jessie
build.jessie:
	EXIT=0 ; ${foreach \
		PACKAGE,\
		$(PACKAGES),\
		printf "\n$(COLOR_INFO)Build $(COLOR_COMMENT)$(PACKAGE)$(COLOR_RESET)\n\n" && $(MAKE) --directory=$(PACKAGE) build.jessie || EXIT=$$? ;\
	} exit $$EXIT

## Build - Stretch
build.stretch:
	EXIT=0 ; ${foreach \
		PACKAGE,\
		$(PACKAGES),\
		printf "\n$(COLOR_INFO)Build $(COLOR_COMMENT)$(PACKAGE)$(COLOR_RESET)\n\n" && $(MAKE) --directory=$(PACKAGE) build.stretch || EXIT=$$? ;\
	} exit $$EXIT

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
