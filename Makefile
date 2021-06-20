# Copyright © 2021 Luther Systems, Ltd. All right reserved.

include common.mk

DOCKER_PROJECT_DIR:=$(call DOCKER_DIR, .)

BUILD_IMAGE=${BUILD_IMAGE_API}
PROTO_SOURCE_FILES=$(wildcard */*.proto)
PROTO_MODTIME=$(shell ls -lt */*.proto | head -n 1 | awk '{print $$6 " " $$7 " " $$8};')

BUILD_IMAGE_PROJECT_DIR=/go/src/${PROJECT_PATH}
BUILD_WORKDIR=${BUILD_IMAGE_PROJECT_DIR}

ARTIFACTS=$(patsubst %.proto,%.pb.go,${PROTO_SOURCE_FILES})

.PHONY: default
default: all

.PHONY: all
all: ${ARTIFACTS}

.PHONY: clean
clean:
	${RM} -f ${ARTIFACTS}

${ARTIFACTS}: ${PROTO_SOURCE_FILES}
	@echo "Building api $(notdir $@)"
	${DOCKER_RUN} \
		-u ${DOCKER_USER} \
		-v ${DOCKER_PROJECT_DIR}:${BUILD_IMAGE_PROJECT_DIR} \
		-v $(call DOCKER_DIR, .)/build.mk:/opt/Dockerfile.api.mk \
		-e PROJECT_PATH="${PROJECT_PATH}" \
		-e ARTIFACTS="${ARTIFACTS}" \
		-e VERSION="${VERSION} (${PROTO_MODTIME})" \
		-w ${BUILD_WORKDIR} \
		${BUILD_IMAGE}
	${CHOWN} ${CHOWN_USR}:${CHOWN_GRP} ${ARTIFACTS}
	${MKDIR_P} $(dir $@)
	${TOUCH} $@

# print out make variables, e.g.:
# make echo:VERSION
echo\:%:
	@echo $($*)
