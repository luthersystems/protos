//go:build tools

// Package connectorhub pins the Go dependencies of the connectorhub protos.
//
// Why this file exists (#49): the generated *.pb.go files are gitignored, so
// without it the module has no Go files. `go mod tidy` (which Dependabot runs
// on every Go update) then sees no imports and drops every require, and the
// go.mod no longer pins the versions local `buf generate` output needs (#44,
// #45, #46 broke this way; #48 restored the requires by hand).
//
// The blank imports below are the non-standard packages that the generated
// code in connectors/v1 imports, so tidy keeps exactly those requires. When
// a connector proto starts to import a package from a new Go module, add it
// here. scripts/connectorhub-check.sh generates the code and fails when it
// needs a module that go.mod does not require.
//
// The tools build tag keeps this file out of every normal build. go mod tidy
// reads files of all build tags, so it still sees the imports.
package connectorhub

import (
	_ "buf.build/gen/go/luthersystems/protos/protocolbuffers/go/annotations/v1"
	_ "buf.build/gen/go/luthersystems/protos/protocolbuffers/go/common/v1"
	_ "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2/options"
	_ "google.golang.org/protobuf/reflect/protoreflect"
	_ "google.golang.org/protobuf/runtime/protoimpl"
)
