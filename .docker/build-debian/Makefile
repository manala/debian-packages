.SILENT:
.PHONY: run.image build.image test.image push.image

## Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m
COLOR_ERROR   = \033[31m

# Docker
DOCKER_IMAGE = manala/build-debian
DOCKER_TAG  ?= edge
IMAGE = ${DOCKER_IMAGE}:${DOCKER_TAG}-$(lastword ${DEBIAN_DISTRIBUTION})
VERSION := $(shell cat .docker/build-debian/VERSION)
ARCHITECTURE ?= linux/amd64 linux/arm64

# Debian
DEBIAN_DISTRIBUTION ?= stretch buster bullseye

#############
# Run image #
#############

## Run image
run.image:
	docker run \
		--rm \
		--platform ${ARCHITECTURE} \
		--volume `pwd`:/srv \
		--tty --interactive \
		--env USER_ID=`id -u` \
		--env GROUP_ID=`id -g` \
		${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)$(lastword ${DEBIAN_DISTRIBUTION})

## Run image - Run Stretch image amd64
run.image@stretch.amd64: DEBIAN_DISTRIBUTION = stretch
run.image@stretch.amd64: ARCHITECTURE = linux/amd64
run.image@stretch.amd64: run.image

## Run image - Run Buster image amd64
run.image@buster.amd64: DEBIAN_DISTRIBUTION = buster
run.image@buster.amd64: ARCHITECTURE = linux/amd64
run.image@buster.amd64: run.image

## Run image - Run Bullseye image amd64
run.image@bullseye.amd64: DEBIAN_DISTRIBUTION = bullseye
run.image@bullseye.amd64: ARCHITECTURE = linux/amd64
run.image@bullseye.amd64: run.image

## Run image - Run Bookworm image amd64
run.image@bookworm.amd64: DEBIAN_DISTRIBUTION = bookworm
run.image@bookworm.amd64: ARCHITECTURE = linux/amd64
run.image@bookworm.amd64: run.image

## Run image - Run Trixie image amd64
run.image@trixie.amd64: DEBIAN_DISTRIBUTION = trixie
run.image@trixie.amd64: ARCHITECTURE = linux/amd64
run.image@trixie.amd64: run.image

## Run image - Run Stretch image arm64
run.image@stretch.arm64: DEBIAN_DISTRIBUTION = stretch
run.image@stretch.arm64: ARCHITECTURE = linux/arm64
run.image@stretch.arm64: run.image

## Run image - Run Buster image arm64
run.image@buster.arm64: DEBIAN_DISTRIBUTION = buster
run.image@buster.arm64: ARCHITECTURE = linux/arm64
run.image@buster.arm64: run.image

## Run image - Run Bullseye image arm64
run.image@bullseye.arm64: DEBIAN_DISTRIBUTION = bullseye
run.image@bullseye.arm64: ARCHITECTURE = linux/arm64
run.image@bullseye.arm64: run.image

## Run image - Run Bookworm image arm64
run.image@bookworm.arm64: DEBIAN_DISTRIBUTION = bookworm
run.image@bookworm.arm64: ARCHITECTURE = linux/arm64
run.image@bookworm.arm64: run.image

## Run image - Run Trixie image arm64
run.image@trixie.arm64: DEBIAN_DISTRIBUTION = trixie
run.image@trixie.arm64: ARCHITECTURE = linux/arm64
run.image@trixie.arm64: run.image

###############
# Build Image #
###############

set_docker_builder:
	printf "\n${COLOR_INFO}Creating and setting docker builder ${COLOR_COMMENT}"cross_build"${COLOR_RESET}\n\n" && \
	docker buildx create --name cross_build --use

unset_docker_builder:
	printf "\n${COLOR_INFO}Removing docker builder ${COLOR_COMMENT}"cross_build"${COLOR_RESET}\n\n" && \
	docker buildx rm cross_build

## Build image
build.image: set_docker_builder
build.image:
	EXIT=0 ; ${foreach \
		distribution,\
		${DEBIAN_DISTRIBUTION},\
		printf "\n${COLOR_INFO}Build ${COLOR_COMMENT}${distribution}${COLOR_RESET}\n\n" && \
			docker buildx build \
				--platform linux/amd64,linux/arm64 \
				--push \
				--pull \
				--tag $(DOCKER_IMAGE):$(DOCKER_TAG)-$(lastword ${DEBIAN_DISTRIBUTION}) \
				--tag $(DOCKER_IMAGE):$(lastword ${DEBIAN_DISTRIBUTION}) \
				--tag $(DOCKER_IMAGE):$(VERSION)-$(lastword ${DEBIAN_DISTRIBUTION}) \
				--tag $(DOCKER_IMAGE):$(call semver_major_minor,$(VERSION))-$(lastword ${DEBIAN_DISTRIBUTION}) \
				--tag $(DOCKER_IMAGE):$(call semver_major,$(VERSION))-$(lastword ${DEBIAN_DISTRIBUTION}) \
				--tag ${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)${distribution} \
				--file .docker/build-debian/Dockerfile.${distribution} \
				. \
		|| EXIT=$$? ;\
	} exit $$EXIT
	$(MAKE) unset_docker_builder

## Build image - Build Stretch Image
build.image@stretch: DEBIAN_DISTRIBUTION = stretch
build.image@stretch: build.image

## Build image - Build Buster Image
build.image@buster: DEBIAN_DISTRIBUTION = buster
build.image@buster: build.image

## Build image - Build Bullseye Image
build.image@bullseye: DEBIAN_DISTRIBUTION = bullseye
build.image@bullseye: build.image

## Build image - Build Bookworm Image
build.image@bookworm: DEBIAN_DISTRIBUTION = bookworm
build.image@bookworm: build.image

## Build image - Build Trixie Image
build.image@trixie: DEBIAN_DISTRIBUTION = trixie
build.image@trixie: build.image

##############
# Test image #
##############

## Test image
test.image:
	EXIT=0 ; ${foreach \
		distribution,\
		${DEBIAN_DISTRIBUTION},\
			${foreach \
			architecture,\
			${ARCHITECTURE},\
				printf "\n${COLOR_INFO}Test ${COLOR_COMMENT}${distribution}-${architecture}${COLOR_RESET}\n\n" && \
					docker run \
						--rm \
						--platform ${architecture} \
						--volume `pwd`:/srv \
						--env DEBIAN_DISTRIBUTION=${DEBIAN_DISTRIBUTION}\
						${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)${distribution} \
						goss --gossfile /srv/.docker/build-debian/goss.yaml validate \
			|| EXIT=$$? ;\
		}} exit $$EXIT


## Test image - Test Stretch image
test.image@stretch: DEBIAN_DISTRIBUTION = stretch
test.image@stretch: test.image

## Test image - Test Buster image
test.image@buster: DEBIAN_DISTRIBUTION = buster
test.image@buster: test.image

## Test image - Test Bullseye image
test.image@bullseye: DEBIAN_DISTRIBUTION = bullseye
test.image@bullseye: test.image

## Test image - Test Bookworm image
test.image@bookworm: DEBIAN_DISTRIBUTION = bookworm
test.image@bookworm: test.image

## Test image - Test Trixie image
test.image@trixie: DEBIAN_DISTRIBUTION = trixie
test.image@trixie: test.image
