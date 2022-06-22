# Copyright © 2021 Luther Systems, Ltd. All right reserved.

include common.mk

DOCKER_PROJECT_DIR:=$(call DOCKER_DIR, .)

BUILD_IMAGE=${BUILD_IMAGE_API}
PROTO_SOURCE_FILES=$(wildcard */*.proto)

BUILD_IMAGE_PROJECT_DIR=/go/src/${PROJECT_PATH}
BUILD_WORKDIR=${BUILD_IMAGE_PROJECT_DIR}

ARTIFACTS=$(patsubst %.proto,%.pb.go,${PROTO_SOURCE_FILES}) $(patsubst %.proto,%_grpc.pb.go,${PROTO_SOURCE_FILES})

.PHONY: default
default: all

.PHONY: all
all:
	@echo "Building api $(notdir $@)"
	buf generate

.PHONY: clean
clean:
	${RM} -f ${ARTIFACTS}

# print out make variables, e.g.:
# make echo:VERSION
echo\:%:
	@echo $($*)
