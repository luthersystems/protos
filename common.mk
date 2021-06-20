# Copyright © 2021 Luther Systems, Ltd. All right reserved.

PROJECT=protos
PROJECT_PATH=github.com/luthersystems/${PROJECT}

VERSION=0.1.0-SNAPSHOT
BUILD_ID=$(if $(CI),x,$(shell git rev-parse --short HEAD))
BUILD_VERSION=${VERSION}$(if $(findstring SNAPSHOT,${VERSION}),-${BUILD_ID},)

BUILDENV_TAG=0.0.39
BUILD_IMAGE_API=luthersystems/build-api:${BUILDENV_TAG}

ifeq ($(OS),Windows_NT)
	IS_WINDOWS=1
endif

RM=rm
DOCKER=docker
DOCKER_RUN_OPTS=--rm
DOCKER_RUN=${DOCKER} run ${DOCKER_RUN_OPTS}
CHOWN=$(if $(CIRCLECI),sudo chown,chown)
CHOWN_USR=$(LOGNAME)
CHOWN_USR?=$(USER)
CHOWN_GRP=$(if $(or $(IS_WINDOWS),$(CIRCLECI)),,admin)
DOCKER_USER="$(shell id -u ${CHOWN_USR}):$(shell id -g ${CHOWN_USR})"
DOMAKE=$(MAKE) -C $1 $2 # NOTE: this is not used for now as it does not work with -j for some versions of Make
MKDIR_P=mkdir -p
TOUCH=touch

DOCKER_WIN_DIR=$(shell cygpath -wm $(realpath $(1)))
DOCKER_NIX_DIR=$(realpath $(1))
DOCKER_DIR=$(if $(IS_WINDOWS),$(call DOCKER_WIN_DIR, $(1)),$(call DOCKER_NIX_DIR, $(1)))
