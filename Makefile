# Copyright © 2021 Luther Systems, Ltd. All right reserved.

include common.mk

DOCKER_PROJECT_DIR:=$(call DOCKER_DIR, .)

BUILD_IMAGE=${BUILD_IMAGE_API}
PROTO_SOURCE_FILES=$(wildcard */*.proto)

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
	bazel run :update_all

# updates generated bazel build files, formats and fixes lint issues
# https://github.com/bazelbuild/bazel-gazelle
# https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md
.PHONY: bazel-fix
bazel-fix:
	bazel run //:gazelle -- fix
	bazel run //:gazelle -- update-repos -from_file=go.mod -to_macro=repositories.bzl%gazelle_go_repositories
	bazel run //:buildifier
	bazel run //:buildifier -- --lint=fix

# print out make variables, e.g.:
# make echo:VERSION
echo\:%:
	@echo $($*)
