# Copyright © 2021 Luther Systems, Ltd. All right reserved.

PROTOC=protoc -I${GOPATH}/src -I/opt/proto/googleapis -I/opt/proto/grpc-gateway

MODEL_PROTOS=$(wildcard spb/*.proto)

.PHONY: build
build: ${ARTIFACTS}
	@

%.pb.go: %.proto ${MODEL_PROTOS}
	@echo "Building protos $@ ${VERSION}"
	protoc --version
	${PROTOC} \
		--go_out=plugins=grpc:${GOPATH}/src/ \
                $(abspath $<)
