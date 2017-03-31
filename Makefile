.SILENT:
.PHONY: help build test split

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m

# Debian
DEBIAN_PACKAGES_DIFF = ${shell git diff --name-only | grep "/" | cut -d "/" -f1 | sort -u | tr "\n" " "}
ifeq (${DEBIAN_PACKAGES_DIFF},)
DEBIAN_PACKAGES_DIFF = ${wildcard */}
else
DEBIAN_PACKAGES_DIFF = ${DEBIAN_PACKAGES_DIFF}
endif

# Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' ${MAKEFILE_LIST}

#########
# Build #
#########

## Build
build:
	EXIT=0 ; ${foreach \
		image,\
		${DEBIAN_PACKAGES_DIFF},\
		printf "\n${COLOR_INFO}Build ${COLOR_COMMENT}${image}${COLOR_RESET}\n\n" && ${MAKE} --directory=${image} build || EXIT=$$? ;\
	} exit $$EXIT

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
