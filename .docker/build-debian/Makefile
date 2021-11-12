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

# Debian
DEBIAN_DISTRIBUTION ?= stretch buster bullseye

#############
# Run image #
#############

## Run image
run.image:
	docker run \
		--rm \
		--volume `pwd`:/srv \
		--tty --interactive \
		--env USER_ID=`id -u` \
		--env GROUP_ID=`id -g` \
		${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)$(lastword ${DEBIAN_DISTRIBUTION})

## Run image - Run Stretch image
run.image@stretch: DEBIAN_DISTRIBUTION = stretch
run.image@stretch: run.image

## Run image - Run Buster image
run.image@buster: DEBIAN_DISTRIBUTION = buster
run.image@buster: run.image

## Run image - Run Bullseye image
run.image@bullseye: DEBIAN_DISTRIBUTION = bullseye
run.image@bullseye: run.image

###############
# Build Image #
###############

## Build image
build.image:
	EXIT=0 ; ${foreach \
		distribution,\
		${DEBIAN_DISTRIBUTION},\
		printf "\n${COLOR_INFO}Build ${COLOR_COMMENT}${distribution}${COLOR_RESET}\n\n" && \
			docker build \
				--pull \
				--tag ${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)${distribution} \
				--file .docker/build-debian/Dockerfile.${distribution} \
				. \
		|| EXIT=$$? ;\
	} exit $$EXIT

## Build image - Build Stretch Image
build.image@stretch: DEBIAN_DISTRIBUTION = stretch
build.image@stretch: build.image

## Build image - Build Buster Image
build.image@buster: DEBIAN_DISTRIBUTION = buster
build.image@buster: build.image

## Build image - Build Bullseye Image
build.image@bullseye: DEBIAN_DISTRIBUTION = bullseye
build.image@bullseye: build.image

##############
# Test image #
##############

## Test image
test.image:
	EXIT=0 ; ${foreach \
		distribution,\
		${DEBIAN_DISTRIBUTION},\
		printf "\n${COLOR_INFO}Test ${COLOR_COMMENT}${distribution}${COLOR_RESET}\n\n" && \
			docker run \
				--rm \
				--volume `pwd`:/srv \
				--env DEBIAN_DISTRIBUTION=${DEBIAN_DISTRIBUTION}\
				${DOCKER_IMAGE}:$(if ${DOCKER_TAG},${DOCKER_TAG}-)${distribution} \
				goss --gossfile /srv/.docker/build-debian/goss.yaml validate \
		|| EXIT=$$? ;\
	} exit $$EXIT


## Test image - Test Stretch image
test.image@stretch: DEBIAN_DISTRIBUTION = stretch
test.image@stretch: test.image

## Test image - Test Buster image
test.image@buster: DEBIAN_DISTRIBUTION = buster
test.image@buster: test.image

## Test image - Test Bullseye image
test.image@bullseye: DEBIAN_DISTRIBUTION = bullseye
test.image@bullseye: test.image


## Push image tag into repository (VERSION)
push.image:
	$(call confirm, Confirm pushing of image $(COLOR_COMMENT)$(DOCKER_IMAGE):${DEBIAN_DISTRIBUTION})
	docker push \
		$(DOCKER_IMAGE):$(DOCKER_TAG)-$(lastword ${DEBIAN_DISTRIBUTION})
	docker image tag \
		$(IMAGE) \
		$(DOCKER_IMAGE):$(VERSION)-$(lastword ${DEBIAN_DISTRIBUTION})
	docker push \
		$(DOCKER_IMAGE):$(VERSION)-$(lastword ${DEBIAN_DISTRIBUTION})
	docker image tag \
		$(IMAGE) \
		$(DOCKER_IMAGE):$(call semver_major_minor,$(VERSION))-$(lastword ${DEBIAN_DISTRIBUTION})
	docker push \
		$(DOCKER_IMAGE):$(call semver_major_minor,$(VERSION))-$(lastword ${DEBIAN_DISTRIBUTION})
	docker image tag \
		$(IMAGE) \
		$(DOCKER_IMAGE):$(call semver_major,$(VERSION))-$(lastword ${DEBIAN_DISTRIBUTION})
	docker push \
		$(DOCKER_IMAGE):$(call semver_major,$(VERSION))-$(lastword ${DEBIAN_DISTRIBUTION})

## Push image - Push Stretch image
push.image@stretch: DEBIAN_DISTRIBUTION = stretch
push.image@stretch: push.image

## Push image - Push Buster image
push.image@buster: DEBIAN_DISTRIBUTION = buster
push.image@buster: push.image

## Push image - Push Bullseye image
push.image@bullseye: DEBIAN_DISTRIBUTION = bullseye
push.image@bullseye: push.image
